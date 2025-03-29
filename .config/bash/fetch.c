#define _POSIX_C_SOURCE 200809L

#include <pthread.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/utsname.h>
#include <time.h>

#include "colour.h"
#include "config.h"

struct dist {
	char *getPkgCount;
};
struct dist info = {
	.getPkgCount = "echo unsupported",
};
char *username, *osname, *shellname, *pkgCount;
char *krnlver;
long uptimeH, uptimeM;

void lowerCase(char *str)
{
	const int len = strlen(str);
	int i;
	for (i = 0; i < len; i += 1)
		if (str[i] >= 'A' && str[i] <= 'Z')
			str[i] += 'a' - 'A';
}

void upperCase(char *str)
{
	const int len = strlen(str);
	int i;
	for (i = 0; i < len; i += 1)
		if (str[i] >= 'a' && str[i] <= 'z')
			str[i] += 'A' - 'a';
}

char *pipeRead(const char *exec)
{
	FILE *pipe = popen(exec, "r");
	if (pipe == NULL)
		return NULL;
	char *returnVal = malloc(256);
	const int scanf_return = fscanf(pipe, "%[^\n]256s", returnVal);
	pclose(pipe);
	if (scanf_return == EOF) {
		fprintf(stderr, "ERROR: scanf failed!\n");
		exit(EXIT_FAILURE);
	}
	return returnVal;
}

void *kernel()
{
	static struct utsname kernelData;
	uname(&kernelData);
	krnlver = kernelData.release;
	return NULL;
}

void *uptime()
{
	struct timespec time;
#if defined(CLOCK_BOOTTIME)
	#define CLOCK CLOCK_BOOTTIME
#elif defined(CLOCK_UPTIME)
	#define CLOCK CLOCK_UPTIME
#elif defined(__APPLE__)
	#define CLOCK CLOCK_MONOTONIC
#endif

#ifdef CLOCK
	clock_gettime(CLOCK, &time);
	uptimeH = time.tv_sec / 3600;
	uptimeM = (time.tv_sec / 60) - (time.tv_sec / 3600 * 60);
#endif
	return NULL;
}

void *user()
{
	username = getenv("USER");
	/* I'm not sure if lower case usernames
	   are allowed in UNIX-like operating
	   systems.
	   I'll have to look into it */
	/* username = lowerCase(username); */

	return NULL;
}

void *shell()
{
	char *shell = getenv("SHELL");
	char *slash = strrchr(shell, '/');
	if (slash) {
		shell = slash + 1;
	}
	shellname = shell;
	return NULL;
}

void *os()
{
	static struct utsname sysInfo;
	uname(&sysInfo);
	/* start */
	/* This whole section could probably be rewritten - it seems
	   like a bit of a mess right now */
	if (strncmp(sysInfo.sysname, "Linux", 5) == 0) {
		char *osContents = malloc(512);
		char *newContents = malloc(512);
		int line = 0;
		FILE *f = fopen("/etc/os-release", "rt");
		if (f == NULL || osContents == NULL)
			return "Linux";
		/* look through each line of /etc/os-release until we're on the
		 * NAME= line */
		while (fgets(osContents, 512, f)) {
			snprintf(newContents, 512, "%.*s", 511, osContents + 4);
			if (strncmp(newContents, "=", 1) == 0)
				break;
			line++;
		}
		fclose(f);
		free(osContents);
		if (strncmp(newContents, "=", 1) == 0) {
			int len = strlen(newContents);
			for (int i = 0; i < len; i++) {
				if (newContents[i] == '\"' ||
				    newContents[i] == '=') {
					for (int ii = 0; ii < len; ii++)
						newContents[ii] =
						    newContents[ii + 1];
					newContents[strlen(newContents) - 1] =
					    '\0';
				}
			}
		}
		if (osname == NULL)
			osname = malloc(512);
		strcpy(osname, newContents);
		free(newContents);
		/* end */
		if (strncmp(osname, "Debian GNU/Linux", 16) == 0) {
			info.getPkgCount =
				"dpkg -l | tail -n+6 | wc -l";
		} else if (strncmp(osname, "Ubuntu", 6) == 0) {
			info.getPkgCount =
				"dpkg -l | tail -n+6 | wc -l";
		}
	} else if (strncmp(sysInfo.sysname, "Darwin", 6) == 0) {
		if ((strncmp(sysInfo.machine, "iPhone", 6) == 0) || (strncmp(sysInfo.machine, "iPad", 4) == 0) || (strncmp(sysInfo.machine, "iPod", 4) == 0)) {
			info.getPkgCount =
		    "dpkg -l | tail -n+6 | wc -l";

			char *iosVer = malloc(1024);
			strcpy(iosVer, "iOS ");
			char *productVer = pipeRead("sw_vers -productVersion");

			strcat(iosVer, productVer);
			free(productVer);
			osname = iosVer;
			free(iosVer);
		} else {
			info.getPkgCount =
			    "ls /usr/local/Cellar/* | grep ':' | wc -l | xargs";

			char *macVer = malloc(64);
			strcpy(macVer, "macOS ");
			char *productVer = pipeRead("sw_vers -productVersion");

			strcat(macVer, productVer);
			free(productVer);
			osname = macVer;
			free(macVer);
		}
	} else if (strncmp(sysInfo.sysname, "FreeBSD", 7) == 0) {
		info.getPkgCount = "pkg info | wc  -l | tr -d ' '";
		osname = sysInfo.sysname;
	} else if (strncmp(sysInfo.sysname, "OpenBSD", 7) == 0) {
		info.getPkgCount =
		    "/bin/ls -1 /var/db/pkg/ | wc -l | tr -d ' '";
		osname = sysInfo.sysname;
	} else if (strncmp(sysInfo.sysname, "NetBSD", 6) == 0) {

	}
	pkgCount = pipeRead(info.getPkgCount);

	if (ForceLowerCase)
		lowerCase(osname);
	if (ForceUpperCase)
		upperCase(osname);
	return NULL;
}

void *colourDraw()
{
	if (PrintColours == false)
		return NULL;

	printf("    ");
	for (int i = 30; i < 38; i++) {
		printf("\033[0;%dm %s", i, ColourCharacter);
	} // print regular term colours
	printf("\n    ");
	for (int i = 30; i < 38; i++) {
		printf("\033[1;%dm %s", i, ColourCharacter);
	}

	printf("\n");
	return NULL;
}

int main()
{
	struct utsname sysInfo;
	uname(&sysInfo);
	pthread_t threads[6];

	pthread_create(&threads[0], NULL, user, NULL);
	pthread_create(&threads[1], NULL, os, NULL);
	pthread_create(&threads[2], NULL, kernel, NULL);
	pthread_create(&threads[3], NULL, uptime, NULL);
	pthread_create(&threads[4], NULL, shell, NULL);

	pthread_join(threads[0], NULL);
	/* os function must be run to get info.col1 */
	pthread_join(threads[1], NULL);
	printf("%s    %s%s%s\n", UserText, TextColour, username);
	printf("%s    %s%s%s\n", OsText, TextColour, osname);
	pthread_join(threads[2], NULL);
	printf("%s    %s%s%s\n", KernelText, TextColour, krnlver);
	pthread_join(threads[3], NULL);
	printf("%s    %s%s%ldh %ldm\n", UptimeText, TextColour, uptimeH,
	       uptimeM);
	pthread_join(threads[4], NULL);
	printf("%s    %s%s%s\n", ShellText, TextColour, shellname);
	printf("%s    %s%s%s\n", PackageText, TextColour, pkgCount);
	pthread_create(&threads[5], NULL, colourDraw, NULL);
	pthread_join(threads[5], NULL);
	printf("%s", RESET);
	return 0;
}

#include <pthread.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/utsname.h>
#include <time.h>

#include "colour.h"  // Ensure this includes all color definitions
#include "config.h"  // Ensure this defines all configuration variables

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
    for (int i = 0; i < len; i++) {
        if (str[i] >= 'A' && str[i] <= 'Z') {
            str[i] += 'a' - 'A';
        }
    }
}

void upperCase(char *str)
{
    const int len = strlen(str);
    for (int i = 0; i < len; i++) {
        if (str[i] >= 'a' && str[i] <= 'z') {
            str[i] += 'A' - 'a';
        }
    }
}

char *pipeRead(const char *exec)
{
    FILE *pipe = popen(exec, "r");
    if (pipe == NULL) return NULL;

    char *returnVal = malloc(256);
    if (fscanf(pipe, "%[^\n]", returnVal) == EOF) {
        fprintf(stderr, "ERROR: scanf failed!\n");
        exit(EXIT_FAILURE);
    }

    pclose(pipe);
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
    uptimeM = (time.tv_sec / 60) - (uptimeH * 60);
#endif
    return NULL;
}

void *user()
{
    username = getenv("USER");
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

    if (strncmp(sysInfo.sysname, "Linux", 5) == 0) {
        char *osContents = malloc(512);
        char *newContents = malloc(512);
        FILE *f = fopen("/etc/os-release", "rt");
        if (f == NULL || osContents == NULL)
            return "Linux";

        while (fgets(osContents, 512, f)) {
            snprintf(newContents, 512, "%.*s", 511, osContents + 4);
            if (strncmp(newContents, "=", 1) == 0)
                break;
        }
        fclose(f);

        if (osname == NULL)
            osname = malloc(512);
        strcpy(osname, newContents);
        free(newContents);
    } else if (strncmp(sysInfo.sysname, "Darwin", 6) == 0) {
        info.getPkgCount = "sw_vers -productVersion";
        osname = pipeRead(info.getPkgCount);
    } else {
        osname = sysInfo.sysname;
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
    if (!PrintColours) return NULL;

    for (int i = 30; i < 38; i++) {
        printf("\033[0;%dm %s", i, ColourCharacter);  // Regular colors
    }
    printf("\n");
    for (int i = 30; i < 38; i++) {
        printf("\033[1;%dm %s", i, ColourCharacter);  // Bright colors
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
    pthread_join(threads[1], NULL);  // Ensure os is fully initialized
    pthread_join(threads[2], NULL);
    pthread_join(threads[3], NULL);
    pthread_join(threads[4], NULL);

    // Print the output with colors, resetting the color after each field
    printf("%s%s%s\n", UserText, TextColour, username);
    printf("%s%s%s\n", OsText, TextColour, osname);
    printf("%s%s%s\n", KernelText, TextColour, krnlver);
    printf("%s%s%ldh %ldm\n", UptimeText, TextColour, uptimeH, uptimeM);
    printf("%s%s%s\n", ShellText, TextColour, shellname);
    printf("%s%s%s\n", PackageText, TextColour, pkgCount);

    pthread_create(&threads[5], NULL, colourDraw, NULL);
    pthread_join(threads[5], NULL);

    printf("\033[0m");  // Reset color at the end

    return 0;
}

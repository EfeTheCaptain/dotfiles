#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/utsname.h>
#include <pthread.h>
#include <time.h> // Include time.h for clock_gettime

#include "colour.h"
#include "config.h"

// Function Declarations
void *user();
void *os();
void *kernel();
void *uptime();
void *shell();
void *colourDraw();

// Global variables (declared in original code)
char *username, *osname, *shellname, *pkgCount;
char *krnlver;
long uptimeH, uptimeM;

int main() {
    struct utsname sysInfo;
    uname(&sysInfo);
    pthread_t threads[6];
    char output[1024];
    int offset = 0;

    pthread_create(&threads[0], NULL, user, NULL);
    pthread_create(&threads[1], NULL, os, NULL);
    pthread_create(&threads[2], NULL, kernel, NULL);
    pthread_create(&threads[3], NULL, uptime, NULL);
    pthread_create(&threads[4], NULL, shell, NULL);

    for (int i = 0; i < 5; i++) {
        pthread_join(threads[i], NULL);
    }

    offset += snprintf(output + offset, sizeof(output) - offset, "╭───%s%s%s\n│\n", UserText, TextColour, username);
    offset += snprintf(output + offset, sizeof(output) - offset, "├───%s%s%s\n│\n", OsText, TextColour, osname);
    offset += snprintf(output + offset, sizeof(output) - offset, "├───%s%s%s\n│\n", KernelText, TextColour, krnlver);
    offset += snprintf(output + offset, sizeof(output) - offset, "├───%s%ldh %ldm\n│\n", UptimeText, TextColour, uptimeH, uptimeM);
    offset += snprintf(output + offset, sizeof(output) - offset, "├───%s%s%s\n│\n", ShellText, TextColour, shellname);
    offset += snprintf(output + offset, sizeof(output) - offset, "╰───%s%s%s\n", PackageText, TextColour, pkgCount);

    printf("%s", output);

    pthread_create(&threads[5], NULL, colourDraw, NULL);
    pthread_join(threads[5], NULL);
    printf("%s", RESET);

    return 0;
}

// --- Function Definitions (from original code) ---

void lowerCase(char *str) {
    const int len = strlen(str);
    int i;
    for (i = 0; i < len; i += 1)
        if (str[i] >= 'A' && str[i] <= 'Z')
            str[i] += 'a' - 'A';
}

void upperCase(char *str) {
    const int len = strlen(str);
    int i;
    for (i = 0; i < len; i += 1)
        if (str[i] >= 'a' && str[i] <= 'z')
            str[i] += 'A' - 'a';
}

char *pipeRead(const char *exec) {
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

void *kernel() {
    static struct utsname kernelData;
    uname(&kernelData);
    krnlver = kernelData.release;
    return NULL;
}

void *uptime() {
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

void *user() {
    username = getenv("USER");
    return NULL;
}

void *shell() {
    char *shell = getenv("SHELL");
    char *slash = strrchr(shell, '/');
    if (slash) {
        shell = slash + 1;
    }
    shellname = shell;
    return NULL;
}

void *os() {
    static struct utsname sysInfo;
    uname(&sysInfo);
    // --- OS Detection Logic (from original code) ---
    if (strncmp(sysInfo.sysname, "Linux", 5) == 0) {
        char *osContents = malloc(512);
        char *newContents = malloc(512);
        int line = 0;
        FILE *f = fopen("/etc/os-release", "rt");
        if (f == NULL || osContents == NULL)
            return "Linux";
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
        // OS-specific package commands (from original code - adjust as needed)
        if (strncmp(osname, "Alpine Linux", 12) == 0) {
            info.getPkgCount =
                "grep 'P:' /lib/apk/db/installed | wc -l";
        } else if (strncmp(osname, "Arch Linux", 10) == 0) {
            info.getPkgCount = "pacman -Qq | wc -l";
        } else if (strncmp(osname, "Arch bang Linux", 15) ==
                0) {
            info.getPkgCount = "pacman -Qq | wc -l";
        } else if (strncmp(osname, "ArcoLinux", 9) == 0) {
            info.getPkgCount = "pacman -Qq | wc -l";
        } else if (strncmp(osname, "Artix Linux", 11) == 0) {
            info.getPkgCount = "pacman -Qq | wc -l";
        } else if (strncmp(osname, "CelOS", 5) == 0) {
            info.getPkgCount = "dpkg -l | tail -n+6 | wc -l";
        } else if (strncmp(osname, "Deepin", 6) == 0) {
            info.getPkgCount = "dpkg -l | tail -n+6 | wc -l";
        } else if (strncmp(osname, "Debian GNU/Linux", 16) ==
                0) {
            info.getPkgCount =
                "dpkg -l | tail -n+6 | wc -l";
        } else if (strncmp(osname, "Arch7", 10 ) == 0){
            info.getPkgCount = "pacman -Qq | wc -l";
        } else if (strncmp(osname, "elementary OS", 12) == 0) {
            info.getPkgCount =
                "dpkg -l | tail -n+6 | wc -l";
        } else if (strncmp(osname, "EndeavourOS", 11) == 0) {
            info.getPkgCount = "pacman -Qq | wc -l";
        } else if (strncmp(osname, "Fedora", 6) == 0) {
            info.getPkgCount =
                "[[ $(which sqlite3 2>/dev/null) && $? -ne "
                "1 ]] && (sqlite3 "
                "/var/lib/rpm/rpmdb.sqlite \"select * from "
                "Name\"|wc -l) || rpm -qa | wc -l";
        } else if (strncmp(osname, "Gentoo", 6) == 0) {
            info.getPkgCount = "qlist -IRv | wc -l";
        } else if (strncmp(osname, "KDE neon", 8) == 0) {
            info.getPkgCount =
                "dpkg -l | tail -n+6 | wc -l";
        } else if (strncmp(osname, "Linux Mint", 10) == 0) {
            info.getPkgCount = "dpkg -l | tail -n+6 | wc -l";
        } else if (strncmp(osname, "Manjaro", 7) == 0) {
            info.getPkgCount = "pacman -Qq | wc -l";
        } else if (strncmp(osname, "NixOS", 5) == 0) {
            info.getPkgCount =
                "nix-store -q --requisites "
                "/run/current-system/sw | wc -l";
        } else if (strncmp(osname, "openSUSE Leap", 10) == 0 ||
                strncmp(osname, "openSUSE Tumbleweed", 19) ==
                0) {
            info.getPkgCount = "rpm -qa | wc -l";
        } else if (strncmp(osname, "Parabola", 8) == 0) {
            info.getPkgCount = "pacman -Qq | wc -l";
        } else if (strncmp(osname, "Pop!_OS", 7) == 0) {
            info.getPkgCount =
                "dpkg -l | tail -n+6 | wc -l";
        } else if (strncmp(osname, "postmarketOS", 13) == 0) {
            info.getPkgCount =
                "grep 'P:' /lib/apk/db/installed | wc -l";
        } else if (strncmp(osname, "Slackware", 10) == 0) {
            info.getPkgCount =
                "ls /var/log/packages | wc -l";
        } else if (strncmp(osname, "Solus", 5) == 0) {
            info.getPkgCount =
                "ls /var/lib/eopkg/package/ | wc -l";
        } else if (strncmp(osname, "Ubuntu", 6) == 0) {
            info.getPkgCount =
                "dpkg -l | tail -n+6 | wc -l";
        } else if (strncmp(osname, "void", 4) == 0) {
            info.getPkgCount = "xbps-query -l | wc -l";
        } else if (strncmp(osname, "Zorin OS", 8) == 0) {
            info.getPkgCount = "dpkg -l | tail -n+6 | wc -l";
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
        // Add NetBSD support if needed
    }
    pkgCount = pipeRead(info.getPkgCount);

    if (ForceLowerCase)
        lowerCase(osname);
    if (ForceUpperCase)
        upperCase(osname);
    return NULL;
}

void *colourDraw() {
    if (PrintColours == false)
        return NULL;

    printf("    ");
    for (int i = 30; i < 38; i++) {
        printf("\033[0;%dm %s", i, ColourCharacter);
    }
    printf("\n    ");
    for (int i = 30; i < 38; i++) {
        printf("\033[1;%dm %s", i, ColourCharacter);
    }

    printf("\n");
    return NULL;
}

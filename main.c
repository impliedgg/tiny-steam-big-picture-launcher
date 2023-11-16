#include <windows.h>
#include <stdio.h>
#include <Processthreadsapi.h>

int main(int argc, char *argv[])
{
    STARTUPINFO steam_si;
    PROCESS_INFORMATION steam_pi;
    int ret = 0;

    ZeroMemory(&steam_si, sizeof(steam_si));
    steam_si.cb = sizeof(steam_si);
    ZeroMemory(&steam_pi, sizeof(steam_pi));

    if (!CreateProcessA(
            NULL, "\"C:\\Program Files (x86)\\Steam\\steam.exe\" -tenfoot", NULL, NULL, 1, 0x09000000, NULL, NULL, &steam_si, &steam_pi))
    {
        printf("failed to start steam (%d)\n", GetLastError());
        ret = 1;
    }
    else
    {
        CloseHandle(steam_pi.hProcess);
        CloseHandle(steam_pi.hThread);
    }

    STARTUPINFO explorer_si;
    PROCESS_INFORMATION explorer_pi;

    ZeroMemory(&explorer_si, sizeof(explorer_si));
    explorer_si.cb = sizeof(explorer_si);
    ZeroMemory(&explorer_pi, sizeof(explorer_pi));

    if (!CreateProcessA(
            NULL, "\"C:\\Windows\\explorer.exe\"", NULL, NULL, 1, 0x09000000, NULL, NULL, &explorer_si, &explorer_pi))
    {
        printf("failed to start explorer (%d)\n", GetLastError());
        ret = 2;
    }
    else
    {
        CloseHandle(explorer_pi.hProcess);
        CloseHandle(explorer_pi.hThread);
    }

    return ret;
}
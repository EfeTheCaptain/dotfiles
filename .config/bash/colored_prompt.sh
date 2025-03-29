#!/bin/bash

# Fetch and format the system information directly

# Read and format the CPU model (e.g., Intel(R) Atom(TM) CPU 550 @1.50GHz -> Intel-Atom-N550)
cpu_model=$(awk -F: '/model name/ {print $2}' /proc/cpuinfo | head -n 1 | sed 's/Intel/Intel-/; s/Atom/Atom-/; s/([^)]+)//g' | awk '{print $1"-"$2"-"$3}')

# Define the simplified prompt
PS1="\n╭──[$cpu_model] \n\
├[\u@\h]─[\w]\n\
╰──▶  "

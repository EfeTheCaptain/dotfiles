#!/bin/bash

# Fetch and format the CPU model correctly
cpu_model=$(grep -m 1 'model name' /proc/cpuinfo | sed -E 's/.*Intel.*Atom.*CPU ([0-9]+).*@([0-9.]+)GHz.*/Intel-Atom-\1/')

# Define the simplified prompt
PS1="\n╭──[$cpu_model] \n\
├[\u@\h]─[\w]\n\
╰──▶  "

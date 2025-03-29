#!/bin/bash

# Fetch and format the CPU model correctly
cpu_model=$(grep -m 1 'model name' /proc/cpuinfo | sed -E 's/.*Intel\(R\) Atom\(TM\) CPU ([0-9]+) @.*Ghz.*/Intel-Atom-\1/')

# Define the simplified prompt
PS1="\n╭──[$cpu_model] \n\
├[\u@\h]─[\w]\n\
╰──▶  "

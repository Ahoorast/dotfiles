#!/usr/bin/env bash

p=$(pwd)
echo "export PATH=\"\$PATH:$p\"" >> ~/.zshrc
source ~/.zshrc

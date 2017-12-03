#!/bin/bash
start=$SECONDS
./ms-time.sh ./test.sh
./ms-time.sh ./a.out
./ms-time.sh python3 test.py


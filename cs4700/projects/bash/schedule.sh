#!/bin/bash

declare -A schedule
schedule["Monday"]="Advanced Algorithms;9:30-10:25,"
schedule["Tuesday"]="Programming Languages;10:30-11:45,Technical Writing;12:00-13:15,Database Systems;13:30-14:45,Object Oriented Design;15:00-16:15,"
schedule["Wednesday"]="Advanced Algorithms;9:30-10:25,"
schedule["Thursday"]="Programming Languages;10:30-11:45,Technical Writing;12:00-13:15,Database Systems;13:30-14:45,Object Oriented Design;15:00-16:15,"
schedule["Friday"]="Advanced Algorithms;9:30-10:25,"

# Should now be able to access keys with date +%A

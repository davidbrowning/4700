#!/bin/bash

#######################################################################################
#
#  When you don't have time to set up your notes and just need to start writing.
#  Two test cases exist:
#   1) modify find_out_which_class as instructed below to run test case #1
#   2) uncomment line 98 for test case #2
#
#######################################################################################

schedule_file="schedule.sh"
if [ ! -f $schedule_file ]; then
  read -p "No schedule file found, would you like to make one? y/n: " ans
  if [ $ans == 'y' ]; then
    printf "declare -A schedule\n" >> $schedule_file
    read -p "Enter Monday schedule (format: <Couse Title>;<hour:minute>,)" monday
    read -p " Is Wednesday/Friday the same as Monday? y/n: " copymwf
    read -p "Enter Tuesday schedule (format: <Couse Title>;<hour:minute>,)" tuesday
    read -p " Is Thursday the same as Tuesday? y/n: " copytr
    if [ $copymwf != 'y' ]; then
      read -p "Enter Wednesday schedule (format: <Couse Title>;<hour:minute>,)" wednesday
      read -p "Enter Friday schedule (format: <Couse Title>;<hour:minute>,)" friday
    else
      wednesday=$monday
      friday=$monday
    fi
    if [ copytr != 'y' ]; then
      read -p "Enter Thursday schedule (format: <Couse Title>;<hour:minute>,)" thursday
    else
      thursday=$tuesday
    fi
    printf "schedule[monday]=$monday\n" >> $schedule_file
    printf "schedule[tuesday]=$tuesday\n" >> $schedule_file
    printf "schedule[wednesday]=$wednesday\n" >> $schedule_file
    printf "schedule[thursday]=$thursday\n" >> $schedule_file
    printf "schedule[friday]=$friday\n" >> $schedule_file
  fi
fi

source schedule.sh

function find_out_which_class () {
  # test case assumes you have the schedule.sh included in my repo
  # to run a test case, uncomment the following 3 lines, and comment out their corresponding ones.
  # day_schedge=${schedule[Tuesday]};
  # current_hour=10
  # current_minute=45
  day_schedge=${schedule[$(date +%A)]}; # 1
  current_time=$(date +%H%M); # 2
  number_of_classes=$(echo $day_schedge | grep -o ',' | wc -l);
  current_course="";
  for ((i = 1; i <= number_of_classes; i += 1)); do
    course_info=$(echo $day_schedge | cut -d ',' -f$i);
    course_name=$(echo $course_info | cut -d ';' -f1);
    time=$(echo $course_info | cut -d ';' -f2);
    start_time=$(echo $time | cut -d '-' -f1);
    end_time=$(echo $time | cut -d '-' -f2);
    course_start_hour=$(echo $start_time | cut -d ':' -f1);
    course_start_minute=$(echo $start_time | cut -d ':' -f2);
    course_start_time=$course_start_hour$course_start_minute
    echo "course start time:" $course_start_time

    course_end_hour=$(echo $end_time | cut -d ':' -f1);
    course_end_minute=$(echo $end_time | cut -d ':' -f2);
    course_end_time=$course_end_hour$course_end_minute
    
    if ([ $current_time -ge $course_start_time ]);
    then
      if ([ $current_time -le $course_end_time ]);
      then
        # you are currently in the time frame of the given course
        current_course=$course_name
      fi
    fi
  done
};

find_out_which_class
echo "You are currently in $current_course"

Y=$(date +%Y)
if [ ! -d $Y ]; then
  mkdir $Y
fi

cd $Y
m=$(date +%m)
if [ ! -d $m ]; then
  mkdir $m
fi

cd $m;
d=$(date +%d);
if [ ! -d $d ]; then
  mkdir $d
fi

cd $d

# Note: If you wish to run a test case, uncomment the following line 
# echo "preforming test case!"; current_course="Programming Languages" 
if [ -z $current_course ]; then current_course="No Title"; fi
notes_name=$(echo $current_course | cut -d ' ' -f1)
notes_name=$notes_name$(echo $current_course | cut -d ' ' -f2).tex
echo $notes_name
if [ ! -f $notes_name ]; then
  >$notes_name
  echo "\\title{$current_course}" >> $notes_name
  echo "\\author{$USER}" >> $notes_name
  echo "\\date{\\today}" >> $notes_name
  echo "\\documentclass[12pt]{article}" >> $notes_name
  echo "\\begin{document}" >> $notes_name
  echo "\\maketitle" >> $notes_name
  echo "\\section{Topics To Be Covered}" >> $notes_name
  echo "\\end{document}" >> $notes_name
else
  read -p "$notes_name already exists, do you want to overwrite? y/n: " a
  if [ $a == 'y' ]; then
    > $notes_name
    echo "\\title{$current_course}" >> $notes_name
    echo "\\author{$USER}" >> $notes_name
    echo "\\date{\\today}" >> $notes_name
    echo "\\documentclass[12pt]{article}" >> $notes_name
    echo "\\begin{document}" >> $notes_name
    echo "\\maketitle" >> $notes_name
    echo "\\section{Topics To Be Covered}" >> $notes_name
    echo "\\end{document}" >> $notes_name
  fi
fi
vim $notes_name +7
pdflatex $notes_name
echo "Path to your notes: $(pwd)"

exit

#!/bin/bash
schedule_file="schedule.sh"
if [ -z $(ls $schedule_file) ]; then
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
  #for the sake of testing, it is 10:45 on a Tuesday
  day_schedge_testing=${schedule[Tuesday]};
  current_hour_testing=10
  current_minute_testing=45
  day_schedge=${schedule[$(date +%A)]};
  current_hour=$(date +%H);
  current_minute=$(date +%M);
  number_of_classes=$(echo $day_schedge_testing | grep -o ',' | wc -l);
  current_course="";
  for ((i = 1; i <= number_of_classes; i += 1)); do
    course_info=$(echo $day_schedge_testing | cut -d ',' -f$i);
    course_name=$(echo $course_info | cut -d ';' -f1);
    time=$(echo $course_info | cut -d ';' -f2);
    start_time=$(echo $time | cut -d '-' -f1);
    end_time=$(echo $time | cut -d '-' -f2);
    course_start_hour=$(echo $start_time | cut -d ':' -f1);
    course_start_minute=$(echo $start_time | cut -d ':' -f2);
    course_end_hour=$(echo $end_time | cut -d ':' -f1);
    course_end_minute=$(echo $end_time | cut -d ':' -f2);
    if ([ $current_hour_testing -ge $course_start_hour ] && [ $current_minute_testing -ge $course_start_minute ]);
    then
      if ([ $current_hour_testing -le $course_end_hour ] && [ $current_minute_testing -le $course_end_minute ]);
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

if [ ! -f notes.tex ]; then
  >notes.tex
  echo "\\title{$current_course}" >> notes.tex
  echo "\\author{$USER}" >> notes.tex
  echo "\\date{\\today}" >> notes.tex
  echo "\\documentclass[12pt]{article}" >> notes.tex
  echo "\\begin{document}" >> notes.tex
  echo "\\maketitle" >> notes.tex
  echo "\\section{Topics To Be Covered}" >> notes.tex
  echo "\\end{document}" >> notes.tex
else
  read -p "notes.tex already exists, do you want to overwrite? y/n" a
  if [ $a == 'y' ]; then
    > notes.tex
    echo "\\title{$current_course}" >> notes.tex
    echo "\\author{$USER}" >> notes.tex
    echo "\\date{\\today}" >> notes.tex
    echo "\\documentclass[12pt]{article}" >> notes.tex
    echo "\\begin{document}" >> notes.tex
    echo "\\maketitle" >> notes.tex
    echo "\\section{Topics To Be Covered}" >> notes.tex
    echo "\\end{document}" >> notes.tex
  fi
fi
vim notes.tex +7
pdflatex notes.tex
echo "Path to your notes: $(pwd)"

exit

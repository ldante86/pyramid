#!/bin/bash -

SP="  "                      
SP7="    "                   
SP6="      "                 
SP5="        "               
SP4="            "                
SP3="               "              
SP2="                 "            
SP1="                   "          

PYRAMID="\
\n
${SP1}%s
${SP2}%s${SP}%s
${SP3}%s${SP}%s${SP}%s
${SP4}%s${SP}%s${SP}%s${SP}%s
${SP5}%s${SP}%s${SP}%s${SP}%s${SP}%s
${SP6}%s${SP}%s${SP}%s${SP}%s${SP}%s${SP}%s
${SP7}%s${SP}%s${SP}%s${SP}%s${SP}%s${SP}%s${SP}%s
\n\n"

n=1
for i in a b b c c c d d d d e e e e e f f f f f f g g g g g g g
do
  str="$str$i$n "
  ((n++))
done

printf "$PYRAMID" $str

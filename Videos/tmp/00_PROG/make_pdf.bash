#!/bin/bash


ls | grep mp4 | sed "s;mp4;;"|
while read f
	do 
 		cat $f"ssa" | grep Dia | sed "s;.*,,;;" | sed "s;^;\n;" | sed "s;\\\N;\n;g" | cat head - tail  > $f"tex"
		platex  $f"tex"
		sleep 1 
		dvipdfmx  $f"dvi"
	done


#後始末
ls | grep -E "(dvi|log|aux)"$ | xargs rm



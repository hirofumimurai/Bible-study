#!/bin/bash

ls | 
	grep _E_ | 
	grep ssa | 
	sed "s;ssa;;" | 
	while read f 
	do  
		TITLE=$(ffmpeg -i $f"mp4"  2>&1 | grep title | sed "s;^ *;;" | grep ^title | sed -r "s;(.*):(.*):;\2;" | sed "s; ;_;g" | sed "s;_;;"| nkf -jM)
		cat $f"ssa" | 
		grep -i dia | 
		sort | 
		sed "s;.*,,;;" | 
		sed "s;^;\n;" | 
		sed "s;\\\N;\n;" | 
		#mailx -s $(cat $(echo $f | sed "s;_E_;_J_;")"meta" | awk '{print $3}'| nkf -jM) murai_h22aa@icloud.com 
		mailx -s ${TITLE}  murai_h22aa@icloud.com 
	done

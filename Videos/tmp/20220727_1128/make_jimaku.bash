#!/bin/bash


DATE=$(date +"%Y%m%d_%H%M")

mkdir -p ${DATE}

find . -maxdepth 1 -type f | grep -E "(ssa|meta|mp4)" | xargs -I@ rm @

cat down | xargs -I@ axel -a @ 



ls | 
grep mp4 | 
while read f 
do  
 ffmpeg -i $f 2>&1 | 
 grep -E "(title|album)" | 
 grep -v Subtitle | 
 xargs >  $(echo $f| sed "s;mp4;meta;") 
done


ls |  
grep mp4 | 
xargs -I@ bash -c 'ffmpeg -i @ $(echo @| sed "s;mp4;ssa;"| sed "s;E;E2;")'


ls | 
grep E2 | 

while read f
do
 cat  $(echo $f| sed "s;E2;J;") |
 sed "s;Default;Default2;" |
 sed -n "13,$"p |
 cat  $f - > tmp1


EE=$(cat tmp1 | grep 'Style: Default,San'|sed 's@.*@Style: Default,Sans-Serif,14,\&Hffffff,\&Hffffff,\&H0,\&H0,0,0,0,0,100,100,0,0,1,1,0,7,10,10,10,0@1')

JJ=$(cat tmp1 | grep 'Style: Default,San'|sed 's@.*@Style: Default2,Sans-Serif,14,\&Hffffff,\&Hffffff,\&H0,\&H0,0,0,0,0,100,100,0,0,1,1,0,4,10,10,10,0@1')
echo -e  $(cat tmp1 | sed -n 1,8p)  "$EE\n$JJ\n"  $(cat tmp1 | sed -n "10,$"p) | nkf -wLux | sed "s;^ ;;" > $(echo $f| sed "s;E2;E;"| sed "s;mp4;ssa;") 

done

rm tmp1

cp down ${DATE}/
cp make_jimaku.bash ${DATE}/
cp send-mail.bash ${DATE}/

find . -maxdepth 1 -type f | grep -E "(ssa|meta|mp4)" | xargs -I@ cp @ ${DATE}/
find . -maxdepth 1 -type f | grep -E "(ssa|meta|mp4)" | xargs -I@ cp @ ../


/bin/bash send-mail.bash

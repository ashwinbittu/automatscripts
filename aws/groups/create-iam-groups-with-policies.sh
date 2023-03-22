sudo yum install dos2unix -y

INPUT=$1
OLDIFS=$IFS
IFS=',;'

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

dos2unix $INPUT

while read -r group policies || [ -n "$group" ]
do
        if [ "$group" != "group" ]; then
                aws iam create-group --group-name $group
                for policyname in $policies; do
                        echo $policyname | sed "s/\"//g" | xargs
                        aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/$(echo $policyname | sed "s/\"//g" | xargs) --group-name $group
                done
        fi       

done < $INPUT

sudo yum install dos2unix -y

INPUT=$1
OLDIFS=$IFS
IFS=',;'

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

dos2unix $INPUT

while read -r group policies || [ -n "$user" ]
do
   aws iam create-group --group-name $group
    

done < $INPUT



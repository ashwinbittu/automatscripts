sudo yum install dos2unix -y

sourcegroups=$1
OLDIFS=$IFS
IFS=',;'

[ ! -f $sourcegroups ] && { echo "$sourcegroups file not found"; exit 99; }

dos2unix $sourcegroups

while read -r group policies || [ -n "$group" ]
do
        if [ "$group" != "group" ]; then
                aws iam create-group --group-name $group
                for policyname in $policies; do
                        policyname=$(echo $policyname | sed "s/\"//g" | xargs)
                        echo "PLNAME-->"$policyname
                        policyarn=$(aws iam list-policies --query "Policies[?PolicyName=='$policyname'].Arn" --output text)
                        echo "PLARN-->"$policyarn
                        aws iam attach-group-policy --policy-arn $policyarn  --group-name $group
                done
        fi

done < $sourcegroups

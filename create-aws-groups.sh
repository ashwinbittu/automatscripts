sudo yum install dos2unix -y

INPUT=$1
OLDIFS=$IFS
IFS=',;'

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

dos2unix $INPUT

while read -r user group password || [ -n "$user" ]
do
    if [ "$user" != "user" ]; then
        aws iam create-user --user-name $user
        aws iam create-login-profile --password-reset-required --user-name $user --password $password
        aws iam add-user-to-group --group-name $group --user-name $user
    fi
    

done < $INPUT

policyname=$1
filename=$2

aws iam create-policy --policy-name $policyname --policy-document file://$filename

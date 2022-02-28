file="ip_adresses.txt"


declare -i count=1

#count=1
while IFS= read -r line; do
  echo "[runner-$count]" >> hosts
  echo "$line ansible_ssh_user=$1" >> hosts
  count=$count+1
done < "$file"


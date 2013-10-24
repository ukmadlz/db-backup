#!/bin/sh

# DB details
user=""
password=""

# Paths
repo_path=""

# Create SQL dump files
results=($(mysql -u ${user} -p${password} -Bse "SHOW DATABASES;"))

cnt=${#results[@]}

for (( i=0 ; i<${cnt} ; i++ ))
do

    if [ "${results[$i]}" != "information_schema" ]
    then
        
	mysqldump -u ${user} -p${password} ${results[$i]} > ${repo_path}/${results[$i]}.sql

    fi

done

# Commit to GIT
cd  ${repo_path}
git add .
git commit -m "Update SQL"
git push origin master

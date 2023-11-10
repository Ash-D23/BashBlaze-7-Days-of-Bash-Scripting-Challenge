#!/bin/bash

create_user(){
    read -p "Enter username" username
    if id -u "$1" >/dev/null 2>&1; then
        echo "Error: user already exists"
    else
        read -p "Enter Password" password
        useradd -d /home/$username -p password $password
        echo "User account created succesfully"
    fi 
}

delete_user(){
    read -p "Enter username" username
    if id -u "$1" >/dev/null 2>&1; then
        userdel -r $username
        echo "User account deleted succesfully"
    else
        echo "Error: User does not exists"
    fi 
    
}

reset_user(){
    read -p "Enter username" username
    read -p "Enter new password" newpassword
    chpasswd "$username:$newpassword"
    echo "User account password changed succesfully"
}

list_users(){
    a=($(awk -F':' '{ print $1}' /etc/passwd))
    echo "List of users:"
    for i in ${a[@]}
    do
        echo $i
    done
}

help(){
    echo "
        Usage: $0 [OPTIONS]
        Options:
          -c, --create     Create a new user account.
          -d, --delete     Delete an existing user account.
          -r, --reset      Reset password for an existing user account.
          -l, --list       List all user accounts on the system.
          -h, --help       Display this help and exit.
    "
}

if [ -z $1 ]
then 
    help
else
    if [ $1 = -c ] || [ $1 = --create ]
    then 
        create_user
    fi
    if [ $1 = -d ] || [ $1 = --delete ]
    then 
        delete_user
    fi
    if [ $1 = -r ] || [ $1 = --reset ]
    then 
        reset_user
    fi
    if [ $1 = -l ] || [ $1 = --list ]
    then 
        list_users
    fi
    if [ $1 = -h ] || [ $1 = --help ]
    then 
        help
    fi
fi
#!/bin/bash

DIR2="docs"
DIR3="tests/"

helpFunction()
{
   echo ""
   echo 'Usage:  -c create_folders -a "author" -m email -e venv '
   echo -e "\t-c Name of the root directory that starts the project"
   echo -e "\t-a Author"
   echo -e "\t-m Email"
   echo -e "\t-e Start Venv"
   exit 1 # Exit script after printing help
}


author(){
    email='E-mail: <>'
    if [ "$1" ];
    then
        FULL_NAME="$1 $2"
        PATHAPP=$3/$3/app.py
    else
        FULL_NAME="$1"
        PATHAPP=$2/$2/app.py
    fi
    if [ "$4" ];
    then
        email=$email$4
    fi
    author="Author: $FULL_NAME"
    created="Created at <$(date)>"
    sed -i '1i """\n'"$author\n$email\n$created"'\n"""\n\n\n'  $PATHAPP

}

create_folders(){
    if [ ! -d "$OPTARG" ] && [ ! -d "$DIR2" ] && [ ! -d "$DIR3" ];
    then
        mkdir -p $OPTARG/$OPTARG $OPTARG/$DIR2 $OPTARG/$DIR3
        touch $OPTARG/$OPTARG/app.py && echo -e "if __name__ == '__main__':\n\t..." > $OPTARG/$OPTARG/app.py
        touch $OPTARG/$OPTARG/__init__.py
        touch $OPTARG/README.md
        echo "Folder created successfully"
    else
        echo "Existing folders"
    fi

}
create_environment() {
    if [ $OPTARG == "venv" ];
    then
        cd $2/ && python -m venv venv
        echo "Venv created successfully!"
    fi

}
check() {
    # Print helpFunction in case parameters are empty
    if [ -z "$1" ]
    then
        echo "Some or all of the parameters are empty";
        helpFunction
    fi
}

while getopts e:c:a:m:h flag
    do
        case "$flag" in
            c) create_folders $OPTARG ;;
            e) create_environment $OPTARG ;;
            a) author $OPTARG $2 $6 ;;
            m)  ;;
            h) helpFunction ;; # Print helpFunction in carase parameter id non-existent
    esac
done



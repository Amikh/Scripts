#!/bin/bash

#--------------------------------------------------------------------
##=Name: RenameParams.sh
##
##=Purpose: Rename values from temp file and create news f
##
##=Parameters: -f|--common_file, -et|--environment_type, -p|--package, -an|--application_name, -h|--help
## In folder rresources - must have 3 files (name_list.txt ,value_list.txt, tmplet.txt)
## In this example: change Name and Value variable and create new file 
## 	
##=Author: Alexei Mikheev
##
##=Date: DEC-2020
##


# -------------------------------------------------------------------
# --     I N C L U D E  P C I  G E N E R A L  F U N C T I O N      --
# -------------------------------------------------------------------



# -------------------------------------------------------------------
# --       F U N C T I O N   D E F I N I T I O N                   --
# -------------------------------------------------------------------

function RenameValues
{
#create array from files
readarray -t name <resources/name_list.txt
readarray -t value <resources/value_list.txt


echo "Array name size : ${#name[*]}"
echo "Array value size: ${#value[*]}"
#create rsult folder for all files
mkdir $PWD/result
count=0;

 for nn in ${name[*]}
  do

       echo "The count "$count
       echo "NAME :" $nn
       echo "VALUE " ${value[$count]}

       n='__NAME__'
       v='__VALUE__'

       file="${nn}deploy.yml"
       cp resources/templet.txt  $file

       echo "The new file name: --------" $file

       sed -i "s|$n|$nn|g" $file
       sleep 1
       echo  ${value[$count]}
       sed -i "s|$v|${value[$count]}|g" $file
       count=$(( $count + 1 ))
       
       echo "Finish file : " $file
       # Finaly file move to result folder 
       mv $file  result/$file

 done
}

# -------------------------------------------------------------------
# --           M A I N   S E C T I O N                             --
# -------------------------------------------------------------------
RenameValues
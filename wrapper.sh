#!/bin/bash
#==============================================================================================================
# Scriptname 	    : wrapper.sh
# Description	    : This Script is a wrapper for converting Hive code to Dataproc compatible
# Parameters	    : 3 parameters - File Name, Source Type, Target Type
# Command : ./wrapper.sh <fileNm> <Source Type> <Tgt Type>  eg : sh wrapper.sh file.txt hive dataproc
# Change log below this line...
# Change History  :
# Infy Development Team            02 Dec 2019     Initial Version
# ----------------	           ------------    ---------------
# ----------------        	   ------------    ---------------
#================================================================================================================
## Execution : sh 

input_fn=$1
convSrcType=$2
convTgtType=$3

## Check no. of Arguments
if [[ $# -ne 3 ]]
    then
       echo "### ERROR : Illegal number of parameters. Please provide valid number of parameters. ###"
       exit 1
fi

./ paramFile.sh
 
echo -e "\n#### Input Parameters ####"
echo "Filename : $ $input_fn"
echo "Source Type : $convSrcType"
echo "Target Type : $convTgtType"
echo -e "\n#########################\n"

if [[ "${convSrcType}" == "hive" ||  "${convSrcType}" == "HIVE" &&  "${convTgtType}" == "dataproc" || "${convTgtType}" == "DATAPROC"  ]]
		then
                   echo "### INFO : Conversion Starting. ###"
			while read var
				do
					searchstring=`echo "$var"|awk -F "|" '{print $1}'`
					replacestring=`echo "$var"|awk -F "|" '{print $2}'`
					sed -i "s/${searchstring}/${replacestring}/g" ${input_fn}
				done < refList.conf
            if [[ $! -eq 0 ]]
                       then
                       ## Remove multiple occurences of -- params
		       sed -i "s/--params//2g" ${input_fn}
                       echo "### INFO : Conversion Successful. ###"
            else
                       echo "### ERROR : Conversion Failed. ### "
                       exit 1                       
            fi

else

		echo "Conversion from ${convSrcType} to ${convTgtType} not supported yet."
		exit 1

fi

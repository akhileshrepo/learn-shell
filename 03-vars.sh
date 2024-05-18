## Variables
#a=10
#echo a is  $a
#
## Special Variables
## $0 - $N, $*, $#
#
#echo file name - $0
#echo first argument - $1
#echo second argument - $2
#echo no. of arguments - $#
#echo all arguments - $*
#
## Substitution Variables
### Command Substitution
#DATE=$(date)
#
#echo Today Date is $DATE
#
### Arithmetic Substitution
#ADD=$(( 2+2 ))
#echo ADD of 2+2 = $ADD
#
## Access environment variables
#echo Username - $USER
#export abc=500
#echo Env Var abc - $abc
## export abc=100 from CLI can make this variable printed



#variable in shell scripting
a=100
echo "value of a - $a"
echo "File Name - $0"
echo "First Argument - $1"
echo "Second Argument - $2"
echo "All Arguments - $*"
echo "No of Arguments - $#"

#substitution variable
DATE=$(date)
echo "Today date is $DATE"

ADD=$((2+2))
echo "Total Sum is $ADD"

#Environmment variables
echo username - $USER
# Variables
a=10
echo a is  $a

# Special Variables
# $0 - $N, $*, $#

# Substitution Variables
## Command Substitution
DATE=$(date)

echo Today Date is $DATE

## Arithmetic Substitution
ADD=$(( 2+2 ))
echo ADD of 2+2 = $ADD

# Access environment variables
echo Username - $USER
echo Env Var abc - $abc
# export abc=100 from CLI can make this variable printed

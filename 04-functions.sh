#greeting() {
#  echo Hello, Good Mornign
#  echo Welcome to DevOps Training
#  return 8
#  echo Good to Have you hear.
#}
#
#
#greeting
#echo Function Exit Status - $?
#
## You declare var in main program, you can access that in function and vice-versa.
## Function have its own special variables
#
#input() {
#  echo First Argument - $1
#  echo Second Argument - $2
#  echo All Arguments - $*
#  echo No of Arguments - $#
#  echo script name - $0
#}
#
#input abc 1234


greeting() {
  echo "Hello Good Morning"
  echo "Welcome to devOps"
}

greeting
echo "Function exit status - $?"

input() {
  echo "First argument - $1"
  echo "Second argument - $2"
  echo "File name - $0"
  input 123 456
}

input abc xyz


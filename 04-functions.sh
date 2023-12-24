greeting() {
  echo Hello, Good Mornign
  echo Welcome to DevOps Training
  echo Good to Have you hear.
}


greeting
echo Function Exit Status - $?

# You declare var in main program, you can access that in function and vice-versa.
# Function have its own special variables

input() {
  echo First Argument - $1
  echo Second Argument - $2
  echo All Arguments - $*
  echo No of Arguments - $#
  echo script name - $0
}

input abc 1234

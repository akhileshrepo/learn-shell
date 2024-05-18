## Two basic loops
## for and while
#
## Based on expression
#a=10
#while [ $a -gt 0 ]; do
#  echo Hello
#  a=$(($a-1))
#  #break # this command can break the loop
#done
#for comp in frontend catalogue user ; do
#  echo Installing Component - $comp
#done


#for loop

for comp in frontend catalogue mongodb;do
  echo Installing component - $comp
done

#while loop
a=100
while [ $a -gt 0 ]; do
  echo "Hello world"
done


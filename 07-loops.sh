# Two basic loops
# for and while

# Based on expression
a=10
if [ $a -gt 0 ]; then
  echo "Hello world"
  a=$(($a-1))
  # break
fi

#Based on Input
for comp in frontend catalogue mongodb; do
  echo Installing component - $comp
done

#while loop
a=100
while [ $a -gt 0 ]; do
  echo "Hello world"
  a=$(($a-1))
  #break
done

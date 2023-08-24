curl -s $1 | grep nsecp |awk -F '[<>]' '{print $3}'

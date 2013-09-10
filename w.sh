check_connection()
{
	return 1
}

TIME=$(awk -F "=" '/TIME/{print $2}' w.ini)

while true
do
	if [ check_connection ];
	then
		echo "\n"
		wget -q -O weather.dump http://www.weathercity.com/by/minsk
		sed 's/<[^<>]*>//g' weather.dump | sed ':a;N;$!ba;s/\n/@/g' | \
		grep -w -Po 'Current Minsk(.*)Forecast Summary' | sed 's/@ //g' | \
		sed 's/@\+/@/g' | sed 's/&nbsp;/ /g' | sed 's/\s\+/ /g' | sed 's/@/\n/g' | cat
		sleep $TIME
	else
		echo "No Internet connection."
	fi
done

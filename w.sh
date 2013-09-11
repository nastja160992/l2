TIME=$(awk -F "=" '/TIME/{print $2}' w.ini)

while true
do
	if [ "$?" == "0" ];
	then
		wget -q -O w.dump http://www.weathercity.com/by/minsk
		sed 's/<[^<>]*>//g' w.dump | sed ':a;N;$!ba;s/\n/@/g' | \
		grep -w -Po 'Current Minsk(.*)Forecast Summary' | sed 's/@ //g' | \
		sed 's/@\+/@/g' | sed 's/&nbsp;/ /g' | sed 's/\s\+/ /g' | sed 's/@/\n/g' | \
		grep 'Temperature:' | sed 's/Temperature://g' | cat
		
	else
		echo "No Internet connection."
	fi
	sleep $TIME
done

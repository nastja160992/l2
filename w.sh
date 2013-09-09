check_connection()
{
	return 1
}

TIME=$(awk -F "=" '/TIME/{print $2}' weather.ini)

while true
do
	if [ check_connection ];
	then
		echo "\n"
		wget -q -O weather.dump http://www.weathercity.com/by/minsk
	else
		echo "No Internet connection."
	fi
done

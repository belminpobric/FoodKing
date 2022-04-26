# FoodKing
RS2 Seminarski rad

username: admin
password: test

.net 6

--Install Docker Desktop

docker pull mcr.microsoft.com/mssql/server:2017-latest


docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=<dbPass>" -p 1435:1433 -d mcr.microsoft.com/mssql/server:2019-latest

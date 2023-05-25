# FoodKing
docker run -d -p 15672:15672 -p 5672:5672 --name rabbit-test-for-medium rabbitmq:3-management
docker build . -t foodking

docker pull mcr.microsoft.com/mssql/server:2022-latest
docker run --name sql_2022 -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Bb123456!" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2022-latest

restore db
docker exec -it sql_2022 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Bb123456!" -Q "RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/food_king.bak'"
docker exec -it sql_2022 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Bb123456!" -Q "RESTORE DATABASE food_king FROM DISK = '/var/opt/mssql/backup/food_king.bak' WITH MOVE 'food_king' TO '/var/opt/mssql/data/food_king.mdf', MOVE 'food_king_log' TO '/var/opt/mssql/data/food_king.ldf'"
#userid -- ORACLE username/password@IP:PUERTO/SID
#control -- control file name
#log -- log file name
#bad -- bad file name
# userid=BD1/1234@34.125.195.78:1521/ORCL18
sqlldr userid=BRYAN/123@localhost:1521/ORCL18 control=ArchivoControl.ctl log=log/ArchivoControl.log bad=bad/ArchivoControl.bad
echo " "
echo -e "\e[96m  ENTER PARA CONTINUAR ... \e[0m"
read
# MSF SQL DATABASE PATCH
# Patch must be pasted manually into shell interface

service postgresql start
su postgres
createuser msf -P -S -R -D

#paste code above this line FIRST (enter required password: password)

#/usr/share/misc/msf_patch.sh follows:

createdb -O msf msf
exit
echo "production:" > /usr/share/metasploit-framework/config/database.yml
echo " adapter: postgresql" >> /usr/share/metasploit-framework/config/database.yml
echo " database: msf " >> /usr/share/metasploit-framework/config/database.yml
echo " username: msf " >> /usr/share/metasploit-framework/config/database.yml
echo " password: password" >> /usr/share/metasploit-framework/config/database.yml
echo " host: 127.0.0.1" >> /usr/share/metasploit-framework/config/database.yml
echo " port: 5432" >> /usr/share/metasploit-framework/config/database.yml
echo " pool: 75" >> /usr/share/metasploit-framework/config/database.yml
echo " timeout: 5" >> /usr/share/metasploit-framework/config/database.yml

sudo sh -c "echo export MSF_DATABASE_CONFIG=/usr/share/metasploit-framework/config/database.yml >> /etc/profile"
source /etc/profile
service postgresql restart
update-rc.d postgresql enable
bash
chmod +x /usr/share/misc/msf_patch.sh
echo 'alias patch="/usr/share/misc/msf_patch.sh"' >> /etc/bash.bashrc
source /etc/bash.bashrc
msfconsole -q
db_status

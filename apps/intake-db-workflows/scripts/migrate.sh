#!/usr/bin/env sh

#set -x

mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD"

for i in {30..0}; do
			if echo 'SELECT 1' | mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" &> /dev/null; then
				break
			fi
			echo 'MySQL init process in progress...'
			sleep 1
		done

for f in /home/schema/*; do
			case "$f" in
				*.sql)    echo "$0: running $f"; mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" < "$f"; echo ;;
				*.sql.gz) echo "$0: running $f"; gunzip -c "$f" | mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" ; echo ;;
				*)        echo "$0: ignoring $f" ;;
			esac
		echo
done

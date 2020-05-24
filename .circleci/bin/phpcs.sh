#!/bin/sh

LASTCOMMIT=`git rev-parse HEAD`
echo $LASTCOMMIT

# shellcheck disable=SC2006
PROJECT=`php -r "echo dirname(dirname(dirname(realpath('$0'))));"`
# shellcheck disable=SC2006
STAGED_FILES_CMD=`git diff --name-only HEAD~1 HEAD~2 | grep \\\.php`

# Determine if a file list is passed
if [ "$#" -eq 1 ]
then
	oIFS=$IFS
	IFS='
	'
	SFILES="$1"
	IFS=$oIFS
fi
SFILES=${SFILES:-$STAGED_FILES_CMD}

echo "Checking PHP Lint..."
ls -als
for FILE in $SFILES
do
  chmod +x $PROJECT/$FILE;
	php -l -d display_errors=0 $PROJECT/$FILE
	if [ $? != 0 ]
	then
		echo "Fix the error before commit."
		exit 1
	fi
	FILES="$FILES $PROJECT/$FILE"
done

if [ "$FILES" != "" ]
then
	echo "Running Code Sniffer..."
	echo $FILES
	./vendor/bin/phpcs --standard=$PROJECT/phpcs.xml --encoding=utf-8 -n -p $FILES
	if [ $? != 0 ]
	then
		echo "Coding standards errors have been detected. Running phpcbf..."
		./vendor/bin/phpcbf --standard=$PROJECT/phpcs.xml --encoding=utf-8 -n -p $FILES
		git add $FILES
		echo "Running Code Sniffer again..."
		./vendor/bin/phpcs --standard=$PROJECT/phpcs.xml --encoding=utf-8 -n -p $FILES
		if [ $? != 0 ]
		then
			echo "Errors found not fixable automatically"
			exit 1
		fi
	fi
fi

exit $?

ttree -v -a -r -s src -d docs -f /dev/null --wrapper=./src/head.tt --relative --suffix tt=html --copy '.(png|jpg)$'
sass --update src/css/:docs/css


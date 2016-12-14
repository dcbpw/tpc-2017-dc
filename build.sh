
ttree -v -a -r -s src -d docs -f /dev/null --wrapper=./src/head.tt --relative --suffix tt=html
sass --update src/css/:docs/css

# when-changed src/**/* -c ./build.sh
# live-server --wait=0

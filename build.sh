
ttree -v -r -s src -d docs -f /dev/null --wrapper=./src/head.html --relative
sass --update src/css/:docs/css

# when-changed src/**/* -c ./build.sh
# live-server --wait=0

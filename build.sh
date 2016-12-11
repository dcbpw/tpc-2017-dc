
ttree -r -s src -d docs -f /dev/null
sass --update src/css/:docs/css

# when-changed src/**/* -c ./build.sh
# live-server --wait=0

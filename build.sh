
ttree \
  --eval_perl \
  -v -a -r \
  -s src/tpc-2017-dc \
  -d docs/tpc-2017-dc \
  -f /dev/null \
  --wrapper=./src/tpc-2017-dc/head.tt \
  --relative \
  --suffix tt=html \
  --copy '.(png|jpg|js|csv)$'

sass --update src/tpc-2017-dc/css/:docs/tpc-2017-dc/css


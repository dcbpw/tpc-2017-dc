# tpc-2017-dc

## Dependencies

    # Works for Debian + perlbrew
    sudo apt-get install ruby-sass
    cpanm -qn Template Template::Plugin::Markdown

## Workflow

I like live-reload workflow, and I found this one that seems to work:

    npm install -g live-server

Then I do:

    live-server --wait=0 # window 1
    when-changed src/**/* -c ./build.sh # window 2
    touch src/**/* # window 3

This isn't quite right because ttree doesn't rebuild the indexes when I edit the header.


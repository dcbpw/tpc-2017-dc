# tpc-2017-dc

This is the website for The Perl Conference 2017 in Washington, DC.

## Dependencies

    # Works for Debian + perlbrew
    sudo apt-get install ruby-sass
    cpanm -qn Template Template::Plugin::Markdown

## Workflow

Run `./build.sh` to process everything in src and put it into docs. The files
in docs are what are actually served to end-users.

I like live-reload workflow, and I found this one that seems to work:

    # Prerequisite: Cool live-reload http server
    npm install -g live-server

    # Prerequisite: file watcher
    cpanm -qn App::watcher

    # Window 1: Serves static content and live-reloads when files change
    live-server --wait=0 --mount=/tpc-2017-dc:docs --open=/tpc-2017-dc

    # Window 2: Watch for file changes, and then re-execute the build script
    watcher --dir src -- ./build.sh

Then I edit the files in src and upon save the files are processed by `watcher`
and through a websocket my browser is instructed to reload. Magic!

Once you have your changes made, commit to a branch and make a PR. Upon merge
the changes will be live!


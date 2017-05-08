# tpc-2017-dc

This is the website for The Perl Conference 2017 in Washington, DC.

If you're looking to get a quick start with editing, jump to the
[Cookbooks](#cookbooks) session to get going as quick as possible. The
remaining documentation will hopefully help explain what you're doing if the
soup turns out wrong.

## Dependencies

At the least, to build the template files, you'll need the [sass][sass] gem,
as well as [Template Toolkit][tt] along with the [Markdown plugin][md] for
same.

On Debian, with Perlbrew and [App::cpanminus][cpanm] installed, you can run
the following commands to install the dependencies:

    sudo apt-get install ruby-sass
    cpanm -qn Template Template::Plugin::Markdown Text::CSV

We're assuming you're using [Perlbrew][pb], which makes it so you can install
CPAN modules in your own home directory. If you don't have that (or
[plenv][]), then you can run it via `sudo` instead to install on the whole
system.

From here, you can build the source templates into compiled HTML files ready
to deploy onto a static server such as GitHub Pages with the following
command:

    ./build.sh

Alternately, if you've got [Bundler][bundler] and [Carton][carton] installed,
you can install dependencies locally to the project with the following
commands:

    carton install
    bundle install --path=vendor --binstubs

Note that this will also install some optional dependencies that may make
development easier, see below. Also note that, in order to access the binaries
installed this way, you will need to preface commands with `bundle exec` and
`carton exec`, which you can do in one go, so:

    ./build.sh # assumes globally-installed binaries

    # do this instead to build the $PATH dynamically for Bundler and Carton:
    bundle exec carton exec ./build.sh

That's a lot to type! See [below](#workflow) for a workflow to keep from
having to type these commands out for every edit.

## Workflow

The default is to run `./build.sh` to process everything in `src/` and put it
into `docs/`. The files in `docs` are what are actually served to end-users.
This runs [Template Toolkit][tt] and [sass][sass].

Running `./build.sh` is a one-time build, and afterwards you can refresh your
browser in the local directory to see the changes. However, if you install the
[live-server][ls] module from Node, you can skip the part about refreshing; it
runs a server which injects code to make your browser automatically refresh
when the page has changed.

Like above, you can install this globally in node, or with the `package.json`
file. You have to execute the binary a little differently depending on how you
install it.

    # Install live-server globally
    npm install -g live-server

    # Run live-server from a global location
    live-server --wait=0 --mount=/:docs --open=/tpc-2017-dc

    # OR

    # Install live-server into node_modules/ via package.json
    npm install

    # Run live-server from the local location
    ./node_modules/.bin/live-server --wait=0 --mount=/:docs --open=/tpc-2017-dc

Once again, the install-locally option seems to involve a lot more work, but
it eventually works nicely; we're getting there.

Also, regenerating the source by hand by running `./build.sh` is a pain. So,
you can install [App::watcher][aw], which keeps an eye on your `src/`
directory and automatically kicks off a build into `docs/` for you. You can
do it globally:

    cpanm -qn App::watcher

Or, if you ran `carton install` earlier, you've already got it.

In a separate window from your `live-server` window, you can run the
following, depending on how you installed your dependencies:

    # When everything is installed globally:
    watcher --dir src -- ./build.sh

    # When everything is installed via Carton/Bundler:
    carton exec watcher --dir src -- bundle exec ./build.sh

Then you edit the files in `src/`, and upon save the files are processed by
`watcher` and through a websocket your browser is instructed to reload. Magic!

This eventually gets a little hairy, though. You've got to manage three
different terminal windows, and if you've installed things locally, remember a
few different really long command strings. However, if you've done the hard
thing and installed locally, you also got the `tmuxinator` gem, and you can
use it to kick off a new `tmux` session with two windows already running to
process your directory and reload your site in the background. So, all you'd
need to do to start a `tmux`-based live-reload workflow is:

    ./bin/tmuxinator start .

## Adding your changes

Once you're happy with the changes you've made, please commit everything,
including both the template files in `src/` **as well as** the generated HTML
files in `docs/`, and create a pull request on GitHub. We use GitHub Pages to
host our site, and it needs the static files to serve, while we need the
template files to keep improving the site.

Once your pull request is approved and merged, your changes will automatically
be live! Huzzah!

## Cookbooks

If you don't want to read the above documentation in full, pick one of the
following sections and this should hopefully get you up and running pretty
quickly:

### Use global installations (easiest on Linux systems such as Debian)

    # Install required depdencies
    sudo apt-get install ruby-sass
    sudo cpan Template Template::Plugin::Markdown

    # Install optional dependencies
    sudo cpan App::watcher
    npm install -g live-server

    # Option 1: Build the templates just once
    ./build.sh

    # Option 2: run a live-reload process:
    #  - Run live-server in its own window to serve the site locally
    live-server --wait=0 --mount=/:docs --open=/tpc-2017-dc
    #  - Run watcher in its own window to re-process the code as you edit
    watcher --dir src -- ./build.sh
    #  - Run a third window or separate editor to edit your files

### Use local installations (easiest with rbenv/plenv/nodenv, and tmux)

    # Install required dependencies
    carton install
    bundle install --path=vendor --binstubs
    npm install

    # Option 1: Build the templates just once:
    carton exec bundle exec ./build.sh

    # Option 2: Run a tmux-based live-reload workflow
    ./bin/tmuxinator start .

(See also for pre-requisites: [rbenv][], [plenv][], [nodenv][], [tmux][])

-----

[sass]:    https://rubygems.org/gems/sass/versions/3.4.22
[tt]:      http://www.template-toolkit.org/
[md]:      https://metacpan.org/pod/Template::Plugin::Markdown
[cpanm]:   https://metacpan.org/pod/App::cpanminus
[pb]:      https://perlbrew.pl/
[bundler]: http://bundler.io/
[carton]:  https://metacpan.org/pod/Carton
[ls]:      http://tapiov.net/live-server/
[aw]:      https://metacpan.org/pod/App::watcher

[rbenv]:  https://github.com/rbenv/rbenv
[plenv]:  https://github.com/tokuhirom/plenv
[nodenv]: https://github.com/nodenv/nodenv
[tmux]:   https://tmux.github.io/

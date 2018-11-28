[![Travis CI Build Status](https://travis-ci.org/bu-ist/sample-plugin.svg?branch=master)](https://travis-ci.org/bu-ist/sample-plugin)
[![CircleCI](https://circleci.com/gh/bu-ist/sample-plugin.svg?style=shield)](https://circleci.com/gh/bu-ist/sample-plugin)
## Running Tests
1. Download https://github.com/bu-ist/sample-plugin/archive/master.zip
2. Copy everything (don't forget about hidden dot files like .travis.yml) into your plugin/theme except the following:  `README.md`, `sample-plugin.php`, `.git`, `.gitignore`.
3. Update settings in the `tests/bootstrap.php` file to reflect your plugin/theme.
4. Write tests.
5. If this is not the first run,cleanup from the files and database from prior runs:
	```
    ls /tmp/wordpress*
    rm -fr /tmp/wordpress*
    echo "drop database wordpress_test" | mysql -u root
	```

6. Install WP tests:
	```
    bash bin/install-wp-tests.sh wordpress_test root '' localhost latest
	```

7. Run phpunit in the plugin’s root directory

	```
    phpunit
	```

## Trouble Shooting

If you run into problems with the `phpunit` command reporting that it's unable to connect to your database, it could be the case that php is tying to use a socket that isn't available. This can happen when you installed mysql with homebrew, while using the default php installation on OSX. To debug this a issue, run the following commands to figure out which socket php is trying to use, and which socket your mysql server is using.

```
php -i | fgrep 'mysql.default_socket'
mysql -e 'show variables where variable_name = "socket"'
```

One potential fix for this specific scenario is to symlink the php default socket to the one used by the homebrew's mysql server.

```
sudo ln -s /tmp/mysql.sock /var/mysql/mysql.sock
```

## Running Code Climate locally

### Prerequisites

To run code climate locally, grab an existing plugin or theme's .codeclimate.yml file:

- For plugins, use the one from the [sample plugin repo](https://github.com/bu-ist/sample-plugin/blob/master/.codeclimate.yml).
- For themes, use the one from the [responsive framework's child-starter](https://github.com/bu-ist/responsive-child-starter/blob/develop/.codeclimate.yml).

Next, follow the instructions listed on the [Code Climate repo](https://github.com/codeclimate/codeclimate/#prerequisites), or continue by installing the prerequisites that are listed:

- [Docker](https://www.docker.com/), or use [Docker for Mac](https://docs.docker.com/docker-for-mac/) for macOS.
- [Homebrew](https://brew.sh/) (only if on macOS)

### Installation

_Note: All of this information is available on the [Code Climate repo](https://github.com/codeclimate/codeclimate/). To continue, make sure you have [Docker](https://www.docker.com/), or [Docker for Mac](https://docs.docker.com/docker-for-mac/) for macOS._

To run Code Climate reports locally, the Docker image must be installed on your machine.

Run the following command in a Terminal session to pull down the Docker image:

```
docker pull codeclimate/codeclimate
```

This will download the Docker image that code climate will use to run its
analysis tools.

After that finishes, code climate can now be run using the following example
command:
```
docker run \
  --interactive --tty --rm \
  --env CODECLIMATE_CODE="$PWD" \
  --volume "$PWD":/code \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /tmp/cc:/tmp/cc \
  codeclimate/codeclimate help
```

But since that's a burden to type each time, it is preferred to use Code
Climate's wrapper scripts.

#### Install script for macOS using Homebrew

The easiest way to install the `codeclimate` command on macOS is with the homebrew
package manager. [Install homebrew before continuing](https://brew.sh/).
Otherwise, continue on to the next step.

In a Terminal session, run the following commands:

1. `brew tap codeclimate/formulae`
1. `brew install codeclimate`

#### Install script for any os (Windows, Linux, etc)

If on Windows or another operating system, run the following commands:

1. `curl -L https://github.com/codeclimate/codeclimate/archive/master.tar.gz | tar xvz`
1. `cd codeclimate-* && sudo make install`

### Example commands

If using the wrapper scripts, the `codeclimate` command should be available.
Test it by running `codeclimate version`.

A list of commands is available on the [Code Climate GitHub page](https://github.com/codeclimate/codeclimate/#commands).
The following commands can be run in the root of your repository:

#### Analyze the entire repo

```
codeclimate analyze
```

#### Analyze just one file

```
codeclimate analyze includes/functions.php
```

#### Validate the contents of your codeclimate file

```
codeclimate validate-config
```

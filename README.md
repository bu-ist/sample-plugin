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

To run Code Climate reports locally, it must be installed on your machine.
Directions to install locally are on the Code Climate GitHub repository
https://github.com/codeclimate/codeclimate/.

The easiest way to install the `codeclimate` command is with the homebrew
package manager. [Install homebrew before continuing](https://brew.sh/).
Otherwise, continue on to the next step.

In a Terminal session, run the following commands:

1. `brew tap codeclimate/formulae`
1. `brew install codeclimate`

Now you should have the `codeclimate` command available. Test it by running
`codeclimate version`.

A list of commands is available on the [Code Climate GitHub page](https://github.com/codeclimate/codeclimate/#commands).

### Example commands

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

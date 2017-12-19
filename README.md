[![Travis CI Build Status](https://travis-ci.org/bu-ist/sample-plugin.svg?branch=master)](https://travis-ci.org/bu-ist/sample-plugin)
[![CircleCI](https://circleci.com/gh/bu-ist/sample-plugin.svg?style=shield)](https://circleci.com/gh/bu-ist/sample-plugin)
## Adding CI tests to existing plugin/theme
1. Download https://github.com/bu-ist/sample-plugin/archive/master.zip
1. Copy everything (don't forget about hidden dot files like .travis.yml) into your plugin/theme except the following:  `README.md`, `sample-plugin.php`, `.git`, `.gitignore`.
1. Update settings in the `tests/bootstrap.php` file to reflect your plugin/theme.
1. Write tests.
## Running tests locally in docker
1. Run the wpdc up command to initialize and setup docker containers
	```
	bash bin/wpdc.sh up
	```
1. Run the wpdc test command to run phpunit (as long as the containers are running, you can edit your files and run this command as many times as you want)
	```
	bash bin/wpdc.sh test
	```
1. Run the wpdc down command to stop and remove containers
	```
	bash bin/wpdc.sh down
	```

## bin/wpdc.sh commands
### `up`
Starts docker containers and sets up WordPress testing environment so that we can use the test command.
##### Usage
```
bash bin/wpdc.sh up [php-version] [wp-version]
```
It takes 2 optional arguments:
1. `[php-version]`
	
	The php version we want to test. Normally a 2 digit version like `5.6`, `7.0`, `7.1`. It defaults to latest (which at the moment resolves to `7.1` but can change in the future).
1. `[wp-version]`

	The WordPress version we want to test. It can be a 1, 2 or 3 digit version like: `4`, `4.9`, `4.7.3`. It defaults to latest.

##### Examples
```
bash bin/wpdc.sh up
bash bin/wpdc.sh up latest
bash bin/wpdc.sh up latest latest
bash bin/wpdc.sh up 7.0
bash bin/wpdc.sh up 7.0 latest
bash bin/wpdc.sh up latest 4.6
bash bin/wpdc.sh up 7.1-apache 4.7
bash bin/wpdc.sh up latest 4.8
bash bin/wpdc.sh up 5.6 4.3
```
### `down`
Stops and removes everything created with the up command.
##### Usage
```
bash bin/wpdc.sh down
```
It takes no arguments.
### `test`
Runs the phpunit tests inside the docker container.
##### Usage
```
bash bin/wpdc.sh test
```
It takes no arguments.

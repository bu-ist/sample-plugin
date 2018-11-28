[![Travis CI Build Status](https://travis-ci.org/bu-ist/sample-plugin.svg?branch=master)](https://travis-ci.org/bu-ist/sample-plugin)
[![CircleCI](https://circleci.com/gh/bu-ist/sample-plugin.svg?style=shield)](https://circleci.com/gh/bu-ist/sample-plugin)
## Adding CI tests to existing plugin/theme
1. Download https://github.com/bu-ist/sample-plugin/archive/master.zip
1. Copy everything (don't forget about hidden dot files like .travis.yml) into your plugin/theme except the following:  `README.md`, `sample-plugin.php`, `.git`, `.gitignore`.
1. Update settings in the `tests/bootstrap.php` file to reflect your plugin/theme.
1. Write tests.
## Running tests locally in docker
#### Requirements
It requires docker and docker-compose to be installed in your machine.

You can download it here https://www.docker.com/community-edition#/download.

Note: docker-compose comes with Docker for Mac and Docker for Windows. On linux you need to install docker-compose separately.

#### Steps
1. Go to the plugin/theme directory.
	```
	cd /path/to/plugin
	```
1. Run the [wpdc up](#up) command to initialize and setup docker containers.
	```
	bash bin/wpdc.sh up
	```
1. Run the [wpdc test](#test) command to run phpunit (as long as the containers are running, you can edit your files and run this command as many times as you want).
	```
	bash bin/wpdc.sh test
	```
1. Run the [wpdc down](#down) command to stop and remove containers when you are done testing.
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
### Code Climate Troubleshooting

You can debug and modify how your commands run by adding additional
flags. See the [Code Climate repo](https://github.com/codeclimate/codeclimate#environment-variables)
for official definitions of each flag. As an overview, these are the following
known flags:

#### Run codeclimate in debug mode:

```
CODECLIMATE_DEBUG=1 codeclimate analyze
```

Prints additional information about the analysis steps, including any stderr produced by engines.

#### Increase timeout

To increase the amount of time each engine container may run (default 15 min):

```
# 30 minutes
CONTAINER_TIMEOUT_SECONDS=1800 codeclimate analyze
```

#### Increase memory
You can also configure the default alotted memory with which each engine runs (default is 1,024,000,000 bytes):

```
# 2,000,000,000 bytes
ENGINE_MEMORY_LIMIT_BYTES=2000000000 codeclimate analyze
```

#### The analyze script is taking forever to run

This could be due to a variety of factors:

- It could be hanging up on installing engines. Try running
`codeclimate engines:install` first, before running `codeclimate analyze`
- There are a very large number of files in your repository that Code Climate
  is trying to analyze at once. Be sure to specify all files and directories you
  want Code Climate to skip using the `exclude_patterns` key in the yaml config
  file.
- It could be hanging up on some assets that its trying to download in the
  `prepare` > `fetch` key in the yaml config file. Make sure the repos are all
  public.
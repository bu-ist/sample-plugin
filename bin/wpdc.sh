#!/usr/bin/env bash

# Remove any existing containers and volumes
spin_down(){
  printf "Cleaning up any existing containers\n\n"
  docker-compose down -v
}

spin_up() {
  # Read in extra parameters passed with the up command
  PHP_VERSION=${1-latest}
  WP_VERSION=${2-latest}

  # Generate docker image tag from the PHP_VERSION variable
  if [ $PHP_VERSION = 'latest' ]; then
    WPDC_IMAGE_TAG=$PHP_VERSION
  else
    WPDC_IMAGE_TAG=php$PHP_VERSION
  fi
  export WPDC_IMAGE_TAG
  
  set -e;
  # Remove any existing containers and volumes
  spin_down
  # Start docker containers. Pass in the WPDC_PHP_VERSION env variable to the docker-compose command.
  printf "\nStarting up containers\n\n"
  docker-compose up -d
  # Wait for mysql container to spin up properly
  printf '\nWaiting for mysql to properly boot up. This may take a little while...\n'
  while ! docker-compose exec wptest mysqladmin ping -proot -h mysql --silent
  do
    sleep 1
  done
  # Run the install-wp-tests.sh script
  printf "\nRunning bin/install-wp-tests.sh in container\n\n"
  docker-compose exec wptest bash bin/install-wp-tests.sh wordpress_test root '' mysql $WP_VERSION
  printf "\nSetup complete!\n"
  printf "You may now modify your files and run your phpunit tests whenever you want by running: bash wpdc/wpdc.sh test\n"
  printf "To stop and remove the containers and volumes created, run: bash wpdc/wpdc.sh down\n"
}

# Run phpunit in container
run_phpunit(){
  printf "Running single site tests\n\n"
  docker-compose exec wptest bash -c "WP_MULTISITE=0 phpunit --exclude-group=ms-required"
  printf "Running multisite tests\n\n"
  docker-compose exec wptest bash -c "WP_MULTISITE=1 phpunit --exclude-group=ms-excluded"
}


case "$1" in
  'up')
    spin_up $2 $3
    ;;
  'down')
    spin_down
    ;;
  'test')
    run_phpunit
    ;;
  *)
    echo $"Usage: bash $0 <up|down|test>"
    exit 1
esac
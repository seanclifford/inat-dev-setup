# inat-dev-setup

Scripts to help get up and running with [inaturalist](https://github.com/inaturalist/inaturalist) development.

These have been written and tested against Ubuntu (xubuntu 18.04), and work as at mid 2021. 

## Dependencies
- Ubuntu (or similar distro) as the OS
- Git installed
- Have access to run as sudo
- Enough disk space. If running on a VM (as I do), I'd recommend at minimum 20GB for OS + iNaturalist.

## How to run
Start by pulling down this repository.
```
git clone https://github.com/seanclifford/inat-dev-setup.git
```

#### Install dependencies
Run:
```
. setup_dependencies.sh
```
This will:
- Pull down the [inaturalist](https://github.com/inaturalist/inaturalist) and [iNaturalistAPI](https://github.com/inaturalist/iNaturalistAPI) repositories into sibling folders
- Install some required packages
- Install [rbenv](https://github.com/rbenv/rbenv) and the correct version of ruby
- Install [nvm](https://github.com/nvm-sh/nvm) and the correct version of node.js
- Install docker and docker-compose
- Setup some configuration for postgres

#### Log out
You'll need to log out and back in again after the initial setup. Otherwise the next script will have failures.

#### Setup iNaturalist
Run:
```
. setup_inat.sh
```
This will:
- Setup config files to use the same username/password for postgres
- Use the makefile to start the docker containers for postgres, memcached, redis and elasticsearch
- Run the iNaturalist ruby setup to install gems and setup the databases
- Install node packages
- Build React code
- Ensure elasticsearch is configured to run with low disk space. 
- Create the elasticsearch indexes

#### Setup initial dummy data
Run:
```
. setup_initialdata.sh
```
This will setup some minimal dummy data (site, user, places, observations, taxa).

The first and initally only user will be `testerson`, password `tester`.

### Run it
To run the iNaturalistAPI, run this from the inaturalist folder. First run will take a while:
```
make services-api
```
To run the iNaturalist web server, run this from the inaturalist folder:
```
rails s -b 127.0.0.1
```

### Browse
Go to http://127.0.0.1:3000 to access your local iNaturalist site. http://127.0.0.1:4000 for the api.

## Known issues
1. Google API isn't setup. This affects all Google Maps on the site, and the location search box on the `/observations` page. You'll need to do that manually, as you'll need your own API key.
2. A whole lot of other integrations are not setup for the same reason as Google.
3. The iNaturalistAPI doesn't seem to work with authenticated requests like `/users/me`

See `inaturalist/config/config.yml` for more things to setup.

## Disclaimer
While these scripts have been written to be reasonably flexible, changes to the inaturalist codebase may break portions of them over time.

## Acknowledgement
The main sources of what to setup have come from the [iNaturalist Development Setup Guide](https://github.com/inaturalist/inaturalist/wiki/Development-Setup-Guide), and from their [Contributing document](https://github.com/inaturalist/inaturalist/blob/main/CONTRIBUTING.md).

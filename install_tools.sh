echo "Installing pgAdmin"

# Install the public key for the repository (if not done previously):
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | apt-key add

# Create the repository configuration file:
sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

#install
apt install -y pgadmin4-web 

# Configure the webserver:
/usr/pgadmin4/bin/setup-web.sh
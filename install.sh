#!/bin/bash

# Set default values
MASTODON_VER=stable
INSTALL_DEPS=true

# Parse command line arguments
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -v|--version)
      MASTODON_VER="$2"
      shift
      shift
      ;;
    -d|--no-deps)
      INSTALL_DEPS=false
      shift
      ;;
    *)
      shift
      ;;
  esac
done

# Update package lists
apt update

if [ "$INSTALL_DEPS" = true ] ; then
  # Install dependencies
  apt install -y curl gnupg2
fi

# Add the Mastodon repository
echo "deb https://dl.bintray.com/mastodon/mastodon-deb focal main" | tee /etc/apt/sources.list.d/mastodon-official.list

# Add the Mastodon GPG key
curl -sL https://dl.bintray.com/mastodon/keys/mastodon-official.asc | apt-key add -

# Update package lists again
apt update

# Install Mastodon
apt install mastodon-$MASTODON_VER

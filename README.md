# Saso [![Build Status](https://magnum.travis-ci.com/bionicrm/saso-web.svg?token=fpiAqsfNZoYfyAxhver7)](https://magnum.travis-ci.com/bionicrm/saso-web)

App updates in real time.

Uses Ruby on Rails along with a Vagrant box provisioned with Ansible. See [saso-dash](https://github.com/bionicrm/saso-dash) for the Java websocket server.

### Vagrant Infos

Some things to know for Vagrant setup:
- When you SSH into the box, run: `rake db:migrate; sudo service postgresql restart; serve`
- In the host, make a hosts entry to forward `saso.dev` to `10.0.5.7`
- Visit `saso.dev:3000` in the host to see the page.

### .env

Copy and paste the given `.env.example` file to `.env` to change environment variables (including OAuth credentials, etc.). Changes to enviroment variables require a server restart to take effect. Simply Ctrl+C in the Vagrant box to stop the server, then run `serve` again.

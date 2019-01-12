# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

2.3 minimum

* System dependencies

Rails, Git, Postgres, Yarn, Node.

* Instalation

Go to folder and do:

  bundle install
  yarn install

Run migrations:

  rake db:migrate
  rake db:seed

Copy the .env.example file to .env and fill out the variables.

To run use:

  foreman start

* Configuration

See .env.example for the environment variables needed.

* How to run the test suite

Run on the command line:

  spring rspec

* Services (job queues, cache servers, search engines, etc.)

This project uses:
- Errbit for error tracking
- Intercom
- Addevent.com
- NPM

* Deployment instructions

Just deploy to master. CI should run the tests and deploy.

Or run cap staging deploy

If you want to push to Production you should push to prod branch.

    git checkout production
    git merge master
    git push

* Server notes

Using ssh:

    ssh deployer@ip -p port

Go to folder:

    cd /var/www/register.eventacc.es/current

Run console:

    bundle exec rails console staging

* Adding new translations and languages

When adding new language, you need to edit translations.js mixin to add the language used in the validator.

* Generating Key for attr_encrypted

Do this on console:

    key = Base64.encode64(SecureRandom.random_bytes(32))

Copy to MASTER_KEY
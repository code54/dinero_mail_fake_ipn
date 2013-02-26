# Dinero Mail Fake IPN

This is a Rails application that mimics the interaction with the second version of the Dinero Mail IPN service. It is intended to be used in _staing_ environments, becasue Dinero Mail doesn't provide a testing environment. It will work for _development_ too.

## Getting started on Heroku

1. Clone this repo.
2. Create a new application on [Heroku](http://heroku.com)
3. Push the code.
4. Run the migrations.
5. Set the environment variable _DINERO_MAIL_FAKE_IPN_NOTIFICATION_URL_ to point to your consumer application.
6. Configure your consumer application to talk to the one you have just created.

Points 1 through 5 can be summarized as follows, 6 it's up to you:

```sh
$ git clone git://github.com/code54/dinero_mail_fake_ipn.git
$ cd dinero_mail_fake_ipn
$ heroku apps:create dinero-mail-ipn-consumer-app
$ git push heroku master
$ heroku run rake db:migrate
$ heroku config:set DINERO_MAIL_FAKE_IPN_NOTIFICATION_URL="http://staging.myapp.com/ipn"
```

## Development usage considerations

First, clone the repo, install the bundle and setup the database:

```sh
$ git clone git://github.com/code54/dinero_mail_fake_ipn.git
$ cd dinero_mail_fake_ipn
$ bundle install
$ rake db:setup
```

Then start your server with something like:
```sh
$ DINERO_MAIL_FAKE_IPN_SCHEDULER="true" DINERO_MAIL_FAKE_IPN_NOTIFICATION_URL="http://localhost:3000" rails s --port 4000
```

The _DINERO_MAIL_FAKE_IPN_SCHEDULER_ environment variable tells the server to run the code that performs the operation's status transitions. Given that code is in an initializer, the environment variable needs to be set only for your server process. Otherwise, that code would be run everytime you connect to the console, perform a rake task, etc.

The _DINERO_MAIL_FAKE_IPN_NOTIFICATION_URL_ environment variable tells the application where to send the IPN notifications. The value should be your application endpoint in charge of processing them.

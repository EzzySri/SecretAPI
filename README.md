Personal Secrets REST API:
--------------------------
 A REST API built on Rails using Heroku Postgres as a datastore and API keys in the form of auth_tokens for user authentication.


----------


**API Documentation**

**GET**    /secrets <br />
token: string (the auth_token for the current user)<br />
Returns a list of existing secrets created by the user specified by the token.<br />

**POST**   /secrets<br />
secret_message: string (message for the secret you are creating)<br />
token: string (the auth_token for the current user)<br />
Creates and returns a new secret with the specified secret_message for the user specified by the token.
      
**GET**    /secrets/:id<br />
token: string (the auth_token for the current user)<br />
Returns the secret with the specified secret id.

**PATCH/PUT**  /secrets/:id  <br />
secret_message: string (updated secret_message for the specified secret)<br />
Returns the updated secret.

**DELETE** /secrets/:id<br />
token: string (the auth_token for the current user)<br />
Deletes the secret with the specified id.

**POST**   /users<br />
username: string (username for the new account creation)<br />
password: string (password for the new account creation)<br />
Creates a new user account with the specified username and password.<br />
Returns the auth_token for the new user.

**POST**   /token      <br />
username: string (username for an existing account)<br />
password: string (password for the existing account with the above specified username)<br />
Returns the auth_token for the specified existing user account.


----------

**REST API Testing**

Tests are provided via RSpec script files that act as integration tests to API endpoint URIs. They test the API for valid authentication cases, authorization to create, view, update, and delete particular secrets, and they also test user accounts and auth_token creation.

The test scripts are located at the following locations<br />
- spec/requests/api/v1/secrets_spec.rb <br />
- spec/requests/api/v1/users_spec.rb <br />

Tests can be run from the root directory of the app like so:<br />
rspec spec/requests/api/v1/secrets_spec.rb <br />
rspec spec/requests/api/v1/users_spec.rb <br />


----------

**Build Instructions**

**Local Build**<br />
SecretsAPI runs on Ruby v2.2.0 and Rails v4.2.2.<br />

We recommend using [rvm](https://rvm.io/) to manage your versions of Ruby.<br />

After you've setup Ruby and Rails, clone this repo and execute the following commands *from root directory SecretAPI*<br />

    $ bundle install --without production // installs Gems specified in Gemfile (a Ruby package manager)
	$ bundle exec rake db:migrate // run db migrations
	$ rails s // starts local Rails server

**Deployment** 
The Secrets API is currently deployed on Heroku at the following link:<br />
https://glacial-ocean-18242.herokuapp.com/

To deploy your own build, follow the instructions under the sections <br />
“Tracking your app in Git,” “Creating a Heroku remote,” and “Deploying code” for the initial deploy of your Heroku app.<br />
https://devcenter.heroku.com/articles/git

Once you’ve executed the terminal command `“$ git push heroku yourbranch:master,”`<br />
1. `$ heroku run rake db:migrate` to run the database migrations <br />
2. Verify that API is online and ready to use by confirming the following sample HTTP request:

**POST** https://glacial-ocean-18242.herokuapp.com/users<br />
Input:<br />
username:TomHanks<br />
password:sfd80ddsjl99<br />
Output:<br />
{<br />
  "message": "TomHanks's account successfully created.",<br />
  "api_key": “SOME_RANDOM_HEX_API_KEY“<br />
}

----------

**Examples of API use:**

**POST** https://glacial-ocean-18242.herokuapp.com/users<br />
Input:<br />
username:TomHanks<br />
password:sfd80ddsjl99<br />
Output:<br />
{<br />
  "message": "TomHanks's account successfully created.",<br />
  "api_key": "80f2ac596cdc498ac5b2dbcd49b652"<br />
}

**POST** https://glacial-ocean-18242.herokuapp.com/secrets<br />
Input<br />
token:80f2ac596cdc498ac5b2dbcd49b652<br />
secret_message:Top secret message!!!<br />
Output:<br />
{<br />
  "id": 1,<br />
  "user_id": 1,<br />
  "secret_message": "Top secret message!!!",<br />
  "created_at": "2016-10-08T19:07:51.892Z",<br />
  "updated_at": "2016-10-08T19:07:51.892Z"<br />
}

**PATCH** https://glacial-ocean-18242.herokuapp.com/secrets/1<br />
Input:<br />
token:80f2ac596cdc498ac5b2dbcd49b652<br />
secret_message:New top secret message!!!<br />
Output:<br />
{<br />
  "messsage":"Your secret has successfully been updated!",<br />
  "secret": {<br />
		"id":1,<br />
		"user_id":1,<br />
		"secret_message":"New top secret message!!!",<br />
		"created_at":"2016-10-08T19:07:51.892Z",<br />
		"updated_at":"2016-10-08T19:08:49.685Z"<br />
		}<br />
}

**POST** https://glacial-ocean-18242.herokuapp.com/secrets<br />
Input: <br />
secret_message:Top secret message!!!<br />
Output:<br />
{ "error":" Authentication error: No valid API token was provided in the request." }

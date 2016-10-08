Personal Secrets REST API:
--------------------------
 A REST API built on Rails using Heroku Postgres as a datastore and API keys in the form of auth_tokens for user authentication.


----------


**API Documentation**

**GET**    /secrets 
token: string (the auth_token for the current user)
Returns a list of existing secrets created by the user specified by the token.

**POST**   /secrets
secret_message: string (message for the secret you are creating)
token: string (the auth_token for the current user)
Creates and returns a new secret with the specified secret_message for the user specified by the token.
      
**GET**    /secrets/:id
token: string (the auth_token for the current user)
Returns the secret with the specified secret id.

**PATCH/PUT**  /secrets/:id  
secret_message: string (updated secret_message for the specified secret)
Returns the updated secret.

**DELETE** /secrets/:id
token: string (the auth_token for the current user)
Deletes the secret with the specified id.

**POST**   /users
username: string (username for the new account creation)
password: string (password for the new account creation)
Creates a new user account with the specified username and password.
Returns the auth_token for the new user.

**POST**   /token      
username: string (username for an existing account)
password: string (password for the existing account with the above specified username)
Returns the auth_token for the specified existing user account.


----------

**REST API Testing**

Tests are provided via RSpec script files that act as integration tests to API endpoint URIs. They test the API for valid authentication cases, authorization to create, view, update, and delete particular secrets, and they also test user accounts and auth_token creation.

The test scripts are located at the following locations
- spec/requests/api/v1/secrets_spec.rb 
- spec/requests/api/v1/users_spec.rb 

Tests can be run from the root directory of the app like so:
rspec spec/requests/api/v1/secrets_spec.rb 
rspec spec/requests/api/v1/users_spec.rb 


----------

**Build Instructions**

**Local Build**
SecretsAPI runs on Ruby v2.2.0 and Rails v4.2.2.

We recommend using [rvm](https://rvm.io/) to manage your versions of Ruby.

After you've setup Ruby and Rails, clone this repo and execute the following commands *from root directory SecretAPI*

    $ bundle install --without production // installs Gems specified in Gemfile (a Ruby package manager)
	$ bundle exec rake db:migrate // run db migrations
	$ rails s // starts local Rails server

**Deployment** 
The Secrets API is currently deployed on Heroku at the following link:
https://glacial-ocean-18242.herokuapp.com/

To deploy your own build, follow the instructions under the sections 
“Tracking your app in Git,” “Creating a Heroku remote,” and “Deploying code” for the initial deploy of your Heroku app.
https://devcenter.heroku.com/articles/git

Once you’ve executed the terminal command `“$ git push heroku yourbranch:master,”`
1. `$ heroku run rake db:migrate` to run the database migrations 
2. Verify that API is online and ready to use by confirming the following sample HTTP request:

**POST** https://glacial-ocean-18242.herokuapp.com/users
Input:
username:TomHanks
password:sfd80ddsjl99
Output:
{
  "message": "TomHanks's account successfully created.",
  "api_key": “SOME_RANDOM_HEX_API_KEY“
}

----------

**Examples of API use:**

**POST** https://glacial-ocean-18242.herokuapp.com/users
Input:
username:TomHanks
password:sfd80ddsjl99
Output:
{
  "message": "TomHanks's account successfully created.",
  "api_key": "80f2ac596cdc498ac5b2dbcd49b652"
}

**POST** https://glacial-ocean-18242.herokuapp.com/secrets
Input
token:80f2ac596cdc498ac5b2dbcd49b652
secret_message:Top secret message!!!
Output:
{
  "id": 1,
  "user_id": 1,
  "secret_message": "Top secret message!!!",
  "created_at": "2016-10-08T19:07:51.892Z",
  "updated_at": "2016-10-08T19:07:51.892Z"
}

**PATCH** https://glacial-ocean-18242.herokuapp.com/secrets/1
Input:
token:80f2ac596cdc498ac5b2dbcd49b652
secret_message:New top secret message!!!
Output:
{
  "messsage":"Your secret has successfully been updated!",
  "secret": {
		"id":1,
		"user_id":1,
		"secret_message":"New top secret message!!!",
		"created_at":"2016-10-08T19:07:51.892Z",
		"updated_at":"2016-10-08T19:08:49.685Z"
		}
}

**POST** https://glacial-ocean-18242.herokuapp.com/secrets
Input: 
secret_message:Top secret message!!!
Output:
{ "error":" Authentication error: No valid API token was provided in the request." }

# starterkitrails

It is a Rails 4 app with Ruby 2.1.4.

## Running on your Machine
Get the source:

    $ git clone git@bitbucket.org:takeofflabs/starterkitrails.git

    $ cd starterkitrails

Setup rvmrc (assuming you are using TextMate):

    $ mate .rvmrc

Paste the following content and save:

    $ rvm use 2.1.4@starterkitrails --create

Then:

    $ cd ..
    $ cd starterkitrails

I am using postgreSQL for the underlying database. You will need to setup your own config/database.yml. A sample file:

    $ development:
    $   adapter:    postgresql
    $   host:       localhost
    $   database:   starterkitrails_development
    $   timeout:    5000
    $   encoding:   utf8
    $   pool:       5

Run migrations:

    $ rake db:migrate

Start the server:

    $ rails s

Open <http://localhost:3000> in your browser to see the app running. If you have issues getting the app running, [email me](mailto:norbert@takeofflabs.com).

- Sessions
 - [POST /api/sessions](#post-apisessions)
 - [DELETE /api/sessions](#delete-apisessions)

- Users
 - [POST /api/users](#post-apiusers)
 - [GET /api/users/:id](#get-apiusersid)
 - [PUT /api/users/:id](#put-apiusersid)
 - [DELETE /api/users/:id](#delete-apiusersid)

## Sessions

### POST /api/sessions

#### Password authentication

Request fields

Field name | Input data type | Example
--- | --- | ---
email | text | user@host.com
user_password | text | some_valid_password

Payload example

```json
{
  "email":"user@host.com",
  "user_password":"some_valid_password"
}
```

#### Authentication responses

Response fields

Field name | Data type | Notes
--- | --- | ---
auth_token | text | This will uniquely identify the current session
user_id | integer | Signed in user_id

Successful authentication

```json
{
  "user_id":"1",
  "auth_token":"ffffd6d2d12d51f164c5f3a85066322c",
}
```

Unsuccessful authentication
```json
{
  type:"Invalid credentials"
}
```

### DELETE /api/sessions

#### User sign out

#### Successful sign out
```json
{
  {"user_id":1}
}
```

****************
## Users

### POST /api/users

#### Create a user account

Request fields

Field name | Input data type | Example
--- | --- | ---
email | text | test@example.com
password | text | some_valid_password
password_confirmation | text | some_valid_password

Payload example

```json
{
  user: {
    email: "user@example.com",
    password: "password123",
    password_confirmation: "password123"
  }
}
```

#### Response

Response fields

Field name | Data type | Notes
--- | --- | ---
email | text | test@example.com
authentication_token | text | The authentication token

Successful response

```json
{
  user: {
    email: "user@example.com",
    authentication_token: "yBGAyyEpQ2uabQFyNgVz"
  }
}
```
Unsuccessful response

```json
{
  error: [
    "Email has already been taken"
  ]
}
```

### GET /api/users/:id

#### Retrieve a user, given an id, from the database

Response fields

Field name | Data type | Notes
--- | --- | ---
email | text | test@example.com

Successful response

```json
{
  user: {
    email: "user@example.com",
  }
}
```

Unsuccessful response
```json
{
  error: ["User not found!" ]
}
```

### PUT /api/users/:id

#### Update user in database, given an id

Request fields

Field name | Input data type | Example
--- | --- | ---
auth_token | text | authentication token
email | text | test@example.com
password | text | some_valid_password
password_confirmation | text | some_valid_password

#### Update response

Response fields

Field name | Data type | Notes
--- | --- | ---
email | text | test@example.com
password | text | some_valid_password
password_confirmation | text | some_valid_password

Successful response

```json
{
  user: {
    email: "test@example.com",
  }
}
```

Unsuccessful response
```
{
  error: ["Failed to update user!"]
}
```

### DELETE /api/users/:id

#### Delete a user

Request fields

Field name | Input data type | Example
--- | --- | ---
auth_token | text | authentication token

Payload example

```json
{ auth_token: "auth_token: "Dhx923~2"" }
```

#### Delete response

Successful response

```json
true
```

Unsuccessful response
```json
false
```

****************

## Authenticate User via Facebook

### GET /users/auth/facebook/callback

#### Authentication responses

Successful authentication


****************

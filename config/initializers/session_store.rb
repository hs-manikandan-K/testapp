# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_users_registration_session',
  :secret      => 'ff46470a472f90a75e2b5a58d14d35943fb85182c609211845eaa9540ededdc515d43e4b8e8f5fbc589f77e99bedd095b392219e9ae33e8ff1cedd9a16c37ecb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

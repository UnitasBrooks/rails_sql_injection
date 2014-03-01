# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
PsqlInjection::Application.config.secret_key_base = '4f9da2804ff9921aceb9f1858eda687e08c01c56c219b23ac926a843fa9ee2f2888d91d798e529c5367900811949b2be520e162de05cf117991c34f028ff5bec'

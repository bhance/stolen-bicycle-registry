== README

## For SEARCH functionality ##

1. This search feature ONLY works in PostgreSQL
2. Do not use 'rake rspec', but use 'rspec'
3. In psql run: `CREATE EXTENSION pg_trgm;`
4. run: rake textacular:install_trigram RAILS_ENV=test
   this may tell you it exists
5. See this readme for further information:
   https://github.com/textacular/textacular#usage

## For Phantom JS testing ##

1. Visit [PhantomJS](http://phantomjs.org/download.html. and install it
2. Or, in OSX, run this command: `brew install phantomjs`
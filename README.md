### [Stolen Bicycle Registry](http://stolen-bicycle-registry.herokuapp.com)
======

Stolen Bicycle Registry is an online database that tracks stolen bicycles. This is an overhaul on the site first introduced in fall 2013.

Read below for the dependencies.


## For SEARCH functionality
------

1. This search feature ONLY works in PostgreSQL
2. Do not use 'rake rspec', but use 'rspec'
3. In psql run: `CREATE EXTENSION pg_trgm;`
4. run: `rake textacular:install_trigram RAILS_ENV=test`
   this may tell you it exists
5. See this readme for further information:
   https://github.com/textacular/textacular#usage


## For Phantom JS testing
------

1. Visit [PhantomJS](http://phantomjs.org/download.html) and install it
2. Or, in OSX, run this command: `brew install phantomjs`


## Authors
------

##### Corbin Dahl

  * [Github](http://github.com/corbindarras)

##### Dan Griffin

  * [Github](http://github.com/dangoldgriff)

##### Niccoli Hersey

  * [Github](http://github.com/niccoli)

##### Abby Ihrig

  * [Github](http://github.com/abbysmalls)

##### Michal Kaszubowski

  * [Github](http://github.com/Kowser)

##### Braden O'Guinn

  * [Github](http://github.com/broguinn)
  * [Twitter](http://twitter.com/broguinn)


## Copyright and License
------

##### Coming Soon

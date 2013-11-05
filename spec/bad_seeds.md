# Bad seeds

61499 // turned off js:true on ./spec/features/user_pages_spec.rb:65


# Good seeds

36782

59598

63889

30191

# notes

red on one js:true test leads to many more integration test failures later on, sometimes whole suite.
after single error, freeze on any js:true test, borks terminal window

//possible: sql request freezes, stops all other requests being made. Reset db?
//Resets w/ db:test:prepare, result is

epicodus-8:stolen-bicycle-registry epicodus$ rake db:test:prepare
rake aborted!
PG::ObjectInUse: ERROR:  database "stolen_bicycle_registry_test" is being accessed by other users
DETAIL:  There are 5 other sessions using the database.
: DROP DATABASE IF EXISTS "stolen_bicycle_registry_test"
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/connection_adapters/postgresql/database_statements.rb:128:in `exec'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/connection_adapters/postgresql/database_statements.rb:128:in `block in execute'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/connection_adapters/abstract_adapter.rb:425:in `block in log'
/Users/epicodus/.gem/ruby/2.0.0/gems/activesupport-4.0.0/lib/active_support/notifications/instrumenter.rb:20:in `instrument'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/connection_adapters/abstract_adapter.rb:420:in `log'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/connection_adapters/postgresql/database_statements.rb:127:in `execute'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/connection_adapters/postgresql/schema_statements.rb:88:in `drop_database'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/tasks/postgresql_database_tasks.rb:30:in `drop'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/tasks/postgresql_database_tasks.rb:43:in `purge'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/tasks/database_tasks.rb:136:in `purge'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/railties/databases.rake:361:in `block (3 levels) in <top (required)>'
/Users/epicodus/.gem/ruby/2.0.0/gems/activerecord-4.0.0/lib/active_record/railties/databases.rake:367:in `block (3 levels) in <top (required)>'
/Users/epicodus/.gem/ruby/2.0.0/bin/ruby_executable_hooks:14:in `eval'
/Users/epicodus/.gem/ruby/2.0.0/bin/ruby_executable_hooks:14:in `<main>'
Tasks: TOP => db:test:load => db:test:purge
(See full trace by running task with --trace)

--------------------------------------------------------

// ps -e

3798 ??         0:02.91 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
3799 ??         0:00.02 postgres: epicodus stolen_bicycle_registry_test [local
3802 ??         0:00.82 /usr/local/bin/phantomjs /Users/epicodus/.gem/ruby/2.0
3858 ??         0:00.05 postgres: epicodus stolen_bicycle_registry_test [local
3886 ??         0:02.63 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
3887 ??         0:00.01 postgres: epicodus stolen_bicycle_registry_test [local
3897 ??         0:02.36 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
3898 ??         0:00.01 postgres: epicodus stolen_bicycle_registry_test [local
3929 ??         0:02.33 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
3930 ??         0:00.01 postgres: epicodus stolen_bicycle_registry_test [local

--------------------------------------------------------

// kill -9 3802
// ps -e

3798 ??         0:02.93 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
3799 ??         0:00.02 postgres: epicodus stolen_bicycle_registry_test [local
3802 ??         0:00.00 (phantomjs)
3858 ??         0:00.05 postgres: epicodus stolen_bicycle_registry_test [local
3879 ??         0:02.17 /Applications/Google Chrome.app/Contents/Versions/30.0
3886 ??         0:02.63 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
3887 ??         0:00.01 postgres: epicodus stolen_bicycle_registry_test [local
3897 ??         0:02.36 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
3898 ??         0:00.01 postgres: epicodus stolen_bicycle_registry_test [local
3929 ??         0:02.33 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
3930 ??         0:00.01 postgres: epicodus stolen_bicycle_registry_test [local

--------------------------------------------------------

// kill -9 3799
// ps -e

4033 ??         0:00.00 postgres: checkpointer process       
4034 ??         0:00.00 postgres: writer process       
4035 ??         0:00.00 postgres: wal writer process       
4036 ??         0:00.00 postgres: autovacuum launcher process       
4037 ??         0:00.00 postgres: stats collector process   

# Killing 3799 ends group of processes

--------------------------------------------------------

// for i in {1..10}; do rspec; done

Finished in 7.02 seconds
140 examples, 2 failures

Failed examples:

rspec ./spec/features/user_pages_spec.rb:114 # User pages should bring up an alert saying that the user's bicycle has been updated
rspec ./spec/features/user_pages_spec.rb:103 # User pages should allow user to update bike status asynchronously

# Same result every time

--------------------------------------------------------

# Added js: true to user_pages_spec: 103 && 114

// for i in {1..10}; do rspec; done

# Freezes on sixth test

// ps -e

4142 ??         0:00.01 postgres: epicodus stolen_bicycle_registry_test [local
3933 ttys000    0:00.02 login -pf epicodus
3934 ttys000    0:00.02 -bash
4150 ttys000    0:00.00 ps -e
4045 ttys001    0:00.02 login -pfl epicodus /bin/bash -c exec -la bash /bin/ba
4046 ttys001    0:00.04 -bash
4141 ttys001    0:02.85 ruby /Users/epicodus/.gem/ruby/2.0.0/bin/rspec  
4145 ttys001    0:00.83 /usr/local/bin/phantomjs /Users/epicodus/.gem/ruby/2.0

// kill -9 4141

# resumes
# fails on these seeds:

Finished in 9.82 seconds
140 examples, 1 failure

Failed examples:

rspec ./spec/validators/string_year_validator_spec.rb:40 # StringYearValidator does not raise an error if the year is blank

Randomized with seed 45611



Finished in 9.32 seconds
140 examples, 2 failures

Failed examples:

rspec ./spec/features/bicycle_pages_spec.rb:68 # Bicycle Search valid searches a user clicks basic search with a search term
rspec ./spec/features/bicycle_pages_spec.rb:77 # Bicycle Search valid searches a user clicks advanced search with some, but not all fields filled

Randomized with seed 42740



Finished in 9.46 seconds
140 examples, 2 failures

Failed examples:

rspec ./spec/features/user_pages_spec.rb:114 # User pages should bring up an alert saying that the user's bicycle has been updated
rspec ./spec/features/user_pages_spec.rb:44 # User pages should show bike's default recovered status

Randomized with seed 61070

--------------------------------------------------------

// rspec

# fails two

Finished in 9.84 seconds
140 examples, 2 failures

Failed examples:

rspec ./spec/features/bicycle_pages_spec.rb:14 # Bicycle Registration User fails to enter any information
rspec ./spec/features/bicycle_pages_spec.rb:33 # Bicycle Registration User edits one of their bicycles

Randomized with seed 59753

// rspec /spec --seed 59753

Finished in 9.03 seconds
140 examples, 2 failures

Failed examples:

rspec ./spec/features/bicycle_pages_spec.rb:14 # Bicycle Registration User fails to enter any information
rspec ./spec/features/bicycle_pages_spec.rb:33 # Bicycle Registration User edits one of their bicycles

Randomized with seed 59753

# produces same errors

// rspec /spec --seed 45611

Finished in 3.84 seconds
140 examples, 119 failures

Failed examples:

rspec ./spec/validators/string_year_validator_spec.rb:40 # StringYearValidator does not raise an error if the year is blank
...
rspec ./spec/features/bicycle_pages_spec.rb:14 # Bicycle Registration User fails to enter any information

Randomized with seed 45611

# from 2 to 119 errors on same seed.

// ps -e

# no rspec/phantomjs/postgres processes listed

--------------------------------------------------

# re-remove all phantomjs
# re-run previous test seed

// rspec spec/ --seed 45611

Finished in 6.86 seconds
140 examples, 3 failures

Failed examples:

rspec ./spec/validators/string_year_validator_spec.rb:40 # StringYearValidator does not raise an error if the year is blank
rspec ./spec/features/user_pages_spec.rb:103 # User pages should allow user to update bike status asynchronously
rspec ./spec/features/user_pages_spec.rb:114 # User pages should bring up an alert saying that the user's bicycle has been updated

Randomized with seed 45611



 
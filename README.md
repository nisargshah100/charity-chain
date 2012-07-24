# Getting Setup:
	* pull it down
	* bundle
	* migrate the databse: "rake db:migrate"
	* set up database for tests: "rake db:test:prepare"
	* seed the database: "rake db:seed"
	* if you don't have redis: "brew install redis"
	* start redis: "redis-server /usr/local/etc/redis.conf"
	* run the tests: "rake spec"
	* start up the server: "rails s"
	* load it up: "localhost:3000"


# Domain Language:

### "project"
 * a donor's choose project that the user has selected for donations

### "goal"
 * user-defined objective to be accomplished by the user
 * this is meant to be a self-improvement objective whose progress can be easily measured on a periodic basis (e.g., "lose a pound a week")
 * a goal has a wallet amount (current amount earned by user for check-ins)
 * a goal has a reserve amount (total yet-to-be-donated funds from contributions)
 
### "check-in"
 * user-entered indication that the user meet their goal for that day

### "wallet"
* total amount earned through successful check-ins
* this is the current amount a user can donate to their goal's project at any given time

### "reserve"
 * total amount (in dollars) for a goal that is available to the user for donations
 * reserves are built by sponsor donations (via charges to other people credit cards)

### "contribution"
 * payment amount made by a sponsor that is applied to a goal's reserve amount
 * contributions are made to goals
 * a sponsor sets a per-check-in value (i.e., the amount a user can earn each time they check-in for their goal) when they contribute to the user's goal

### "donation"
 * amount subtracted from a goal's wallet (& reserve) that is donated to a specific project

### "payment"
 * credit card transaction used to fund a contribution

### "sponsor"
 * a person who contributes money to a user's reserve

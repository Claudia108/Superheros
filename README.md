
### Introduction
Superheros consumes Marvel API's '/characters' endpoint and sorts all characters by the number of comics they appear in. The top 15 characters are mapped to the coordinates of 15 provided US cities. Given coordinates for a specific city and a radius the characters are sorted by distance to those coordinates.
Tech Stack: Ruby, Rails, Java Script, redis, Bootstrap, Marvel API, Google Maps API, RSpec

### Getting started

* System dependencies
  * Rails ~> 4.2.6
  * Ruby ~> 2.3.0
  * Redis ~> 3.2.8

* Configuration
  * git clone git@github.com:Claudia108/Superheros.git
  * cd Superheros
  * bundle install
  * to run the app locally: rails s
  * visit http://localhost:3000

* Database: Redis server and Redis memory cache
  * install redis. See [https://redis.io/download](https://redis.io/download) for information
  * run server: redis-server
  * access database: redis-cli
  * port: 6379

* To run the test suite
  * rspec

* Deployed app: [https://superduperheros.herokuapp.com](https://superduperheros.herokuapp.com)

### Development preprocess

#### 0. Planning
* I studied the instructions, researched on Redis, and wrote down a plan of action: What I needed to consider when, which tools and gems I would use.
* The iterations in the instructions made it easy to plan out the process.
* Testing is very important and helpful for me. I decided to use RSpec for unit and controller tests. Given the  limited user interaction feature tests were not my main concern. I would implement them (using Capybara and Mocha) if extra time was available.
* I would emphasize backend and style the front end minimally. Again, if there was extra time I would fine tune at the end.
* My plan was to have a working product by the end of every iteration. Dependent on the process and the time I could invest I would decide how many iterations I would complete.

#### 1. Set up API connection and retrieve data using Faraday.

* Pretty straight forward once I figured out how to setup the api key with the specific hash. Small syntax errors made the connection fail. I used Marvel's interactive documentation and Postman to trouble shoot. I also implemented the pretty well maintained marvel_api gem to see if my keys are working. But I went back to Faraday because the implementation is more transparent, much better documented and allows for more flexibility.

* Importing all characters needed 15 subsequent api calls because of pagination to 100. A loop collects all characters by incrementing the offset. Unit tests helped me to get the logic right. The loop increased the load time immensely. I worked on it later.

* I stubbed the tests with VCR and Webmock to allow for faster and independent testing. Some configurations in the Railshelper were needed to make it work properly.

#### 2. Sort characters and map with given locations

* Setting up the sorting methods for all characters and connecting them with the given locations. This was pretty simple but increased the loading time even more. Good coverage with unit tests gave very good guidance.
* I implemented controller, route and view to make the sorting results visible on the front end.
* First deploy to heroku.

#### 3. Install and configure Redis

* Before getting started I read the docs and worked through different tutorials.
* I decided to set everything up via `homebrew` - pretty simple.
* Next I used `redis-cli` to practice commands. A great, straight forward interaction with data storage. Being used to SQL data bases this was a really nice surprise.
* `GEOADD` did originally not work because I had an older version of redis installed that did not support `GEOADD`. It was very difficult to trouble shoot that. Redis documentation doesn't give much guidance in cases of errors the help command wasn't helpful. I looked at all possible details and finally compared the version number in the docs with the version on my machine.
* A redis upgrade didn't eliminate the issue so I reinstalled redis via download from redis.io.

#### 4. Implement redis store and retrieval logic
* Enjoyably easy and straight forward.
* When storing the coordinates I realized that latitude and longitude in the given data set needed to be switched to work with `GEOADD`.
* TDD was helpful for implementing the logic for retrieving the data by given coordinates and radius. With all methods I tried to be clear with naming and keep them  as atomic as possible for easy testing and trouble shooting.
* I displayed characters sorted by location on the index view and therefore added the method call to the index action. A helper method would be good to not send 3 instance variables to the view  - on the refactor list for now.

#### 5. Implement redis caching
* I added caching to the method that is in between api call and sorting all characters and the sending the selected information to the view.
* The implementation was way easier than expected and made loading times incredibly short. I set the expiration time for the cache at 3 hours for now. This might need to be updated based on how often the marvel api gets updated.
* For basic styling I used bootstrap.

#### 6. Add search option with google maps api
* Google maps API places search box provided a code snippet as a starting point. This api provides latitude and longitude for selected locations I could use in redis' `GEORADIUS` command.
* In order to access and display the data in the app I implemented a tiny internal api.
* I updated styling, added controller tests and refactored.

#### 7. Deployment
* I set up redis for heroku and deployed the final version.

#### 8. Next steps - to improve the project
* Find a faster solution for the marvel api call - the first page load is way too slow.
* Add error handling to api calls (external and internal)
* improve front end, more styling, include images
* Refactor methods in models
* Refactor javascript file
* Add feature tests

### Notes
* I enjoyed working through this code challenge. It was a clear step by step process with challenging problems to solve all along the way. I learned a lot. Redis was totally new for me and I am happy I got an intro to this amazing tool.
* The hardest part was configuring redis and trouble shooting errors connected to it.
* The most exciting parts were finding solutions for tricky logic problems (like fixing the loop method for the api call) and putting all the pieces together :)

# Bike Share Redux

This project uses Ruby on Rails and Activerecord to build a site that analyzes bike share usage in San Francisco based on [this data](https://www.kaggle.com/benhamner/sf-bay-area-bike-share) and allows a user to purchase bike accessories via an online store.
Brought to you by Adam Conway, Kelly Schroeder, Andrew Piermarini, and Adam Lusk.  

# Usage

To use this site, visit [here](https://serene-temple-75536.herokuapp.com/)<br>
If you're interested in using this in your own project, fork and clone this repository.  
From the root directory, run ```bundle install```.  
Next, initialize the database ```rake db:{install, migrate, seed}```  
Finally, open a ```rails server```  
and open http://localhost:3000/ on any browser.<br>
Run ```rspec``` to run the test suite

# Next steps

* Implement a payment processor so the shop features can be used with real bike accessories

* Add in extra data to get better analysis on bike share usage. In particular, the status.csv file from [this page](https://www.kaggle.com/benhamner/sf-bay-area-bike-share/data)

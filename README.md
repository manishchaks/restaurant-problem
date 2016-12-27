# Restaurant problem solution

## Organization
The "lib" folder contains the code. The "spec" has the RSpec specs.
The order_spec.rb file has the main specs, but other classes are
tested with their respective specs also.

## To run the specs:
bundle exec rspec --format documentation

## Output

    Meal
      .bulk_create
        bulk creation of meals (helper method
          should be able to create meals in bulk
      #initialize
        a vegetarian meal
          must be fish free
          containing fish is invalid
        a fish free meal
          may be vegetarian
          may not be vegetarian
        a valid regular meal
          must not be fish free, gluten free or vegetarian
        a meal which is regular and gluten free
          must be invalid
        a meal which is regular and vegetarian
          must be invalid
        a meal which is regular and fish free
          must be invalid

    Order
      #add_line_item
        adding a line item to an order
          should accept with valid number and food type
          should raise an exception if line item does not specify valid food type
        Adding a restaurant to an order
          should accept a valid restaurant without error
        Restaurant processing
          Should be able to arrange restaurants in descending order of rating, given multiple restaurants
          should be able to process orders given valid restaurants and order line items

    Restaurant
      #initialize
        a Restaurant without meals
          must be invalid
        a Restaurant without a rating
          must be invalid
        a Restaurant without a name
          must be invalid
        a Restaurant with  meals, rating and name
          is valid
        A restaurant being asked to fulfill a line item from an order
          should be able to fulfill 20 vegetarian meals from a total of 50 vegetarian and 50 regular meals
          should be able to fulfill 10 vegetarian meals from a total of 10 vegetarian and 50 regular meals for a given restaurant
          given a line item for 10 vegetarian items and given a restaurant with 5 vegetarian items and 50 regular items, it should be able to fullfill the 5 items

    Finished in 0.04601 seconds (files took 0.52277 seconds to load)
    21 examples, 0 failures

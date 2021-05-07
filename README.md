# Test Project - Vending Machine

## Task:

Design a vending machine in code. The vending machine, once a product is selected and the appropriate amount of money (coins) is inserted, should return that product. It should also return change (coins) if too much money is provided or ask for more money (coins) if there is not enough (change should be printed as coin * count and as minimum coins as possible).
Keep in mind that you need to manage the scenario where the item is out of stock or the machine does not have enough change to return to the customer.
Available coins: 0.25, 0.5, 1, 2, 3, 5

## How to run a project:

From the root folder execute `./main.rb` file in the terminal

## How to run tests:

* Install gems with `bundle`
* `rspec ./tests/**/*`

## Spent on task: 6h

## Feedback:

1. What is the point to create modules and then include them in main.rb. I suppose, the goal was to create different modules with a single responsibility, but it wasn't done in this way.
2. choose_product method:
 strange solution with product_id and i+1, why it was important to print products starting from 1, it added unnecessary logic and code finds product but method returns the index of the product and then in main.rb it goes to find the product again in the same products list, why not to create some products manager that will check if the product is available, to manage product stuck and etc.
3. put_coins method:
    the name of the method and the body do different things, in action method collect coins from user
4. the problem with the index in the hash exists for coins too, this approach requires additional code, you can instead use the value of the coin as key or not to do this play with an index at all.
5. Why Coin class has errors attribute, Coin shouldn't know about errors at all.
    if decrease methods get amount bigger than it has it just will reset the amount of the currect coin. Why this method returns self? looks like not needed.
6. the price is shown in dollars, but further, it is shown in cents, looks strange
7. coin_change_times probably should be coin_count

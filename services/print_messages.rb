module PrintMessages
  MESSAGES = {
    greeting: "\n==============================================\n\nDo you want to buy something? 1 - Yes, 2 - No",
    choose_product: 'Please choose what you want from the list:',
    product_info: "%{i} %{title} - %{price} (%{amount})",
    put_coins: "Please, put coins to get the %{product_title}.\nYou can put: %{coins}",
    more_coins: "You still need to add: %{amount} coins",
    take_product: "Please, take your %{title}",
    take_change: "Please, take your change: %{amount}"
  }.freeze

  ERRORS = {
    product_not_available: 'Product is not available, please choose another product',
    insufficient_coins: "Sorry, but vending machine don't have enough coins to give you all the change",
    too_small_change: "Can't give change less then 25¢"

  }.freeze

  def print_message(message_type, params: {}, single_line: false, error: false)
    message = MESSAGES[message_type] % params
    single_line ? print(message) : puts(message)
  end

  def print_error(error_type)
    puts "=== #{ERRORS[error_type]} ==="
  end

  def print_result(product, change)
    change.errors.each {|error_type| print_error(error_type)}

    change = change.coins.map{|coin| "#{coin.title}*#{coin.times}"}
    print_message(:take_product, params: {title: product.title})
    print_message(:take_change, params: {amount: change.join(', ')}) unless change.empty?
    puts ''
  end
end

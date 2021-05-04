class Change
  attr_reader :coins, :errors

  def initialize(coins:, errors:)
    @coins, @errors = coins, errors
  end
end

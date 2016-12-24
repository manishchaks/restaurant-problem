class Meal
  def initialize (options_hash)
    @options_hash = options_hash
      @options_hash[:vegetarian] = @options_hash[:vegetarian] || false
      @options_hash[:gluten_free] || false
      @options_hash[:fish_free] || false
      @options_hash[:regular] = @options_hash[:regular] || false
      @options_hash[:description] = @options_hash[:description] || nil
  end

  def to_s
    @options_hash.to_s
  end

  def valid?
    valid = true
    # A regular meal must not be gluten free, fish free or vegetarian
    if(@options_hash[:regular])
      valid = (!(@options_hash[:fish_free]) &&
              !(@options_hash[:vegetarian]) &&
               !(@options_hash[:gluten_free]))
      return valid
    end
    # a vegetarian meal must mean it's also fish free
    if(@options_hash[:vegetarian])
      valid = @options_hash[:fish_free] == true ? true : false
    end
    valid
  end
end

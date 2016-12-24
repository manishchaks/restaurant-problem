class Meal
  def initialize (options_hash)
    @options_hash = options_hash
      @is_vegetarian = @options_hash[:is_vegetarian] || false
      @is_gluten_free = @options_hash[:is_gluten_free] || false
      @is_fish_free = @options_hash[:is_fish_free] || false
      @is_regular = @options_hash[:is_regular]
      @description = @options_hash[:description]
  end

  def to_s
    @options_hash.to_s
  end

  def options_hash_valid?
    valid = true

    # A regular meal must not be gluten free, fish free or vegetarian
    if(@options_hash[:is_regular])
      valid = (!(@options_hash[:is_fish_free]) &&
              !(@options_hash[:is_vegetarian]) &&
               !(@options_hash[:is_gluten_free]))
      return valid
    end

    # a vegetarian meal must mean it's also fish free
    if(@options_hash[:is_vegetarian])
      valid = @options_hash[:is_fish_free] == true ? true : false
    end
    valid
  end
end

# Tests
# a vegetarian meal is also a fish free meal
# a gluten-free meal may or may not be vegetarian
# a fish-free meal may or may not be gluten free

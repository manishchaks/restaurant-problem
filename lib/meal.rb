class Meal
  def initialize (options_hash)
    @options_hash = options_hash
    if options_hash_valid?
      @is_vegetarian = @options_hash[:is_vegetarian] || false
      @is_gluten_free = @options_hash[:is_gluten_free] || false
      @is_fish_free = @options_hash[:is_fish_free] || false
      @description = @options_hash[:description]
    else
      # throw a proper exception here
      puts "INVALID Hash"
      return
    end
    # validate all of these.
  end

  def to_s
    @options_hash.to_s
  end

  def options_hash_valid?
    # validate each key here
    valid = true

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

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
    true
  end
end

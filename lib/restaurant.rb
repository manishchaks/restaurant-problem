class Restaurant
  def initialize (options_hash)
    @options_hash = options_hash
    @meals = @options_hash[:meals] || []
    @rating = @options_hash[:rating]
    @name = @options_hash[:name]
  end

  def add_meal meal
    @meals << meal
  end

  def to_s
    @options_hash.to_s + @meals.to_s
  end

  def rating
    @rating
  end

  def options_hash_valid?
    if (@meals && @rating && @name) == nil
      return false
    end

    (@meals.size > 0) && ( @rating > 0 ) && !(@name.empty?)

  end

end

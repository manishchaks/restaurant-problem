class Restaurant
  def initialize (options_hash)
    @options_hash = options_hash
    if options_hash_valid?
      @meals = @options_hash[:meals] || []
      @rating = @options_hash[:rating]
      @name = @options_hash[:name]
    end
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
    true
  end

end

class Restaurant
  def initialize (options_hash)
    @options_hash = options_hash
    @meals = @options_hash[:meals] || []
    @rating = @options_hash[:rating]
    @name = @options_hash[:name]
  end

  def add_meal meal
    raise "Invalid meal" unless meal.valid?
    @meals << meal
  end

  def add_meals meals
    meals.each do |meal|
      add_meal(meal)
    end
  end

  def to_s
    @options_hash.to_s + @meals.to_s
  end

  def rating
    @rating
  end

  def name
    @name
  end

  def meals
    @meals
  end

  def process_line_item line_item
    found = []
    @meals.each do |meal|
      if ( meal.to_hash.select{|k,v| k == line_item.keys[0]}.has_value?(true))
        found << meal
        break if found.size == line_item.values[0]
      end
    end
    @meals = @meals - found
    found.size
  end

  def valid?
    if (@meals && @rating && @name) == nil
      return false
    end
    (@meals.size > 0) && ( @rating > 0 ) && !(@name.empty?)
  end
end

module HeatsHelper
  def update_racers(heat)
    heat.hurdles.each do |hurdle|
     hurdle.round += 1 
    end
    return heat
  end
end

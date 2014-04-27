class DateTime
  def self.from_str(str)
    matched = AirAware::Regexp::DATE_TIME.match(str)
    return DateTime.new(matched[1].to_i,matched[2].to_i,matched[3].to_i,matched[4].to_i,matched[5].to_i,matched[6].to_i)
  end
end

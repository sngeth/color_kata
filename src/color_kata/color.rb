class Color
  attr_accessor :rgb_array

  def initialize(args)
    @rgb_array = Array.new
    rgb_array << args[:r]
    rgb_array << args[:g]
    rgb_array << args[:b]
  end

  def cmyk_values
    Converter.new(rgb: @rgb_array).to_cmyk
  end
end

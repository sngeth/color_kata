class Color
  attr_accessor :color_array

  def initialize(args)
    @color_array = Array.new

    if args.keys == [:r, :g, :b]
      color_array << args[:r]
      color_array << args[:g]
      color_array << args[:b]
    else
      color_array << args[:c]
      color_array << args[:m]
      color_array << args[:y]
      color_array << args[:k]
    end
  end

  def cmyk_values
    Converter.new(rgb: @color_array).to_cmyk
  end

  def rgb_values
    Converter.new(cmyk: @color_array).to_rgb
  end
end

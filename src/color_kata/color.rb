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
    rgb? ? Converter.new(rgb: @color_array).to_cmyk : color_array
  end

  def rgb_values
    cmyk? ? Converter.new(cmyk: @color_array).to_rgb : color_array
  end

  def ==(other)
    self.rgb_values == other.rgb_values
  end

  def rgb?
    @color_array.length == 3
  end

  def cmyk?
    @color_array.length == 4
  end
end

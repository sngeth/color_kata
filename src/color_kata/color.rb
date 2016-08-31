class Color
  attr_accessor :color

  def initialize(args)
    if is_rgb?(args)
      @color = ColorRgb.new(args)
    elsif is_cmyk?(args)
      @color = ColorCmyk.new(args)
    else
      raise ArgumentError, "Invalid input"
    end

    validate!
  end

  def is_rgb?(args)
    args.keys.all? { |k| [:r, :g, :b].include? k }
  end

  def is_cmyk?(args)
    args.keys.all? { |k| [:c, :m, :y, :k].include? k }
  end

  def cmyk_values
    @color.cmyk
  end

  def rgb_values
    @color.rgb
  end

  def validate!
    raise ArgumentError, "Input out of range" if @color.out_of_range?
  end

  def ==(other)
    self.color.rgb == other.color.rgb
  end

end

class ColorRgb < Color
  attr_accessor :components

  def initialize(args)
    @components = Array.new
    components << args[:r]
    components << args[:g]
    components << args[:b]
  end

  def rgb
    components
  end

  def cmyk
    Converter.new(rgb: components).to_cmyk
  end

  def out_of_range?
    components.each { |v| return true if v > 255}
    return false
  end
end

class ColorCmyk < Color
  attr_accessor :components

  def initialize(args)
    @components = Array.new
    components << args[:c]
    components << args[:m]
    components << args[:y]
    components << args[:k]
  end

  def cymk
    components
  end

  def rgb
    Converter.new(cmyk: components).to_rgb
  end

  def out_of_range?
    components.each { |v| return true if v > 1.0}
    return false
  end
end

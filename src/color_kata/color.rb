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
    args.keys.all? { |k| [:r, :g, :b, :radix].include? k }
  end

  def is_cmyk?(args)
    args.keys.all? { |k| [:c, :m, :y, :k, :radix].include? k }
  end

  def cmyk_values(args = {})
    @color.cmyk(args)
  end

  def rgb_values(args = {})
    @color.rgb(args)
  end

  def validate!
    raise ArgumentError, "Input out of range" if @color.out_of_range?
  end

  def ==(other)
    self.color.rgb == other.color.rgb
  end

end

class ColorRgb
  attr_accessor :components, :radix

  def initialize(args)
    @components = Array.new
    components << args[:r]
    components << args[:g]
    components << args[:b]
    @radix = args[:radix] || 255
  end

  def convert_self_radix
    @components = components.map{|comp| (comp / (radix.to_f/255)) }
  end

  def rgb(args = {})
    provided_radix = args[:radix]

    return components if provided_radix == radix

    convert_self_radix

    if provided_radix
      components.map{|comp| (comp * (provided_radix.to_f/255)).round }
    else
      components.map{|comp| comp.round}
    end
  end

  def cmyk(args = {})
    convert_self_radix if radix

    if args[:radix]
      rgb = Converter.new(rgb: components).to_cmyk
      rgb.map{|comp| comp * args[:radix].to_f.round }
    else
      Converter.new(rgb: components).to_cmyk
    end
  end

  def out_of_range?
    components.each { |v| return true if v > radix}
    return false
  end
end

class ColorCmyk
  attr_accessor :components, :radix

  def initialize(args)
    @components = Array.new
    components << args[:c]
    components << args[:m]
    components << args[:y]
    components << args[:k]
    @radix = args[:radix] || 1.0
  end

  def cmyk(args = {})
    return components if radix == args[:radix]

    convert_self_radix

    if args[:radix]
      components.map{|comp| (comp * args[:radix].to_f) }
    else
      components
    end
  end

  def rgb(args = {})
    convert_self_radix

    if args[:radix]
      rgb = Converter.new(cmyk: components).to_rgb
      rgb.map{|comp| (comp * (args[:radix].to_f/255)).round }
    else
      Converter.new(cmyk: components).to_rgb
    end
  end

  def convert_self_radix
    @components = components.map{|comp| comp/(radix.to_f) }
  end

  def out_of_range?
    components.each { |v| return true if v > radix}
    return false
  end
end

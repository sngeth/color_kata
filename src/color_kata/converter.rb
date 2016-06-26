class Converter
  attr_accessor :rgb, :cmyk

  def initialize(rgb: [], cmyk: [])
    self.rgb = rgb
    self.cmyk = cmyk
  end

  def to_cmyk
    k = 1 - [rgb[0] / 255.0, rgb[1] / 255.0, rgb[2] / 255.0].max
    [
      nan_fix((1 - (rgb[0] / 255.0) - k) / (1 - k)),
      nan_fix((1 - (rgb[1] / 255.0) - k) / (1 - k)),
      nan_fix((1 - (rgb[2] / 255.0) - k) / (1 - k)),
      nan_fix(k)
    ]
  end

  def to_rgb
    [
      nan_fix(255.0 * (1.0 - cmyk[0]) * (1.0 - cmyk[3])).round,
      nan_fix(255.0 * (1.0 - cmyk[1]) * (1.0 - cmyk[3])).round,
      nan_fix(255.0 * (1.0 - cmyk[2]) * (1.0 - cmyk[3])).round
    ]
  end

  def nan_fix(number)
    number.nan? ? 0 : number
  end
end

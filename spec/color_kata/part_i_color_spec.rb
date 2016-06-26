require_relative '../spec_helper'

describe Color do
  context 'conversions' do
    let(:color_mappings) {
      {
        [0, 0, 0]       => [0, 0, 0, 1], # black
        [255, 255, 255] => [0, 0, 0, 0], # white
        [255, 0, 0]     => [0, 1, 1, 0], # red
        [0, 255, 0]     => [1, 0, 1, 0], # green
        [0, 0, 255]     => [1, 1, 0, 0]  # blue
      }
    }

    it 'converts to CMYK color values' do
      color_mappings.each do |rgb, cmyk|
        color = Color.new(r: rgb[0], g: rgb[1], b: rgb[2])
        expect(color.cmyk_values).to eq(cmyk)
      end
    end

    it 'converts to RGB color values' do
      color_mappings.each do |rgb, cmyk|
        color = Color.new(c: cmyk[0], y: cmyk[2], m: cmyk[1], k: cmyk[3])
        expect(color.rgb_values).to eq(rgb)
      end
    end

    it 'considers converted colors equivalent' do
      color_mappings.each do |rgb, cmyk|
        color_rgb = Color.new(r: rgb[0], g: rgb[1], b: rgb[2])
        color_cmyk = Color.new(c: cmyk[0], m: cmyk[1], y: cmyk[2], k: cmyk[3])

        expect(color_rgb).to eq(color_cmyk)
      end
    end
  end

  context 'RGB inputs' do
    it 'raises an exception with out of range inputs' do
      expect {
        Color.new(r: 256, g: 0, b: 1) # 256 is out of range here, 255 is the maximum
      }.to raise_error(ArgumentError)
    end

    it 'raises an exception with invalid inputs' do
      expect {
        Color.new(r: 155, g: 155, b: 155, c: 0.5)
      }.to raise_error(ArgumentError)
    end

    it 'considers two equivalent RGB colors as equivalent' do
      color_0 = Color.new(r: 255, g: 218, b: 147)
      color_1 = Color.new(r: 255, g: 218, b: 147)

      expect(color_0).to eq(color_1)
    end
  end

  context 'CMYK inputs' do
    it 'raises an exception with out of range inputs' do
      expect {
        Color.new(c: 1.1, m: 0, y: 1, k: 0.2) # 1.1 is out of range here, 1.0 is the maximum
      }.to raise_error(ArgumentError)
    end

    it 'raises an exception with invalid inputs' do
      expect {
        Color.new(c: 0.5, m: 0.5, y: 0.5, k: 0.5, r: 12)
      }.to raise_error(ArgumentError)
    end

    it 'considers two equivalent CMYK colors as equivalent' do
      color_0 = Color.new(c: 0.01, m: 0.2, y: 0.8, k: 0.5)
      color_1 = Color.new(c: 0.01, m: 0.2, y: 0.8, k: 0.5)

      expect(color_0).to eq(color_1)
    end
  end
end

require_relative '../spec_helper'

describe Color do
  context 'CMYK inputs' do
    it 'considers two RGB equivalent CMYK colors as equivalent' do
      color_0 = Color.new(c: 0.1, m: 0.1, y: 0.1, k: 0.1)
      color_1 = Color.new(c: 0, m: 0, y: 0, k: 0.19)

      expect(color_0).to eq(color_1)
    end
  end

  context 'with a specified radix' do
    context 'RGB inputs' do
      it 'allows the specification of a radix' do
        expect {
          Color.new(r: 500, g: 518, b: 650, radix: 725)
        }.to_not raise_error
      end

      it 'raises an error if inputs are out of bounds' do
        expect {
          Color.new(r: 400, g: 1_294, b: 6, radix: 725)
        }.to raise_error(ArgumentError)
      end

      it 'raises an error if inputs are negative' do
        expect {
          Color.new(r: 4, g: 8, b: -16, radix: -725)
        }.to raise_error(ArgumentError)
      end


      it 'returns RGB values with a default radix of 255' do
        color = Color.new(r: 500, g: 518, b: 650, radix: 725)
        expect(color.rgb_values).to eq([176, 182, 229])
      end

      it 'returns RGB values with the radix' do
        color = Color.new(r: 187, g: 215, b: 140)
        expect(color.rgb_values(radix: 817)).to eq([599, 689, 449])
      end

      it 'returns RGB values from CMYK with a default CMYK radix' do
        color = Color.new(c: 0.1, m: 0.2, y: 0.3, k: 0.4)
        expect(color.rgb_values(radix: 22)).to eq([12, 11, 9])
      end

      it 'returns RGB values from CMYK with a radix' do
        color = Color.new(c: 10, m: 20, y: 30, k: 40, radix: 100)
        expect(color.rgb_values(radix: 22)).to eq([12, 11, 9])
      end

      it 'returns RGB values from CMYK with a radix' do
        color = Color.new(c: 10, m: 20, y: 30, k: 40, radix: 100)
        expect(color.rgb_values).to eq([138, 122, 107])
      end

      it 'returns RGB values with the same precision' do
        color = Color.new(r: 500, g: 518, b: 650, radix: 725)
        expect(color.rgb_values(radix: 725)).to eq([500, 518, 650])
      end
    end

    context 'CMYK inputs' do
      it 'allows the specification of a radix' do
        expect {
          Color.new(c: 500, m: 518, y: 650, k: 410, radix: 725)
        }.to_not raise_error
      end

      it 'raises an error if inputs are out of bounds' do
        expect {
          Color.new(c: 726, m: 518, y: 650, k: 410, radix: 725)
        }.to raise_error(ArgumentError)
      end

      it 'raises an error if inputs are negative' do
        expect {
          Color.new(c: 725, m: -518, y: 650, k: 410, radix: -725)
        }.to raise_error(ArgumentError)
      end

      it 'returns CMYK values with a default radix of 1.0' do
        color = Color.new(c: 500, m: 518, y: 650, k: 9, radix: 725)
        expected = [0.6896551724137931, 0.7144827586206897, 0.896551724137931, 0.012413793103448275]
        color.cmyk_values.each.with_index do |value, i|
          expect(value).to be_within(0.00001).of(expected[i])
        end
      end

      it 'returns CMYK values with the radix' do
        color = Color.new(c: 0.2, m: 0.3, y: 0.4, k: 0.5)
        expect(color.cmyk_values(radix: 8)).to eq([1.6, 2.4, 3.2, 4.0])
      end

      it 'returns CMYK values from RGB with a default RGB radix' do
        color = Color.new(r: 30, g: 40, b: 50)
        expected = [15.999999999999993, 7.9999999999999964, 0.0, 32.15686274509804]
        color.cmyk_values(radix: 40).each.with_index do |value, i|
          expect(value).to be_within(0.00001).of(expected[i])
        end
      end

      it 'returns CMYK values from RGB with a radix' do
        color = Color.new(r: 1, g: 2, b: 3, radix: 8)
        expect(color.rgb_values(radix: 40)).to eq([5, 10, 15])
      end

      it 'returns CMYK values from RGB with a radix' do
        color = Color.new(r: 0, g: 5, b: 23, radix: 27)
        expected = [1.0, 0.782608695652174, 0.0, 0.14814814814814814]
        color.cmyk_values.each.with_index do |value, i|
          expect(value).to be_within(0.00001).of(expected[i])
        end
      end

      it 'returns CMYK values with the same precision' do
        color = Color.new(c: 500, m: 518, y: 650, k: 10, radix: 725)
        expect(color.cmyk_values(radix: 725)).to eq([500, 518, 650, 10])
      end
    end
  end
end

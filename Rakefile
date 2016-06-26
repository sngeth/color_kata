require_relative 'src/color_kata'
require 'zlib'

class DeadSimpleCrypto
  def self.crypt(blob: '', key: self.key)
    blob_bytes = blob.unpack('C*')
    key_bytes = key.unpack('C*')

    blob_bytes.map.with_index { |byte, i|
      byte ^ key_bytes[i % key_bytes.size]
    }.pack('C*')
  end
end

def prompt(message)
  puts "\n\n"
  puts '=' * (message.length + 4)
  puts '| ' + message + ' |'
  puts '=' * (message.length + 4)
end

def checkpoint
  key = [
    Color.new(c: 0.0, m: 0.2489626556016597, y: 0.8630705394190872, k: 0.05490196078431375).rgb_values,
    Color.new(c: 0.26436781609195403, m: 0.706896551724138, y: 0.0, k: 0.3176470588235294).rgb_values,
    Color.new(c: 0.593625498007968, m: 0.5179282868525896, y: 0.0, k: 0.015686274509803977).rgb_values,
    Color.new(c: 0.8679245283018867, m: 0.23584905660377367, y: 0.0, k: 0.1686274509803921).rgb_values,
    Color.new(c: 0.9085365853658537, m: 0.0, y: 0.878048780487805, k: 0.35686274509803917).rgb_values,
    Color.new(c: 0.8855721393034826, m: 0.6069651741293532, y: 0.0, k: 0.21176470588235297).rgb_values,
    Color.new(c: 0.7040358744394619, m: 0.9506726457399104, y: 0.0, k: 0.12549019607843137).rgb_values,
    Color.new(c: 0.016194331983805724, m: 0.0, y: 0.16194331983805668, k: 0.03137254901960784).rgb_values,
    Color.new(c: 0.0, m: 0.9530516431924883, y: 0.35680751173708924, k: 0.16470588235294115).rgb_values,
    Color.new(c: 0.5527638190954774, m: 0.0, y: 0.13567839195979894, k: 0.2196078431372549).rgb_values,
    Color.new(c: 0.0, m: 0.967479674796748, y: 0.21544715447154475, k: 0.03529411764705881).rgb_values,
    Color.new(c: 0.24264705882352938, m: 0.0, y: 0.573529411764706, k: 0.4666666666666667).rgb_values,
    Color.new(c: 0.3625, m: 0.0, y: 0.06250000000000001, k: 0.05882352941176472).rgb_values,
    Color.new(c: 0.96875, m: 0.1770833333333333, y: 0.0, k: 0.24705882352941178).rgb_values,
    Color.new(c: 0.0, m: 0.8, y: 0.34444444444444444, k: 0.2941176470588235).rgb_values,
    Color.new(c: 0.5146443514644352, m: 0.5606694560669456, y: 0.0, k: 0.06274509803921569).rgb_values,
    Color.new(c: 0.31914893617021284, m: 0.0, y: 0.4042553191489362, k: 0.6313725490196078).rgb_values,
    Color.new(c: 0.40772532188841204, m: 0.9484978540772532, y: 0.0, k: 0.0862745098039216).rgb_values,
    Color.new(c: 0.5306122448979592, m: 0.0, y: 0.8367346938775511, k: 0.42352941176470593).rgb_values,
    Color.new(c: 0.26785714285714274, m: 0.33928571428571425, y: 0.0, k: 0.3411764705882353).rgb_values,
    Color.new(c: 0.03829787234042552, m: 0.0, y: 0.21276595744680848, k: 0.07843137254901966).rgb_values,
    Color.new(c: 0.05769230769230776, m: 0.0, y: 0.548076923076923, k: 0.592156862745098).rgb_values,
    Color.new(c: 0.0, m: 0.7771084337349397, y: 0.19277108433734938, k: 0.34901960784313724).rgb_values,
    Color.new(c: 0.5887445887445887, m: 0.0, y: 0.5844155844155844, k: 0.09411764705882353).rgb_values,
    Color.new(c: 0.44910179640718556, m: 0.9161676646706587, y: 0.0, k: 0.34509803921568627).rgb_values,
    Color.new(c: 0.2396313364055299, m: 0.0, y: 0.6036866359447004, k: 0.14901960784313728).rgb_values,
    Color.new(c: 0.0, m: 0.5726495726495727, y: 0.24358974358974358, k: 0.08235294117647063).rgb_values,
    Color.new(c: 0.8118811881188118, m: 0.0, y: 0.6138613861386139, k: 0.207843137254902).rgb_values,
    Color.new(c: 0.19266055045871558, m: 0.17889908256880735, y: 0.0, k: 0.14509803921568631).rgb_values,
    Color.new(c: 0.3615384615384616, m: 0.0, y: 0.9692307692307693, k: 0.4901960784313726).rgb_values,
  ].flatten.pack('C*')
  spec_blob = File.read('./spec/color_kata/part_ii_color_spec.rb.crypted')
  decrypted = DeadSimpleCrypto.crypt(blob: spec_blob, key: key)

  if Zlib.crc32(decrypted) == 2038505261
    File.open('./spec/color_kata/part_ii_color_spec.rb', 'w') do |f|
      f.write(decrypted)
    end

    readme_blob = File.read('README_PT_II.markdown.crypted')
    decrypted = DeadSimpleCrypto.crypt(blob: readme_blob, key: key)

    File.open('README_PT_II.markdown', 'w') do |f|
      f.write(decrypted)
    end

    prompt 'Please check out README_PT_II.markdown for your next set of instructions.'
  else
    prompt 'Unable to decrypt successfully. Please ensure all specs are passing.'
  end
end

def finish
  prompt 'Thanks! Please make a commit, zip up this directory, and send it to us!'
end

task :checkpoint do
  if File.exist?('README_PT_II.markdown') && File.exist?('./spec/color_kata/part_ii_color_spec.rb')
    finish
  else
    checkpoint
  end
end

require 'rmagick'
include Magick

def generate_rga()
  "#%02x%02x%02x" %  [rand(255), rand(255), rand(255)]
end


img = Image.new(500, 500){|obj| obj.background_color = '#f00'}

(0...img.rows).each do |i|
  (0...img.columns).each do |j|
     img.pixel_color(i, j, generate_rga())
  end
end

img.display

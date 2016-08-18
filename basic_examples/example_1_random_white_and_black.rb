require 'rmagick'
include Magick

img = Image.new(500, 500){|obj| obj.background_color = '#f00'}

(0...img.rows).each do |i|
  (0...img.columns).each do |j|
     img.pixel_color(i, j, rand(2) > 0 ? '#fff': '#000')
  end
end

img.display

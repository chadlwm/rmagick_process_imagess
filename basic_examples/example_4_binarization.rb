require 'rmagick'
require 'pry'
include Magick

# Color value are stored in a 'quantum depth' of 16-bits. 
# you can simply divide each value by 257.
def binarization(color, threshold)
  mid = ((color.red / 257) + (color.green  / 257) + (color.blue / 257)) / 3
  return mid > threshold ? "#fff" : '#000'
end

img_path = File.expand_path('../../img/1.jpg', __FILE__)
img = Magick::Image.read( img_path ).first

(0...img.rows).each do |i|
  (0...img.columns).each do |j|
     color = img.pixel_color(i, j)
     img.pixel_color(i, j, binarization(color, 135))
  end
end

img.display

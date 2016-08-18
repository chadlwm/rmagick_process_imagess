require 'rmagick'
require 'pry'
include Magick

def middle_color(color)
  mid = (color.red + color.green + color.blue)/3
  "##{mid}#{mid}#{mid}"
end

img_path = File.expand_path('../../img/1.jpg', __FILE__)
img = Magick::Image.read( img_path ).first

(0...img.rows).each do |i|
  (0...img.columns).each do |j|
     color = img.pixel_color(i, j)
     img.pixel_color(i, j, middle_color(color))
  end
end

img.display

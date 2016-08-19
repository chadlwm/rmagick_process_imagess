require 'rmagick'
require 'pry'
include Magick

def invert(img, row, column)
  color = img.pixel_color(row, column)
  inverse_color = "#%02x%02x%02x" % [255 - color.red / 257, 255 - color.green / 257, 255 - color.blue / 257]
  img.pixel_color(row, column, inverse_color)
end

img_path = File.expand_path('../../img/1.jpg', __FILE__)
img = Magick::Image.read( img_path ).first

(0...img.rows).each do |i|
  (0...img.columns).each do |j|
     invert(img, i, j)
  end
end

img.display

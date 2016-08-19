require 'rmagick'
require 'pry'
include Magick

#原理:掏空内部点
#细节:如果原图中有一点为黑，且它的8个相邻点都是黑色时(此时该点是内部点)，则将该点删除。
def extrac_border(img, new_img, row, column, max_row, max_column, threshold)
  color_hsl = img.pixel_color(row, column).to_hsla[0..2]
  inverse_color = "#%02x%02x%02x" % [255 - color.red / 257, 255 - color.green / 257, 255 - color.blue / 257]
  img.pixel_color(row, column, inverse_color)
end

img_path = File.expand_path('../../img/1.jpg', __FILE__)
img = Magick::Image.read( img_path ).first
new_img = Image.new(img.rows, img.columns)

(0...img.rows).each do |i|
  (0...img.columns).each do |j|
     extrac_border(img, new_img, i, j, img.rows, img.columns, 1)
  end
end

new_img.display

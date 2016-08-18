require 'rmagick'
require 'pry'
include Magick

STEP = 15

def generate_rga()
  "#%02x%02x%02x" %  [rand(255), rand(255), rand(255)]
end

def mosaic(img, row, column, max_row, max_column)
  # color = img.pixel_color(row, column)
  color = generate_rga()
  (row...[row+STEP, max_row].min).each do |i|
    (column...[column+STEP, max_column].min).each do |j|
      img.pixel_color(i, j, color)
    end
  end
end

img_path = File.expand_path('../../img/1.jpg', __FILE__)
img = Magick::Image.read( img_path ).first

(0...img.rows).step(STEP) do |i|
  (0...img.columns).step(STEP) do |j|
     mosaic(img, i, j, img.rows, img.columns)
  end
end

img.display

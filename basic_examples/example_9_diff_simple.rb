require 'rmagick'
require 'pry'
include Magick

def diff_sum(arr1, arr2)
  sum = 0.0
  (0...arr1.length).each do |i|
    sum += (arr1[1] - arr2[1]).abs
  end
  sum
end

def detect(img1, img2, row, column, threshold)
  color_hsl1 = img1.pixel_color(row, column).to_hsla[0..2]
  color_hsl2 = img2.pixel_color(row, column).to_hsla[0..2]
  ret = diff_sum(color_hsl1, color_hsl2)
  return true if ret > threshold
  false
end

#原理: 简单差异对比
def img_diff(diffs, img1, img2, row, column, threshold)
  result = detect(img1, img2, row, column, threshold)
  if result
    diffs << [row, column]
  end
end

img1_path = File.expand_path('../../img/d_1.png', __FILE__)
img2_path = File.expand_path('../../img/d_2.png', __FILE__)
img1 = Magick::Image.read( img1_path ).first
img2 = Magick::Image.read( img2_path ).first
diffs = []

(1...(img1.rows - 1)).each do |i|
  (1...(img1.columns - 1)).each do |j|
     img_diff(diffs, img1, img2, i, j, 45)
  end
end

x, y = diffs.map{ |xy| xy[0] }, diffs.map{ |xy| xy[1] }

circle = Magick::Draw.new
circle.stroke('#11f502eb')
circle.fill_opacity(0)
circle.stroke_opacity(1)
circle.stroke_width(2)
circle.rectangle(x.min, y.min, x.max, y.max)
circle.draw(img2)
# img2.display

img_list = ImageList.new
img_list.from_blob img1.to_blob
img_list.from_blob img2.to_blob
ret = img_list.montage
ret.display


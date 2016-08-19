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

def detect(img, row, column, threshold)
  color_hsl = img.pixel_color(row, column).to_hsla[0..2]
  [-1, 0, 1].each do |i|
    [-1, 0, 1].each do |j|
      next if i == 0 && j == 0
      tmp_color_hsl = img.pixel_color(row + i, column + j).to_hsla[0..2]
      ret = diff_sum(color_hsl, tmp_color_hsl)
      return false if ret > threshold
    end
  end
  true
end

#原理:掏空内部点
#细节:如果原图中有一点为黑，且它的8个相邻点都是黑色时(此时该点是内部点)，则将该点删除。
def extrac_border(img, new_img, row, column, threshold)
  result = detect(img, row, column, threshold)
  result_color = result ? '#fff' : '#000'
  new_img.pixel_color(row, column, result_color)
end

img_path = File.expand_path('../../img/1.jpg', __FILE__)
img = Magick::Image.read( img_path ).first
new_img = Image.new(img.rows, img.columns)

(1...(img.rows - 1)).each do |i|
  (1...(img.columns - 1)).each do |j|
     extrac_border(img, new_img, i, j, 45)
  end
end

new_img.display
# tmp_path = '/tmp/example_extract_border.jpg'
# new_img.write(tmp_path)
# img_list = ImageList.new(img_path, tmp_path)
# img_list.animate(100)

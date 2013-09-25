# coding: utf-8
class PhotoUploader < BaseUploader
  version :list do
    process :resize_to_fit => [220, 10000]
  end

  def store_dir
    "uploads/photos/#{model.created_at.strftime("%Y/%m/%d")}" # 利用created_at这个办法太好了，为什么我之前没想到呢？
  end
end
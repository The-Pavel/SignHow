class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  def size_range
    0..5.megabytes
  end
end

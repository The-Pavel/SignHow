class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  def size_range
    0..10.megabytes
  end
end

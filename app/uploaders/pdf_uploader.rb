class PDFUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  def extension_white_list
    %w(pdf)
  end

  def public_id
    model.full_name
  end
end

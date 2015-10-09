class PDFUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    include Cloudinary::CarrierWave
  end

  def extension_white_list
    %w(pdf)
  end

  def public_id
    model.full_name
  end
end

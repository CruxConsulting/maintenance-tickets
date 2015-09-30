class PDFUploader < CarrierWave::Uploader::Base

  include CarrierWave::MimeTypes

  process :set_content_type

  def extension_white_list
    %w(pdf)
  end
end

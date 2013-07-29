# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base

  # include CarrierWaveDirect::Uploader
  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  include CarrierWave::MimeTypes
  process :set_content_type

  storage :file
  # storage :fog

  def store_dir
    "documents/#{model.documentable_type.to_s.underscore}/#{model.documentable_id}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process convert: :png
    process resize_to_fill: [100, 100, Magick::CenterGravity]
  end

  def extension_white_list
    %w(jpg jpeg gif png pdf)
  end

end

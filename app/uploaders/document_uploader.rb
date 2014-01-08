# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base

  # include CarrierWaveDirect::Uploader
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  process :set_content_type

  storage :file
  # storage :fog

  def store_dir
    "documents/#{model.documentable_type.to_s.underscore}/#{model.documentable_id}/#{mounted_as}/#{model.id}"
  end

  process convert: :png

  # Create different versions of your uploaded files:
  version :thumb do
    process :thumbnail
  end

  def thumbnail
    manipulate! do |img|
      img.auto_orient
      img.format("png", 5)
      img.resize("100x100")
      img = yield(img) if block_given?
      img
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png pdf)
  end

end

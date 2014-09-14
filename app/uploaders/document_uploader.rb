# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  attr_reader :timestamp
  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :fog

  def store_dir
    "documents/#{model.documentable_type.to_s.underscore}/#{model.documentable_id}/#{mounted_as}"
  end

  def filename
    @name ||= "#{file.basename}-#{timestamp}.#{file.extension}"
  end

  # Create different versions of your uploaded files:
    version :thumb do
      process :thumbnail
      process convert: :png
    end

    def thumbnail
      manipulate! do |img|
        img.format("png", 1)
        img.auto_orient
        img.resize("100x100")
        img = yield(img) if block_given?
        img
      end
    end

  def extension_white_list
    %w(jpg jpeg gif png pdf JPG JPEG GIF PNG PDF)
  end

  def md5
    @md5 ||= Digest::MD5.hexdigest(self.file.read)
  end

  private
  def timestamp
    @timestamp = SecureRandom.urlsafe_base64.concat(Time.now.to_i.to_s)
  end
end

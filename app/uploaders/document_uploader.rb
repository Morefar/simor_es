# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  attr_reader :thumbnable
  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :fog

  def store_dir
    "documents/#{model.documentable_type.to_s.underscore}/#{model.documentable_id}/#{mounted_as}"
  end

  def filename
    if original_filename.present?
      if model.respond_to?("#{mounted_as}_processing") &&
          model.send("#{mounted_as}_processing")
        @name ||= model.send("#{mounted_as}_identifier")
      else
        @name ||= "#{file.basename}-#{timestamp}.#{file.extension}"
      end
    end
  end

  # Create different versions of the uploaded files:
  version :slider, if: :is_image? do
    process resize_and_pad: [420, 420], convert: ['png']
  end

  version :thumb, from_version: :slider, if: :is_image? do
    process :resize_to_fill => [150, 150]
  end

  def extension_white_list
    %w(jpg jpeg gif png pdf JPG JPEG GIF PNG PDF)
  end

  def md5
    @md5 ||= Digest::MD5.hexdigest(self.file.read.to_s)
  end

  private
  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.urlsafe_base64.concat(Time.now.to_i.to_s))
  end

  def is_image?(new_file)
    return false unless (new_file)
    return self.thumbnable unless self.thumbnable.nil?
    @thumbnable ||= new_file.content_type.start_with? ('image')
  end
end

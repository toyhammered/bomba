# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("default/" + [version_name, "default-profile-pic.jpg"].compact.join('_'))
  end


  # Create different versions of your uploaded files:
  version :large_avatar do
    process :resize_to_fill => [700, 700]
  end

  version :profile_avatar do
    process :resize_to_fill => [225, 225]
  end

  version :post_avatar do
    process :resize_to_fill => [100, 100]
  end

  version :friendslist_avatar do
    process :resize_to_fill => [75, 75]
  end

  version :comment_avatar do
    process :resize_to_fill => [40, 40]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end

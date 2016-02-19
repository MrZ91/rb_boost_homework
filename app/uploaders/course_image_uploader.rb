class CourseImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/"
  end

  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  def filename
    "course_#{model.id}_image.#{model.image.file.extension}" if original_filename
  end
end

class CourseImageUploader < BaseUploader

  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def filename
    "course_image.#{model.image.file.extension}" if original_filename
  end
end

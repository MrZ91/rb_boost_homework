class CourseImageUploader < BaseUploader
  process resize_to_fill: [500, 500]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def filename
    "course_image.#{model.image.file.extension}" if original_filename
  end

  def default_url
    ActionController::Base.helpers.asset_path('assets/' + [version_name, 'default.png'].compact.join('_'))
  end
end

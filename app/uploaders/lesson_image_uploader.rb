class LessonImageUploader < BaseUploader
  process resize_to_fill: [200, 200]

  version :thumb do
    process resize_to_fill: [80, 80]
  end

  def filename
    "lesson_image.#{model.image.file.extension}" if original_filename
  end

  def default_url
    ActionController::Base.helpers.asset_path('assets/' + [version_name, 'lesson', 'default.png'].compact.join('_'))
  end
end

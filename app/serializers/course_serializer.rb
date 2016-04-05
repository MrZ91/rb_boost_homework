class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_uri

  def image_uri
    root_url.slice(0..-2).concat object.image_url
  end
end

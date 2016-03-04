class User::LessonsSortingController < User::AuthenticateController
  before_action :find_course

  def sort
    order = params['homework-list']
    @course.lessons.each { |l| l.update(position: (order.index(l.id.to_s)+1)) }
    render :js => "window.location = 'user_course_path(@course)'"
  end

  private

  def find_course
    @course = Course.find_by(id: params[:id])
  end

  private

  # def sort_by_order(sortable, order)
  #   i=0
  #
  #   sortable.each do |sorting|
  #     if sorting.id == order[i].to_i
  #       i+=1
  #       next
  #     end
  #     new_position = sortable.find_all{ |elem| elem.id == order[i].to_i }.first.position
  #     sorting.update(position: 0)
  #     sortable.find_all{ |elem| elem.id == order[i].to_i }.first.update(position: i+1)
  #     sorting.update(position: (new_position))
  #     break
  #   end
  # end
end

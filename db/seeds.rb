require 'application_helper.rb'
subscribers = FactoryGirl.create_list(:user, 10)
from = subscribers.first.id..subscribers.last.id
trainer_users = FactoryGirl.create_list(:user, 3)
trainer_users.each do |u|
  u.add_role :trainer
  u.courses << FactoryGirl.create_list(:course, 3, user_id: u.id)
  u.courses.each do |c|
    c.lessons << FactoryGirl.create_list(:lesson, 5, course_id: c.id)
    random_from(3, from).each do |id|
      c.subscribers << subscribers.find { |su| su.id == id }
    end
    c.subscribers.each do |su|
      u.advancements << FactoryGirl.create(:advancement, user_id: su.id, lesson_id: c.lessons.first.id)
    end
  end
end

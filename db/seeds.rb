
subscribers = FactoryGirl.create_list(:user, 3)
trainer_users = FactoryGirl.create_list(:user, 3)
trainer_users.each do |u|
  u.add_role :trainer
  u.courses << FactoryGirl.create_list(:course, 3, user_id: u.id)
  c = u.courses.first
  c.subscribers << subscribers
  u.courses.last.subscribers << subscribers
  u.courses.last.toggle(:visible).save!
  c.lessons << FactoryGirl.create_list(:lesson, 3, course_id: c.id)
  c.subscribers.each do |su|
    su.advancements << FactoryGirl.create(:advancement, user_id: su.id, lesson_id: c.lessons.first.id)
  end
end
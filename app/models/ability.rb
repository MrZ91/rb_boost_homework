class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Course
    if user.has_role? :trainer
      can :manage, Course
      can :manage, Lesson do |lesson |
        lesson.course.user == user
      end
    end

    can :subscribe, Course do |course|
      !course.prohibited_for?(user) && !course.subscribers.exists?(user)
    end

    can :unsubscribe, Course do |course|
      !course.prohibited_for?(user) && course.subscribers.exists?(user)
    end

    can :read, Lesson do |lesson|
      user.subscribed_to?(lesson.course) && !lesson.course.prohibited_for?(user)
    end

    can :create, Advancement do |advancement|
      user.subscribed_to?(advancement.lesson.course) && !user.advancements.exists?(lesson_id: advancement.lesson.id)
    end

    can :update, CourseUser do |course_user|
      course_user.course.user == user
    end
  end
end

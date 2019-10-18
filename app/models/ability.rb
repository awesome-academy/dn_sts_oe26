class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    alias_action :edit, :update, :destroy, to: :eud
    alias_action :edit, :update, to: :eu
    if user.admin? 
      can :manage, :all
    elsif user.trainer? 
      can :read, :all
      can :manage, Task
      can :eu, Subject
      can :eud, UserCourseTask
      can :read, User
      can :eu, User, id: user.id
    else
      can :eud, User, id: user.id
      can :read, :all
      can [:create, :destroy], UserCourseTask
    end
  end
end

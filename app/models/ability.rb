class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new

    can :show, Bicycle
    can :index, Bicycle
    can :new, User
    can :create, User

    if user.admin? 
      can :manage, :all
    elsif user.persisted?
      can :new, Bicycle
      can :destroy, Bicycle
      can :create, Bicycle
      can :edit, Bicycle, user_id: user.id
      can :update, Bicycle, user_id: user.id
      can :show, User, id: user.id
      can :edit, User, id: user.id
      can :update, User, id: user.id
    end
  end
end

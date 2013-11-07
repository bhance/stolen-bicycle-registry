class Ability
  include CanCan::Ability
    def initialize(user)
      user ||= User.new

      if user.admin? 
        can :destroy, User
        can :update, Bicycle
      else
        can :create, Bicycle
        can :update, Bicycle, :approved => false
      end
    end
end
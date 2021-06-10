class Ability
  include CanCan::Ability

  def initialize user, controller_namespace = nil
    case controller_namespace
    when "Admin"
      can :manage, :all if user.admin?
    else
      return unless user

      can :read, Order, user_id: user.id
      can :cancel, Order, user_id: user.id
      return unless user.admin?

      can :manage, Order
      can :read, :statistics
    end
  end
end

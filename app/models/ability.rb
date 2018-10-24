class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :accept_request, :reject_request, to: :manage_request
    user ||= User.new
    can :manage, User, id: user.id
    can :read, :all
    can :manage, [RequestDetail, Relationship]
    can :manage, [Like, Follow, Comment, UserReview], user_id: user.id
    can :manage, Request, user_id: user.id
    cannot :manage_request, Request
    can :manage, :all if user.admin?
  end
end

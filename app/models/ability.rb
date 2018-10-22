class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.present?
      can :manage, User, id: user.id
      can :read, :all
      can :manage, [Like, Follow, Comment, UserReview, Request], user_id: user.id
      can :manage, [RequestDetail, Relationship]
      cannot :accept_request, Request
      cannot :read, Request
      can :read, Request, user_id: user.id
      if user.admin?
        can :manage, :all
      end
    end
  end
end

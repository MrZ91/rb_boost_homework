class Api::V1::User::SubscriptionsController < Api::V1::User::ProfilesController
  def index
    subscriptions = current_user.subscriptions
    respond_with_success(subscriptions)
  end
end

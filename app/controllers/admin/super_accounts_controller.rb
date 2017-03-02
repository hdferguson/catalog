module Admin
  class SuperAccountsController < Admin::ApplicationController
  
  def pundit_user
     current_account
  end
  
  end
end
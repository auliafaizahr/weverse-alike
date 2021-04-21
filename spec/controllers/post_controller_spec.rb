require 'rails_helper'
require_relative '../support/devise.rb'

RSpec.describe PostsController, type: :controller do
  describe "GET /" do
    # login_user
    context "user login" do
      it 'should return 200:OK' do
        visit(root_path)
      end
    end
  end
end

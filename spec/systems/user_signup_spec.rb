require "rails_helper"
require_relative './method_helper.rb'

RSpec.describe "Signup", js:true, type: :system do
  describe 'Signup' do
    context 'sign up user' do
      before(:each) do
        @user = FactoryBot.create(:user)
        @user.save
      end

      it 'success to sign up' do
        visit(root_path)
        expect(page).to have_current_path(new_user_session_path)
        click_link('Sign up')
        expect(page).to have_current_path(new_user_registration_path)
        fill_in 'user[email]', :with => Faker::Internet.email
        fill_in 'user[password]', :with => 'password'
        fill_in 'user[password_confirmation]', :with => 'password'
        find_button('Sign up').click
        expect(page).to have_current_path(root_path)
      end
    end
  end
end

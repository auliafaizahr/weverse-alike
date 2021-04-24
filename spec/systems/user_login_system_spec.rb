require "rails_helper"
require_relative './method_helper.rb'

RSpec.describe "Login", js:true, type: :system do
  describe 'Signing in' do
    context 'sign in fans' do
      before(:each) do
        @user = FactoryBot.create(:user)
        @user.save
      end

      it 'success to login' do
        visit(root_path)
        expect(page).to have_current_path(new_user_session_path)
        fill_in 'user_email', :with => @user.email
        fill_in 'user_password', :with => @user.password
        find('.submit_btn_login').click
        expect(page).to have_current_path(root_path)
      end

      it 'failed to login' do
        visit(root_path)
        expect(page).to have_current_path(new_user_session_path)
        fill_in 'user_email', :with => @user.email
        failed_login
      end

      it 'sign out successfully' do
        login_user
        to_group_posts
        visit(group_posts_path(Group.first))
        execute_script('$(".dropdown-menu").toggleClass("show")')
        find('.dropdown-item', text: 'Sign out').click
        expect(page).to have_current_path(new_user_session_path)
      end

    end

    context 'Artist sign in' do
      before(:each) do
        @artist = User.new(email: "cyeonjun@gmail.com", password: "password", username: "ChoiYeonjun", name: "Choi Yeonjun", type_user: 0)
        @artist.save
        @group =  Group.new(name: "Tomorrow X Together")
        @group.save
        @group.join_groups.build(user_id: @artist.id, username: "fansX").save
      end

      it 'success to login' do
        visit(root_path)
        expect(page).to have_current_path(new_user_session_path)
        fill_in 'user_email', :with => @artist.email
        fill_in 'user_password', :with => "password"
        find('.submit_btn_login').click
        expect(page).to have_current_path(group_posts_path(@group))
      end

      it 'failed to login' do
        visit(root_path)
        expect(page).to have_current_path(new_user_session_path)
        fill_in 'user_email', :with => @artist.email
        failed_login
      end
    end

    context 'Admin sign in' do
      before(:each) do
        @admin = User.new(email: "admin@admin.com", password: "password", username: "ChoiYeonjun", name: "Choi Yeonjun", type_user: 2)
        @admin.save
      end

      it 'success login' do
        visit(root_path)
        expect(page).to have_current_path(new_user_session_path)
        fill_in 'user_email', :with => @admin.email
        fill_in 'user_password', :with => "password"
        find('.submit_btn_login').click
        expect(page).to have_current_path(admins_path)
      end

      it 'failed to login' do
        visit(root_path)
        expect(page).to have_current_path(new_user_session_path)
        fill_in 'user_email', :with => @admin.email
        failed_login
      end
    end

    def failed_login
      fill_in 'user_password', :with => ""
      find('.submit_btn_login').click
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end

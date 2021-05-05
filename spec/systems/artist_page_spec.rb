require "rails_helper"
require_relative './method_helper.rb'

RSpec.describe "User Activity", js:true, type: :system do
  describe 'User activity on artist feed' do
    context 'When user on artist feed page' do
      before(:each) do
        login_user
        username_first
        to_group_posts
        create_post
        create_txt_artists
        artist_create_posts
      end

      it 'on artist feed page' do
        visit(group_artist_posts_path(Group.first))
        expect(page).to have_selector('.card-body', count: 10)
        expect(page).to have_current_path(group_artist_posts_path(Group.first))
      end

      it 'filter artist only without date', js: true do
        visit(group_artist_posts_path(Group.first))
        select 'Hueningkai', from: 'user_id'
        find_button('Filter').click
        expect(page).to have_selector('.card-body', count: 2)
      end

      it 'filter artist and date then show some posts', js: true do
        visit(group_artist_posts_path(Group.first))
        select 'Hueningkai', from: 'user_id'
        fill_in 'date_filter', with: '04/11/2021 - 04/30/2021'
        find_button('Apply').click
        find_button('Filter').click
        expect(page).to have_selector('.card-body', count: 0)
      end

      it 'filter artist and date but show no posts' do
        visit(group_artist_posts_path(Group.first))
        select 'Hueningkai', from: 'user_id'
        fill_in 'date_filter', with: '02/01/2021 - 02/28/2021'
        find_button('Apply').click
        find_button('Filter').click
        expect(page).to have_selector('.card-body', count: 0)
      end
    end
  end
end
require "rails_helper"
require_relative '../support/admin_helper.rb'
require_relative './method_helper.rb'

RSpec.describe "Admin Activity", js:true, type: :system do
  describe 'When Admin doing activity' do
    context 'When admin login' do
      before(:each) do
        create_admin
        create_group
        login_admin
      end

      it 'show admin index page', js: true do
        visit(root_path)
        expect(page).to have_content('Tomorrow X Together')
        expect(page).to have_content('BTS')
      end
    end

    context 'when admin edit group' do
      context 'when admin change group picture' do
        before(:each) do
          create_admin
          create_group
          login_admin
          create_txt_artists
        end

        it 'change first group picture succesfully' do
          visit(admins_path)
          find_link('Edit', match: :first).click
          expect(page).to have_current_path(group_path(Group.first))
          find_button('Edit').click
          find('form input[type="file"]').set('/home/auliafaizahr/Pictures/porto/taehyuuun.png')
          find_button('Update')
          expect([:notice]).to be_present
          expect(page).to have_current_path(group_path(Group.first))
        end

        it 'failed to change group picture because the file is too big' do
          visit(admins_path)
          find_link('Edit', match: :first).click
          expect(page).to have_current_path(group_path(Group.first))
          find_button('Edit').click
          find('form input[type="file"]').set('/home/auliafaizahr/Downloads/Telegram Desktop/1. Ola plays month (2).jpg')
          find_button('Update')
          expect([:warning]).to be_present
        end

        it 'failed to change group picture because wrong file extension' do
          visit(admins_path)
          find_link('Edit', match: :first).click
          expect(page).to have_current_path(group_path(Group.first))
          find_button('Edit').click
          find('form input[type="file"]').set('/home/auliafaizahr/Downloads/Program Liqo Uszar Group C 32-02.xlsx')
          find_button('Update')
          expect([:warning]).to be_present
        end
      end

      context 'when admin add new user as artist' do
        before(:each) do
          create_admin
          create_group
          login_admin
        end

        it 'add new artist' do
          visit(admins_path)
          find_link('Edit', match: :first).click
          find_button('Tambah User').click
          select 'Artist', from: 'user_type_user'
          fill_in 'user[name]', with: Faker::Name.name
          fill_in 'user[email]', with: Faker::Internet.email
          fill_in 'user[username]', with: Faker::Internet.username
          fill_in 'user[password]', with: 'password'
          find_button('Add').click
          expect([:notice]).to be_present
        end

        it 'assign artist to group' do
          create_artist
          visit(admins_path)
          find_link('Edit', match: :first).click
          find_button('Tambah Artist').click
          first('#join_group_user_id option', minimum: 1).select_option
          fill_in 'join_group[username]', with: Faker::Internet.username
          find_button('Update').click
        end
      end
    end
  end
end
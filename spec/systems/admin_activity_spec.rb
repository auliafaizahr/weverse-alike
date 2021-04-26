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
      end
    end
  end
end
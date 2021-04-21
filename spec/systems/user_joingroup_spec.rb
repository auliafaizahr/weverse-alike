require "rails_helper"

RSpec.describe "User Join Group", js:true, type: :system do
  describe 'Join Group' do
    context 'User join group' do
      before(:each) do
        login_user
      end

      context 'when havent join group' do
        it 'successfully join group' do
          visit(root_path)
          expect(page).to have_text('Tomorrow X Together')
          find('.card-body', text: 'Tomorrow X Together').click
          expect(page).to have_current_path(new_group_join_group_path(Group.first))
          fill_in 'join_group[username]', with: Faker::Internet.user_name
          find_button('Join').click
          expect(page).to have_current_path(group_posts_path(Group.first))
        end

        it 'unsuccessfully join group because username already exist' do
          username_first
          visit(root_path)
          expect(page).to have_text('Tomorrow X Together')
          find('.card-body', text: 'Tomorrow X Together').click
          expect(page).to have_current_path(new_group_join_group_path(Group.first))
          fill_in 'join_group[username]', with: "bucintubatu"
          find_button('Join').click
          expect(page).to have_current_path(new_group_join_group_path(Group.first))
        end
      end
    end

    def login_user
      @user = FactoryBot.create(:user)
      @user.save
      groups = ['Tomorrow X Together', 'BTS', 'Seventeen']
      groups.each do |group|
        @group = Group.new(name: group)
        @group.save
      end
      visit(root_path)
      expect(page).to have_current_path(new_user_session_path)
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
      find('.submit_btn_login').click
      expect(page).to have_current_path(root_path)
      within('.row_content') do
        expect(page).to have_css('.card')
      end
    end

    def username_first
      user = FactoryBot.create(:user)
      user.save
      @join_group = Group.first.join_groups.build(user_id: user.id, username: "bucintubatu")
      @join_group.save
    end
  end
end



require "rails_helper"

RSpec.describe "User Activity", js:true, type: :system do
  describe 'User activity' do
    context 'When user change username' do
      before(:each) do
        login_user
        username_first
        to_group_posts
      end

      it 'successfully change username', js: true do
        visit(group_posts_path(Group.first))
        # add trigger before toggle menu show up here
        execute_script('$(".dropdown-menu").toggleClass("show")')
        find('.dropdown-item', text: 'Change Username').click
        fill_in 'join_group[username]', with: Faker::Internet.user_name
        find_button('Update').click
        expect(page).to have_text('Username updated successfuly')
        expect(page).to have_current_path(group_posts_path(Group.first))
      end

      it 'unsuccessfully change username' do
        visit(group_posts_path(Group.first))
        # add trigger before toggle menu show up here
        execute_script('$(".dropdown-menu").toggleClass("show")')
        find('.dropdown-item', text: 'Change Username').click
        fill_in 'join_group[username]', with: "bucintubatu"
        find_button('Update').click
        expect([:warning]).to be_present
      end
    end

    context 'When user change display picture' do
      before(:each) do
        login_user
        username_first
        to_group_posts
      end

      it 'successfully change display', js: true do
        visit(group_posts_path(Group.first))
        # add trigger before toggle menu show up here
        execute_script('$(".dropdown-menu").toggleClass("show")')
        find('.dropdown-item', text: 'Change Username').click
        find('form input[type="file"]').set('/home/auliafaizahr/Pictures/porto/taehyuuun.png')
        find_button('Update').click
        visit(group_posts_path(Group.first))
      end

      it 'failed because wrong type file', js: true do
        visit(group_posts_path(Group.first))
        # add trigger before toggle menu show up here
        execute_script('$(".dropdown-menu").toggleClass("show")')
        find('.dropdown-item', text: 'Change Username').click
        find('form input[type="file"]').set('/home/auliafaizahr/Downloads/Program Liqo Uszar Group C 32-02.xlsx')
        find_button('Update').click
        expect([:notice]).to be_present
      end

      it 'failed because the size too big', js: true do
        visit(group_posts_path(Group.first))
        # add trigger before toggle menu show up here
        execute_script('$(".dropdown-menu").toggleClass("show")')
        find('.dropdown-item', text: 'Change Username').click
        find('form input[type="file"]').set('/home/auliafaizahr/Downloads/Telegram Desktop/1. Ola plays month (2).jpg')
        find_button('Update').click
        expect([:warning]).to be_present
      end
    end

    context 'when create post' do
      before(:each) do
        login_user
        username_first
        to_group_posts
      end

      it 'success with writing only', js: true do
        visit(group_posts_path(Group.first))
        fill_in 'post[post]', with: 'This is my first post'
        find_button('Post').click
        expect([:notice]).to be_present
      end

      it 'upload valid one attachment and succeed', js: true do
        visit(group_posts_path(Group.first))
        fill_in 'post[post]', with: 'Try with attachment'
        Capybara.ignore_hidden_elements = false
        attach_file('post_attachments[avatar][]', '/home/auliafaizahr/Pictures/porto/taehyuuun.png')
        find_button('Post').click
        expect([:notice]).to be_present
      end

      it 'attach more than one valid attachments and succeed', js: true do
        visit(group_posts_path(Group.first))
        fill_in 'post[post]', with: 'Try with attachment'
        Capybara.ignore_hidden_elements = false
        attach_file('post_attachments[avatar][]', ['/home/auliafaizahr/Pictures/porto/taehyuuun.png', '/home/auliafaizahr/Downloads/5ce1d72c-0129-414a-a9fa-adf1d31f155a.jpeg' ])
        find_button('Post').click
        expect([:notice]).to be_present
      end

      it 'failed because its empty post', js: true do
        visit(group_posts_path(Group.first))
        fill_in 'post[post]', with: ' '
        find_button('Post').click
        expect([:warning]).to be_present
      end

      it 'failed because the attachments is too big', js: true do
        visit(group_posts_path(Group.first))
        fill_in 'post[post]', with: 'Try with attachment'
        Capybara.ignore_hidden_elements = false
        attach_file('post_attachments[avatar][]', ['/home/auliafaizahr/Pictures/EoyHrWNUYAAqkfk.jpeg'])
        find_button('Post').click
        expect([:warning]).to be_present
      end

      it 'failed because the attachments type isnt valid', js: true do
        visit(group_posts_path(Group.first))
        fill_in 'post[post]', with: 'Try with attachment'
        Capybara.ignore_hidden_elements = false
        attach_file('post_attachments[avatar][]', ['/home/auliafaizahr/Downloads/trymyui_tester_agreement.pdf'])
        find_button('Post').click
        expect([:warning]).to be_present
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

    def to_group_posts
      visit(root_path)
      expect(page).to have_text('Tomorrow X Together')
      find('.card-body', text: 'Tomorrow X Together').click
      expect(page).to have_current_path(new_group_join_group_path(Group.first))
      fill_in 'join_group[username]', with: Faker::Internet.user_name
      find_button('Join').click
      expect(page).to have_current_path(group_posts_path(Group.first))
    end

    def username_first
      user = FactoryBot.create(:user)
      user.save
      @join_group = Group.first.join_groups.build(user_id: user.id, username: "bucintubatu")
      @join_group.save
    end
  end
end



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

def create_group
  group_names = ['Tomorrow X Together', 'BTS', 'Gfriend', 'Seventeen', 'Nuest']
  group_names.each do |name|
    Group.create(name: name).save
  end
end

def create_post
  3.times do
    User.first.posts.build(post: "post test", group_id: Group.first.id).save
  end
end

def create_comment
  Post.first.comments.build(comment: "Ini komen pertama", user_id: User.first.id).save
  Post.first.comments.first.likes.build(user_id: User.first.id).save
end
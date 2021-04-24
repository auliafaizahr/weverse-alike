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
end

def create_likes_on_comment
  Post.first.comments.first.likes.build(user_id: User.first.id).save
end

def create_txt_artists
  members = [
              { email: 'csoobin@gmail.com',
                name: 'Choi Soobin',
                username: 'csoobin',
                password: 'password',
                type_user: 0
              },
              { email: 'cyeonjun@gmail.com',
                name: 'Choi Yeonjun',
                username: 'cyeonjun',
                password: 'password',
                type_user: 0
              },
              { email: 'cbeomgyu@gmail.com',
                name: 'Choi Beomgyu',
                username: 'cbeomgyu',
                password: 'password',
                type_user: 0
              },
              { email: 'ktaehyun@gmail.com',
                name: 'Kang Taehyun',
                username: 'ktaehyun',
                password: 'password',
                type_user: 0
              },
              { email: 'hueningkai@gmail.com',
                name: 'Hueningkai',
                username: 'hueningkai',
                password: 'password',
                type_user: 0
              }
  ]

  members.each do |member|
    user = User.create(email: member[:email], name: member[:name], username: member[:username], password: member[:password], type_user: member[:type_user])
    user.save
  end

  txt_artists = User.artist
  txt_artists.each do |artist|
    joined = Group.first.join_groups.build(user_id: artist.id, username: artist.username)
    joined.save
  end
end

def artist_create_posts
  txt_artists = Group.first.users.artist
  txt_artists.each do |artist|
    2.times do
      post = Group.first.posts.build(post: Faker::Lorem.paragraph, user_id: artist.id)
      post.save
    end
  end
end
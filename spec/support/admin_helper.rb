
def create_admin
  user = User.create(email: Faker::Internet.email, name: Faker::Internet.name, username: Faker::Internet.user_name, password: 'password', type_user: 2)
  user.save
end

def login_admin
  user = User.admin.first
  visit(root_path)
  expect(page).to have_current_path(new_user_session_path)
  fill_in 'user_email', :with => user.email
  fill_in 'user_password', :with => 'password'
  find_button('Log in').click
  expect(page).to have_current_path(admins_path)
end

def create_artist
  10.times do
    artist = User.create(email: Faker::Internet.email, name: Faker::Internet.name, username: Faker::Internet.user_name, password: 'password', type_user: 0)
    artist.save
  end
end

def join_artist
  artists = User.artists
  artists.last(5).each do |artist|
    joined = Group.find(2).join_groups.build(user_id: artist.id, username: artist.username)
    joined.save
  end
end
require "rails_helper"
require_relative './method_helper.rb'

RSpec.describe "User Activity", js:true, type: :system do
  describe 'User activity on comments and like' do
    context 'When user comment or like on post' do
      before(:each) do
        login_user
        username_first
        to_group_posts
        create_post
      end

      it 'comments successfully', js: true do
        visit(group_posts_path(Group.first))
        first('.input_comment').set("hehe first comment")
        first('.comment_button').click
        expect(page).to have_content("hehe first comment")
        expect(Post.count).to eq(3)
        expect(Post.last.comments.count).to eq(1)
      end

      it 'comments unsuccessfully because empty field', js: true do
        visit(group_posts_path(Group.first))
        first('.input_comment').set("  ")
        first('.comment_button').click
        expect([:warning]).to be_present
      end

      it 'like the post', js: true do
        visit(group_posts_path(Group.first))
        first('#like_button').click
        page.evaluate_script 'window.location.reload()'
        expect(Post.last.likes.count).to eq(1)
      end

      it 'unlike the post', js: true do
        visit(group_posts_path(Group.first))
        first('#like_button').click
        page.evaluate_script 'window.location.reload()'
        expect(Post.last.likes.count).to eq(1)
        first('#unlike_button').click
        page.evaluate_script 'window.location.reload()'
        expect(Post.last.likes.count).to eq(0)
      end

      it 'like comment from post', js: true do
        visit(group_posts_path(Group.first))
        create_comment
        evaluate_script 'window.location.reload()'
        first('#like_comment').click
        evaluate_script 'window.location.reload()'
        expect(Post.first.comments.first.likes.size).to eq(1)
      end

      it 'unlike comment from post', js: true do
        create_comment
        create_likes_on_comment
        page.evaluate_script 'window.location.reload()'
        visit(group_posts_path(Group.first))
        first('#unlike_comment').click
        page.evaluate_script 'window.location.reload()'
        expect(Post.first.comments.first.likes.size).to eq(0)
      end
    end
  end
end
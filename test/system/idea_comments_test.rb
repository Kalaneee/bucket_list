require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
  test 'adding a Comment to an Idea' do
    user = User.new email: 'valikaelin@gmail.com', password: 'password'
    user.save!

    idea = Idea.new title: 'Valid idea', user: user
    idea.save!

    visit(new_session_path)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in')

    visit(idea_path(idea))
    fill_in('Add a comment', with: 'This is a fantastic idea!')
    click_on('Post', match: :first)

    assert_equal idea_path(idea), page.current_path
    assert page.has_content?('This is a fantastic idea!')
  end

  test 'comments cannot be added when not logged in' do
    idea = Idea.new title: 'Valid idea', user: User.new
    idea.save!

    visit(idea_path(idea))
    refute page.has_content?('Add a Comment')
  end
end

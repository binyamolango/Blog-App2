require 'rails_helper'

RSpec.describe Post, type: :model do
  # tests go here
  user1 = User.new(name: 'Binyam', photo: 'url', bio: 'Hi there', posts_count: 3)
  subject { Post.new(author: user1, title: 'Hello', text: 'This is my first post', comments_count: 2, likes_count: 3) }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title character should be maximum of 250' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'text should be present' do
    expect(subject.text).to eq 'This is my first post'
  end

  it 'comments_count should be integer' do
    subject.comments_count = 3.5
    expect(subject).to_not be_valid
  end

  it 'comments_count should be greater or equal to zero' do
    subject.comments_count = -4
    expect(subject).to_not be_valid
  end

  it 'likes_count should be integer' do
    subject.likes_count = 3.5
    expect(subject).to_not be_valid
  end

  it 'likes_count should be greater or equal to zero' do
    subject.likes_count = -4
    expect(subject).to_not be_valid
  end

  it '#update_posts_counter method should increment posts_count in user model' do
    subject.update_posts_counter
    expect(user1.posts_count).to eq 4
  end

  it '#recent_comments method should display 5 recent comments' do
    # Stub out the database interaction
    comments_relation = double('comments_relation')
    allow(subject).to receive(:comments).and_return(comments_relation)

    # Define the expected behavior of the mocked posts_relation
    recent_comments = [
      double('fifthcomments'),
      double('fourthcomments'),
      double('thirdcomments'),
      double('secondcomments'),
      double('firstcomments')
    ]
    expect(comments_relation).to receive(:order).with(updated_at: :desc).and_return(comments_relation)
    expect(comments_relation).to receive(:limit).with(5).and_return(recent_comments)

    # Call the method and verify the result
    expect(subject.recent_comments).to eq recent_comments
  end
end

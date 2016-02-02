class CreateSeeds

  def new_user(amount, username, email, role)
    i = 0
    loop do
      break if i > 1000
      break if amount <= 0
      u = User.new(
        email: email,
        username: username,
        password: "fakefake",
        password_confirmation: "fakefake",
        confirmed_at: Time.now,
        role: role
      )
      if u.save
        amount -= 1
        puts u.username
      end
      i += 1
      email = Faker::Internet.safe_email
      username = Faker::Internet.user_name
    end
  end

  def new_friendship_type(amount, type, users)
    i = 0
    loop do
      break if i > 1000
      break if amount <= 0

      user = users.sample
      friend = users.sample
        f = type.new(
          user_id: user.id,
          friend_id: friend.id
        )
        if f.save
          amount -= 1
        end
      i += 1
    end
  end

  def new_post(amount, users)
    amount.times do
      user = users.sample
      post = Post.create!(
        user_id: user.id,
        body: Faker::Hipster.paragraph
      )
      user.activities.create!(
        action: "create",
        trackable: post
      )
    end
  end

  def new_comment(amount, users, posts)
    amount.times do
      user = users.sample
      post = posts.sample
      Comment.create!(
        user_id: user.id,
        post_id: post.id,
        body: Faker::Hipster.paragraph
      )
    end
  end

  def new_vote(amount, votes_on, votable_type, voters)
    i = 0
    loop do
      break if i > 1000
      break if amount <= 0

      user = voters.sample
      post_or_comment = votes_on.sample

        v = user.votes.new(
          votable: post_or_comment,
          votable_type: votable_type,
          vote_flag: [true,false].sample,
          vote_weight: 1
        )
        if v.save
          amount -= 1
        end
      i += 1
    end
  end


end

create = CreateSeeds.new

create.new_user(1, "toyhammered", "daniel@rassiner.com", :admin)
create.new_user(1, "admin","admin@example.com", :admin)
create.new_user(1, "standard", "standard@example.com", :standard)
create.new_user(7, Faker::Internet.user_name, Faker::Internet.safe_email, :standard)
users = User.all

create.new_friendship_type(25, PendingFriendship, users)
create.new_friendship_type(25, Friendship, users)

create.new_post(50, users)
posts = Post.all

create.new_comment(100, users, posts)
comments = Comment.all

create.new_vote(100, posts, "Post", users)
create.new_vote(100, comments, "Comment", users)

# Seeding Completed
puts "Seeding Finished."
puts "#{User.count} users created."
puts "#{PendingFriendship.count} pending friendships created."
puts "#{Friendship.count} friendships created."
puts "#{Post.count} posts created."
puts "#{Comment.count} comments created."
puts "#{ActsAsVotable::Vote.count} votes created."

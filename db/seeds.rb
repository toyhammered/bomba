class CreateSeeds

  def new_user(amount, username, email, role)
    amount.times do
      u = User.new(
        email: email,
        username: username,
        password: "fakefake",
        password_confirmation: "fakefake",
        confirmed_at: Time.now,
        role: role
      )
      unless u.save
        email = Faker::Internet.safe_email
        username = Faker::Internet.user_name
        # u.update_attributes(email: Faker::Internet.safe_email, username: Faker::Internet.user_name)
      end
    end
  end

  def new_active_friendship(amount,users)
    i = 0
    loop do
      break if i > 1000
      break if amount <= 0

      user = users.sample
      friend = users.sample
      unless user == friend
        f = Friendship.new(
          user_id: user.id,
          friend_id: friend.id,
          status: 1,
          friended_at: Time.now
        )
        if f.save
          amount -= 1
        end
      end
      i += 1
    end
  end

  def new_pending_friendship()

  end

  def new_requested_friendship()

  end

end

create = CreateSeeds.new

create.new_user(1, "toyhammered", "daniel@rassiner.com", :admin)
create.new_user(1, "admin","admin@example.com", :admin)
create.new_user(1, "standard", "standard@example.com", :standard)
create.new_user(200, Faker::Internet.user_name, Faker::Internet.safe_email, :standard)
users = User.all

create.new_active_friendship(200, users)


# Seeding Completed
puts "Seeding Finished."
puts "#{User.count} users created."
puts "#{Friendship.count} friendships created."

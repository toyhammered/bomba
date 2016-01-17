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
        u.update_attributes(email: Faker::Internet.safe_email, username: Faker::Internet.user_name)
      end
    end
  end

end

create = CreateSeeds.new

create.new_user(1, "toyhammered", "daniel@rassiner.com", :admin)
create.new_user(1, "admin","admin@example.com", :admin)
create.new_user(1, "standard", "standard@example.com", :standard)
create.new_user(5, Faker::Internet.user_name, Faker::Internet.safe_email, :standard)




# Seeding Completed
puts "Seeding Finished."
puts "#{User.count} users created."

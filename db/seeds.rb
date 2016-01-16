class CreateSeeds

  def new_user(amount, email, role)
    amount.times do
      u = User.new(
        email: email,
        password: "fakefake",
        password_confirmation: "fakefake",
        confirmed_at: Time.now,
        role: role
      )
      unless u.save
        u.update_attributes(email: Faker::Internet.safe_email)
      end
    end
  end

end

create = CreateSeeds.new

create.new_user(1,"daniel@rassiner.com", :admin)
create.new_user(1,"admin@example.com", :admin)
create.new_user(1,"standard@example.com", :standard)
create.new_user(5, Faker::Internet.safe_email, :standard)




# Seeding Completed
puts "Seeding Finished."
puts "#{User.count} users created."

# frozen_string_literal: true
# create users
20.times do
  user = User.create!(first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      nick: Faker::Name.first_name,
                      password: 'Altair_69',
                      password_confirmation: 'Altair_69',
                      email: Faker::Internet.email)
  img = Attachment.new(attachable_type: 'User', attachable_id: user.id)
  img.remote_file_url = Faker::Avatar.image
  img.save
end

User.create!(first_name: 'Vadim',
             last_name: 'Sokoltsov',
             nick: 'vforvad',
             password: 'Altair_69',
             password_confirmation: 'Altair_69',
             email: 'vforvad@gmail.com')

# create courses for each user
User.all.each do |user|
  15.times do
    direction = Direction.create!(
      title: Faker::App.name,
      description: Faker::Hacker.say_something_smart,
      user_id: user.id,
      slug: Faker::App.name.underscore.gsub(/\.|-/, '_')
    )

    5.times do
      direction.steps.create!(
        title: Faker::Hipster.sentence,
        description: Faker::Hipster.paragraph
      )
    end
  end
end

# Randomly set state for steps
Step.all.each do |step|
  Random.new_seed.odd? ? step.update(is_done: true) : step.update(is_done: false)
end

# Set finished steps count
Direction.all.each do |direction|
  steps_count = direction.steps.size
  finished_steps_count = direction.steps.select(&:is_done).size
  direction.update(steps_count: steps_count, finished_steps_count: finished_steps_count)
end

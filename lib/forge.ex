defmodule Forge do
  use Blacksmith

  @save_one_function &Blacksmith.Config.save/1
  @save_all_function &Blacksmith.Config.save_all/1

  register :message, %Herework.Message{
    title: Faker.Lorem.word
  }

  register :comment, %Herework.Comment{
    body: Faker.Lorem.sentence
  }

  register :user, %Herework.User{
    avatar: Faker.Internet.image_url,
    name: Faker.Name.name,
    email: Faker.Internet.email
  }
end

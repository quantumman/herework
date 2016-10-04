defmodule Forge do
  use Blacksmith

  @save_one_function &Blacksmith.Config.save/1
  @save_all_function &Blacksmith.Config.save_all/1

  register :message, %Herework.Message{
    title: Faker.Lorem.word
  }
end

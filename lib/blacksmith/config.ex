defmodule Blacksmith.Config do
  def save(model) do
    Herework.Repo.insert(model)
  end

  def save_all(list) do
    Enum.map(list, &Herework.Repo.insert/1)
  end
end

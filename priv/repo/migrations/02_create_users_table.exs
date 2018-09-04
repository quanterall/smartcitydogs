defmodule Smartcitydogs.Repo.Migrations.Users do
  use Ecto.Migration

  def up do
    create table("users") do
      add(:username, :text)
      add(:password_hash, :text)
      add(:first_name, :text)
      add(:last_name, :text)
      add(:email, :text)
      add(:phone, :text)
      add(:reset_password_token, :text)
      add(:reset_token_sent_at, :naive_datetime)
      add(:deleted_at, :naive_datetime)
      add(:liked_signals, {:array, :integer})
      add(:liked_comments, {:array, :integer})
      add(:disliked_comments, {:array, :integer})
      add(:users_types_id, references("users_types"))
      timestamps()
    end
  end
end

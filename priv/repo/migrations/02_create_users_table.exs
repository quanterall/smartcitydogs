defmodule Smartcitydogs.Repo.Migrations.Users do
  use Ecto.Migration

  def up do
    create table("users") do
      add(:password_hash, :text, null: false)
      add(:first_name, :text, null: false)
      add(:last_name, :text, null: false)
      add(:email, :text, null: false)
      add(:phone, :text, null: false)
      add(:reset_password_token, :text)
      add(:reset_token_sent_at, :naive_datetime)
      add(:agreed_to_terms, :boolean, default: false, null: false)
      add(:user_type, :text, default: "citizen", null: false)
      timestamps()
    end
  end
end

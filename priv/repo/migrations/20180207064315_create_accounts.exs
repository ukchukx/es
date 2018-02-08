defmodule Es.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
  	create table(:accounts, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :account_number, :string
      add :name, :string
      add :balance, :float

      timestamps()
    end
    create unique_index(:accounts, [:account_number])
  end
end

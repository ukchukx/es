defmodule Es.Repo.Migrations.CreateWithdrawalStats do
  use Ecto.Migration

  def change do
  	create table(:withdrawal_stats, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :account_number, :string
      add :atm, :integer
      add :branch, :integer

      timestamps()
    end
    create unique_index(:withdrawal_stats, [:account_number])
  end
end

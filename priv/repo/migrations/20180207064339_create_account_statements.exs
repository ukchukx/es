defmodule Es.Repo.Migrations.CreateAccountStatements do
  use Ecto.Migration

  def change do
  	create table(:account_statements, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :account_number, :string
      add :transactions, {:array, :map}

      timestamps()
    end
    create unique_index(:account_statements, [:account_number])
  end
end

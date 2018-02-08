defmodule Es.Accounts.Projections.AccountStatement do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}


  schema "account_statements" do
    field :account_number, :string
    field :transactions, {:array, :map}, default: []

    timestamps()
  end
end

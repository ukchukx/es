defmodule Es.Accounts.Projections.Account do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}


  schema "accounts" do
    field :account_number, :string
    field :name, :string
    field :balance, :float, default: 0.0

    timestamps()
  end
end

defmodule Es.Accounts.Projections.WithdrawalStat do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}


  schema "withdrawal_stats" do
    field :account_number, :string
    field :atm, :integer, default: 0
    field :branch, :integer, default: 0

    timestamps()
  end
end

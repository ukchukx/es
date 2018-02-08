defmodule Es.Accounts.Validators.UniqueAccountNumber do
  use Vex.Validator

  alias Es.Accounts
  alias Es.Accounts.Projections.Account

  def validate(account_number, context) do
    account_uuid = Map.get(context, :account_uuid)

    case account_number_taken?(account_number, account_uuid) do
      true -> {:error, "has already been taken"}
      false -> :ok
    end
  end

  defp account_number_taken?(account_number, account_uuid) do
    case Accounts.account_by_account_number(account_number) do
      %Account{uuid: ^account_uuid} -> false
      nil -> false
      _ -> true
    end
  end
end
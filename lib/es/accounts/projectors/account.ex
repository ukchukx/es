defmodule Es.Accounts.Projectors.Account do
  use Commanded.Projections.Ecto, 
    name: "Accounts.Projectors.Account",
    consistency: :strong

  alias Es.Accounts.Events.{
    AccountCreated,
    MoneyDeposited,
    MoneyWithdrawn
  }
  alias Es.Accounts.Projections.Account

  project %AccountCreated{} = registered do
    Ecto.Multi.insert(multi, :account, %Account{
      uuid: registered.account_uuid,
      account_number: registered.account_number,
      name: registered.name,
      balance: registered.initial_balance
    })
  end

  project %MoneyDeposited{account_uuid: account_uuid, amount: amount} do
    Ecto.Multi.update_all(multi, :account, account_query(account_uuid), inc: [balance: amount])
  end

  project %MoneyWithdrawn{account_uuid: account_uuid, amount: amount} do
    Ecto.Multi.update_all(multi, :account, account_query(account_uuid), inc: [balance: -amount])
  end

  defp account_query(account_uuid), do: from(a in Account, where: a.uuid == ^account_uuid)
end
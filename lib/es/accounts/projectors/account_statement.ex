defmodule Es.Accounts.Projectors.AccountStatement do
  use Commanded.Projections.Ecto, 
    name: "Accounts.Projectors.AccountStatement",
    consistency: :strong

  alias Es.Accounts.Events.{
    AccountStatementCreated,
    AccountStatementTransactionAdded
  }
  alias Es.Accounts.Projections.AccountStatement

  project %AccountStatementCreated{} = registered do
    Ecto.Multi.insert(multi, :account_statement, %AccountStatement{
      uuid: registered.account_statement_uuid,
      account_number: registered.account_number,
      transactions: []
    })
  end

  project %AccountStatementTransactionAdded{account_statement_uuid: uuid, timestamp: ts, transaction: t} do
    Ecto.Multi.update_all(multi, :account_statement, query(uuid), push: [transactions: Map.put(t, :timestamp, ts)])
  end

  defp query(uuid), do: from(as in AccountStatement, where: as.uuid == ^uuid)
end
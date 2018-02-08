defmodule Es.Accounts.Aggregates.AccountStatement do
  defstruct [
    :uuid,
    :account_number,
    :transactions
  ]

  alias Es.Accounts.Aggregates.AccountStatement
  alias Es.Accounts.Commands.{
    CreateAccountStatement,
    AddAccountStatementTransaction
  }
  alias Es.Accounts.Events.{
    AccountStatementCreated,
    AccountStatementTransactionAdded
  }

  def execute(%AccountStatement{uuid: nil}, %CreateAccountStatement{} = create) do
    %AccountStatementCreated{
      account_statement_uuid: create.account_statement_uuid,
      account_number: create.account_number,
      transactions: []
    }
  end

  def execute(%AccountStatement{uuid: uuid}, %AddAccountStatementTransaction{transaction: t}) do
    %AccountStatementTransactionAdded{
      account_statement_uuid: uuid,
      transaction: t,
      timestamp: DateTime.utc_now |> DateTime.to_unix(:milliseconds)
    }
  end

  # state mutators

  def apply(%AccountStatement{} = as, %AccountStatementCreated{} = created) do
    %AccountStatement{as |
      uuid: created.account_statement_uuid,
      account_number: created.account_number,
      transactions: MapSet.new()
    }
  end

  def apply(%AccountStatement{} = as, %AccountStatementTransactionAdded{transaction: t}) do
    %AccountStatement{as | transactions: MapSet.put(as.transactions, t)}
  end
end
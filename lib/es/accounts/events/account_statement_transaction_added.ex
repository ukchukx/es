defmodule Es.Accounts.Events.AccountStatementTransactionAdded do
  @derive [Poison.Encoder]
  defstruct [
    :account_statement_uuid,
    :transaction,
    :timestamp
  ]
end
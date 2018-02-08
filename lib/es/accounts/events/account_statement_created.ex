defmodule Es.Accounts.Events.AccountStatementCreated do
  @derive [Poison.Encoder]
  defstruct [
    :account_statement_uuid,
    :account_number,
    :transactions
  ]
end
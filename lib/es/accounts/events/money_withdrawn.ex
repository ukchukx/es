defmodule Es.Accounts.Events.MoneyWithdrawn do
  @derive [Poison.Encoder]
  defstruct [
    :account_uuid,
    :account_number,
    :amount,
    :where
  ]
end
defmodule Es.Accounts.Events.AccountCreated do
  @derive [Poison.Encoder]
  defstruct [
    :account_uuid,
    :account_number,
    :name,
    :initial_balance,
  ]
end
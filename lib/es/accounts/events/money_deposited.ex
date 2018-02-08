defmodule Es.Accounts.Events.MoneyDeposited do
  @derive [Poison.Encoder]
  defstruct [
    :account_uuid,
    :account_number,
    :amount
  ]
end
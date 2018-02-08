defmodule Es.Accounts.Events.WithdrawalStatCreated do
  @derive [Poison.Encoder]
  defstruct [
    :withdrawal_stat_uuid,
    :account_number,
    :atm,
    :branch,
  ]
end
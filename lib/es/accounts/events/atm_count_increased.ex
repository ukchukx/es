defmodule Es.Accounts.Events.AtmCountIncreased do
  @derive [Poison.Encoder]
  defstruct [
    :withdrawal_stat_uuid,
    :count
  ]
end
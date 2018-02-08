defmodule Es.Accounts.Events.BranchCountIncreased do
  @derive [Poison.Encoder]
  defstruct [
    :withdrawal_stat_uuid,
    :count
  ]
end
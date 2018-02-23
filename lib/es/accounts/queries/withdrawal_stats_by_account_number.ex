defmodule Es.Accounts.Queries.WithdrawalStatsByAccountNumber do
  import Ecto.Query

  alias Es.Accounts.Projections.WithdrawalStat

  def new(account_number), do: from w in WithdrawalStat, where: w.account_number == ^account_number
end
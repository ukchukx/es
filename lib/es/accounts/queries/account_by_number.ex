defmodule Es.Accounts.Queries.AccountByNumber do
  import Ecto.Query

  alias Es.Accounts.Projections.Account

  def new(account_number), do: from a in Account, where: a.account_number == ^account_number
end
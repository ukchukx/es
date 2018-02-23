defmodule Es.Accounts.Queries.AccountStatementByNumber do
  import Ecto.Query

  alias Es.Accounts.Projections.AccountStatement

  def new(account_number), do: from a in AccountStatement, where: a.account_number == ^account_number
end
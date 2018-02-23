defmodule Es.Fixture do
  import Es.Factory
  
  alias Es.Accounts

  def fixture(resource, attrs \\ [])


  def fixture(:account, attrs), do: build(:account, attrs) |> Accounts.create_account

  def create_account(_context) do
    {:ok, account} = fixture(:account)

    [account: account]
  end
end
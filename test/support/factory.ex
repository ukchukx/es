defmodule Es.Factory do
  use ExMachina

  alias Es.Accounts.Commands.CreateAccount

  def account_factory do
    %{
      account_number: "0010020123",
      name: "Jane Street",
      initial_balance: 0.0
    }
  end

  def create_account_factory do
    struct(CreateAccount, build(:account))
  end
end
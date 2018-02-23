defmodule Es.Accounts.Aggregates.Account do
  defstruct [
    :uuid,
    :account_number,
    :name,
    :balance,
  ]

  alias Es.Accounts.Aggregates.Account
  alias Es.Accounts.Commands.{
    CreateAccount,
    DepositMoney,
    WithdrawMoney
  }
  alias Es.Accounts.Events.{
    AccountCreated,
    MoneyDeposited,
    MoneyWithdrawn
  }

  @doc """
  Create a new account
  """
  def execute(%Account{uuid: nil}, %CreateAccount{} = create) do
    %AccountCreated{
      account_uuid: create.account_uuid,
      account_number: create.account_number,
      name: create.name,
      initial_balance: create.initial_balance
    }
  end

  @doc """
  Deposit money into an account
  """
  def execute(%Account{uuid: uuid, account_number: number}, %DepositMoney{amount: amount}) do
    %MoneyDeposited{
      account_uuid: uuid,
      account_number: number,
      amount: amount
    }
  end

  @doc """
  Withdraw money from an account
  """
  def execute(%Account{uuid: uuid, account_number: number}, %WithdrawMoney{amount: amount, where: where}) do
    %MoneyWithdrawn{
      account_uuid: uuid,
      account_number: number,
      amount: amount,
      where: where
    }
  end

  # state mutators

  def apply(%Account{} = account, %AccountCreated{} = created) do
    %Account{account |
      uuid: created.account_uuid,
      account_number: created.account_number,
      name: created.name,
      balance: created.initial_balance
    }
  end

  def apply(%Account{} = account, %MoneyDeposited{amount: amount}) do
    %Account{account | balance: account.balance + amount}
  end

  def apply(%Account{} = account, %MoneyWithdrawn{amount: amount}) do
    %Account{account | balance: account.balance - amount}
  end
end
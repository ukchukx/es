defmodule Es.Router do
  use Commanded.Commands.Router

  alias Es.Accounts.Aggregates.{Account,WithdrawalStat,AccountStatement}
  alias Es.Accounts.Commands.{
  	CreateAccount,
    DepositMoney,
    WithdrawMoney
  }
  alias Es.Support.Middleware.{Uniqueness,Validate}

  middleware Validate
  middleware Uniqueness

  identify Account, by: :account_uuid, prefix: "account-"
  
  dispatch [
    CreateAccount, 
    DepositMoney,
    WithdrawMoney
  ], to: Account
end
defmodule Es.Router do
  use Commanded.Commands.Router

  alias Es.Accounts.Aggregates.{Account,WithdrawalStat,AccountStatement}
  alias Es.Accounts.Commands.{
  	CreateAccount,
    DepositMoney,
    WithdrawMoney,
    CreateWithdrawalStat,
    IncreaseBranchCount,
    IncreaseAtmCount,
    CreateAccountStatement,
    AddAccountStatementTransaction
  }
  alias Es.Support.Middleware.{Uniqueness,Validate}

  middleware Validate
  middleware Uniqueness

  identify Account, by: :account_uuid, prefix: "account-"
  identify WithdrawalStat, by: :withdrawal_stat_uuid, prefix: "stat-"
  identify AccountStatement, by: :account_statement_uuid, prefix: "as-"

  dispatch [
    CreateAccount, 
    DepositMoney,
    WithdrawMoney
  ], to: Account

  dispatch [
    CreateWithdrawalStat,
    IncreaseAtmCount,
    IncreaseBranchCount
  ], to: WithdrawalStat

  dispatch [
    CreateAccountStatement,
    AddAccountStatementTransaction
  ], to: AccountStatement
end
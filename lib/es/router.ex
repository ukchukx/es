defmodule Es.Router do
  use Commanded.Commands.Router

  alias Es.Accounts.Aggregates.{Account,WithdrawalStat}
  alias Es.Accounts.Commands.{
  	CreateAccount,
    DepositMoney,
    WithdrawMoney,
    CreateWithdrawalStat,
    IncreaseBranchCount,
    IncreaseAtmCount,
  }
  alias Es.Support.Middleware.{Uniqueness,Validate}

  middleware Validate
  middleware Uniqueness

  identify Account, by: :account_uuid, prefix: "account-"
  identify WithdrawalStat, by: :withdrawal_stat_uuid, prefix: "stat-"

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
end
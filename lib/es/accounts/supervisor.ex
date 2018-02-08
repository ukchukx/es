defmodule Es.Accounts.Supervisor do
  use Supervisor

  alias Es.Accounts
  
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Accounts.Projectors.Account,
      Accounts.Projectors.WithdrawalStat,
      Accounts.Workflows.CreateResourcesFromAccount,
      Accounts.Workflows.HandleDepositsAndWithdrawals
    ], strategy: :one_for_one)
  end
end
defmodule Es.Accounts.Workflows.HandleDepositsAndWithdrawals do
  use Commanded.Event.Handler,
    name: "Accounts.Workflows.HandleDepositsAndWithdrawals",
    consistency: :strong

  alias Es.Accounts.Events.{MoneyWithdrawn,MoneyDeposited}
  alias Es.Accounts
  alias Es.Support.Cache 

  def handle(%MoneyWithdrawn{account_uuid: uuid, where: type, amount: am}, %{causation_id: ca, correlation_id: co}) do
     term = [:hdaw, :withdrawal, ca, co]

     case Cache.seen?(term) do 
      true -> 
        Cache.remove(term) 
        :ok 
      false -> 
        Cache.store(term) 

        opts = [causation_id: ca, correlation_id: co]
        attrs = %{withdrawal_stat_uuid: uuid, count: 1, type: type}
        with {:ok, _stat} <- Accounts.update_withdrawal_stat(attrs, opts) do
          :ok
        else
          reply -> reply
        end

        attrs = %{account_statement_uuid: uuid, transaction: %{amount: am, type: "withdrawal"}}
        with {:ok, _as} <- Accounts.add_account_statement_transaction(attrs, opts) do
          :ok
        else
          reply -> reply
        end
    end
  end

  def handle(%MoneyDeposited{account_uuid: uuid, amount: am}, %{causation_id: ca, correlation_id: co}) do
    term = [:hdaw, :deposit, ca, co] 

    case Cache.seen?(term) do 
      true -> 
        Cache.remove(term) 
        :ok 
      false -> 
        Cache.store(term) 

        opts = [causation_id: ca, correlation_id: co]
        attrs = %{account_statement_uuid: uuid, transaction: %{amount: am, type: "deposit"}}
        with {:ok, _as} <- Accounts.add_account_statement_transaction(attrs, opts) do
          :ok
        else
          reply -> reply
        end
    end
  end
end


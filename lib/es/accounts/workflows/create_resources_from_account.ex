defmodule Es.Accounts.Workflows.CreateResourcesFromAccount do
  use Commanded.Event.Handler,
    name: "Accounts.Workflows.CreateResourcesFromAccount",
    consistency: :strong

  alias Es.Accounts.Events.AccountCreated
  alias Es.Accounts
  alias Es.Support.Cache

  def handle(%AccountCreated{account_uuid: uuid, account_number: an}, %{causation_id: ca, correlation_id: co}) do
    term = [:crfa, ca, co]

    case Cache.seen?(term) do 
      true -> 
        Cache.remove(term) 
        :ok 
      false -> 
        Cache.store(term) 

        opts = [causation_id: ca, correlation_id: co]

        case Accounts.withdrawal_stats_by_account_number(an) do
          nil ->
            attrs = %{withdrawal_stat_uuid: uuid, account_number: an}
            with {:ok, _stat} <- Accounts.create_withdrawal_stat(attrs, opts) do
              :ok
            else
              reply -> reply
            end
          _ -> :ok
        end
    end
  end

  
end


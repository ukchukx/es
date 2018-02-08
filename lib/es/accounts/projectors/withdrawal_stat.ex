defmodule Es.Accounts.Projectors.WithdrawalStat do
  use Commanded.Projections.Ecto, 
    name: "Accounts.Projectors.WithdrawalStat",
    consistency: :strong

  alias Es.Accounts.Events.{
    AtmCountIncreased,
    BranchCountIncreased,
    WithdrawalStatCreated
  }
  alias Es.Accounts.Projections.WithdrawalStat

  project %WithdrawalStatCreated{} = registered do
    Ecto.Multi.insert(multi, :withdrawal, %WithdrawalStat{
      uuid: registered.withdrawal_stat_uuid,
      account_number: registered.account_number,
      atm: 0,
      branch: 0
    })
  end

  project %BranchCountIncreased{withdrawal_stat_uuid: withdrawal_stat_uuid, count: count} do
    Ecto.Multi.update_all(multi, :withdrawal, query(withdrawal_stat_uuid), inc: [branch: count])
  end

  project %AtmCountIncreased{withdrawal_stat_uuid: withdrawal_stat_uuid, count: count} do
    Ecto.Multi.update_all(multi, :withdrawal, query(withdrawal_stat_uuid), inc: [atm: count])
  end

  defp query(uuid), do: from(w in WithdrawalStat, where: w.uuid == ^uuid)
end
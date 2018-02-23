defmodule Es.Accounts.Aggregates.WithdrawalStat do
  defstruct [
    :uuid,
    :account_number,
    :atm,
    :branch,
  ]

  alias Es.Accounts.Aggregates.WithdrawalStat
  alias Es.Accounts.Commands.{
    CreateWithdrawalStat,
    IncreaseAtmCount,
    IncreaseBranchCount
  }
  alias Es.Accounts.Events.{
    AtmCountIncreased,
    BranchCountIncreased,
    WithdrawalStatCreated
  }

  def execute(%WithdrawalStat{uuid: nil}, %CreateWithdrawalStat{} = create) do
    %WithdrawalStatCreated{
      withdrawal_stat_uuid: create.withdrawal_stat_uuid,
      account_number: create.account_number,
      atm: 0,
      branch: 0
    }
  end

  def execute(%WithdrawalStat{uuid: uuid}, %IncreaseAtmCount{count: count}) do
    %AtmCountIncreased{
      withdrawal_stat_uuid: uuid,
      count: count
    }
  end

  def execute(%WithdrawalStat{uuid: uuid}, %IncreaseBranchCount{count: count}) do
    %BranchCountIncreased{
      withdrawal_stat_uuid: uuid,
      count: count
    }
  end

  # state mutators

  def apply(%WithdrawalStat{} = w, %WithdrawalStatCreated{} = created) do
    %WithdrawalStat{w |
      uuid: created.withdrawal_stat_uuid,
      account_number: created.account_number,
      atm: created.atm,
      branch: created.branch
    }
  end

  def apply(%WithdrawalStat{} = w, %AtmCountIncreased{count: count}) do
    %WithdrawalStat{w | atm: w.atm + count}
  end

  def apply(%WithdrawalStat{} = w, %BranchCountIncreased{count: count}) do
    %WithdrawalStat{w | branch: w.branch + count}
  end
end
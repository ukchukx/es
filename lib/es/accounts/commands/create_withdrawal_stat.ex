defmodule Es.Accounts.Commands.CreateWithdrawalStat do
	defstruct [
    withdrawal_stat_uuid: nil,
    account_number: nil
  ]

  use ExConstructor
  use Vex.Struct


  validates :withdrawal_stat_uuid, uuid: true
  validates :account_number,
    presence: [message: "can't be empty"],
    format: [with: ~r/^[0-9]+$/, message: "is invalid"]

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%__MODULE__{} = command, uuid) do
    %__MODULE__{command | withdrawal_stat_uuid: uuid}
  end
end

defimpl Es.Support.Middleware.Uniqueness.UniqueFields, for: Es.Accounts.Commands.CreateWithdrawalStat do
  def unique(%Es.Accounts.Commands.CreateWithdrawalStat{withdrawal_stat_uuid: account_uuid}), do: [
    {:account_number, "has already been taken", account_uuid}
  ]
end

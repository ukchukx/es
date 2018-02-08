defmodule Es.Accounts.Commands.IncreaseBranchCount do
	defstruct [
    withdrawal_stat_uuid: nil,
    count: nil
  ]

  use ExConstructor
  use Vex.Struct


  validates :withdrawal_stat_uuid, uuid: true
  validates :count, by: &is_number/1

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%__MODULE__{} = command, uuid) do
    %__MODULE__{command | withdrawal_stat_uuid: uuid}
  end
end

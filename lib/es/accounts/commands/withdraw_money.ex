defmodule Es.Accounts.Commands.WithdrawMoney do
	defstruct [
    account_uuid: nil,
    account_number: nil,
    amount: nil,
    where: nil
  ]

  use ExConstructor
  use Vex.Struct


  validates :account_uuid, uuid: true
  validates :where, string: true
  validates :amount, by: &is_number/1
  validates :account_number,
    presence: [message: "can't be empty"],
    format: [with: ~r/^[0-9]+$/, message: "is invalid"]

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%__MODULE__{} = command, uuid) do
    %__MODULE__{command | account_uuid: uuid}
  end
end

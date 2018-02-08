defmodule Es.Accounts.Commands.CreateAccount do
	defstruct [
    account_uuid: nil,
    account_number: nil,
    name: nil,
    initial_balance: nil
  ]

  use ExConstructor
  use Vex.Struct


  validates :name, string: true
  validates :account_uuid, uuid: true
  validates :initial_balance, by: &is_number/1
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

defimpl Es.Support.Middleware.Uniqueness.UniqueFields, for: Es.Accounts.Commands.CreateAccount do
  def unique(%Es.Accounts.Commands.CreateAccount{account_uuid: account_uuid}), do: [
    {:account_number, "has already been taken", account_uuid}
  ]
end

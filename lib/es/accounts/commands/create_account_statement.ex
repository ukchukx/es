defmodule Es.Accounts.Commands.CreateAccountStatement do
	defstruct [
    account_statement_uuid: nil,
    account_number: nil
  ]

  use ExConstructor
  use Vex.Struct


  validates :account_statement_uuid, uuid: true
  validates :account_number,
    presence: [message: "can't be empty"],
    format: [with: ~r/^[0-9]+$/, message: "is invalid"]

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%__MODULE__{} = command, uuid) do
    %__MODULE__{command | account_statement_uuid: uuid}
  end
end

defimpl Es.Support.Middleware.Uniqueness.UniqueFields, for: Es.Accounts.Commands.CreateAccountStatement do
  def unique(%Es.Accounts.Commands.CreateAccountStatement{account_statement_uuid: uuid}), do: [
    {:account_number, "has already been taken", uuid}
  ]
end

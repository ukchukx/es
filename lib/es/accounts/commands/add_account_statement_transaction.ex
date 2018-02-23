defmodule Es.Accounts.Commands.AddAccountStatementTransaction do
	defstruct [
    account_statement_uuid: nil,
    transaction: nil
  ]

  use ExConstructor
  use Vex.Struct


  validates :account_statement_uuid, uuid: true
  validates :transaction, by: &__MODULE__.validate_transaction/1

  @doc """
  Assign a unique identity
  """
  def assign_uuid(%__MODULE__{} = command, uuid) do
    %__MODULE__{command | account_statement_uuid: uuid}
  end

  def validate_transaction(t) do
    is_map(t) and Map.has_key?(t, :type) and Map.has_key?(t, :amount)
  end
end

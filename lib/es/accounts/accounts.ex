defmodule Es.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """
  alias Es.Accounts.Commands.{
    CreateAccount,
    DepositMoney,
    WithdrawMoney,
    CreateWithdrawalStat,
    IncreaseAtmCount,
    IncreaseBranchCount,
  }

  alias Es.Accounts.Queries.{
    AccountByNumber,
    WithdrawalStatsByAccountNumber
  }
  alias Es.Accounts.Projections.{Account,WithdrawalStat}
  alias Es.{Repo,Router}

  @doc """
  Create a new account.
  """
  def create_account(attrs) do
    uuid = UUID.uuid4()

    create_account =
      attrs
      |> CreateAccount.new
      |> CreateAccount.assign_uuid(uuid)

    with :ok <- Router.dispatch(create_account, consistency: :strong) do
      get(Account, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Deposit money into an account.
  """
  def deposit(%Account{account_number: an, uuid: uuid}, %{amount: am}) do
    command =
      %{amount: am, account_number: an}
      |> DepositMoney.new
      |> DepositMoney.assign_uuid(uuid)

    with :ok <- Router.dispatch(command, consistency: :strong) do
      get(Account, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Withdraw money from an account.
  """
  def withdraw(%Account{account_number: an, uuid: uuid, balance: b} = account, %{amount: am, where: w}) do
    case b >= am do
      true ->
        command =
          %{amount: am, account_number: an, where: w}
          |> WithdrawMoney.new
          |> WithdrawMoney.assign_uuid(uuid)

        with :ok <- Router.dispatch(command, consistency: :strong) do
          get(Account, uuid)
        else
          reply -> reply
        end
      false -> {:ok, account}
    end
  end

  def list_accounts, do: Repo.all(Account)

  def account_by_account_number(account_number) when is_binary(account_number) do
    account_number
    |> AccountByNumber.new
    |> Repo.one
  end

  def account_by_account_number(_), do: nil

  def account_by_uuid(uuid) when is_binary(uuid), do: get(Account, uuid)

  @doc """
  Create a new withdrawal stat.
  """
  def create_withdrawal_stat(%{withdrawal_stat_uuid: uuid} = attrs, opts \\ []) do
    opts = opts ++ [consistency: :strong]

    command = CreateWithdrawalStat.new(attrs)

    with :ok <- Router.dispatch(command, opts) do
      get(WithdrawalStat, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Update withdrawal stat.
  """
  def update_withdrawal_stat(%{withdrawal_stat_uuid: uuid, type: type} = attrs, opts \\ []) do
    opts = opts ++ [consistency: :strong]

    command = 
      case type do
        "atm" -> IncreaseAtmCount.new(attrs)
        "branch" -> IncreaseBranchCount.new(attrs)
      end

    with :ok <- Router.dispatch(command, opts) do
      get(WithdrawalStat, uuid)
    else
      reply -> reply
    end
  end

  def withdrawal_stats_by_account_number(account_number) do
    account_number
    |> WithdrawalStatsByAccountNumber.new
    |> Repo.one
  end

  def list_withdrawal_stats, do: Repo.all(WithdrawalStat)
  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
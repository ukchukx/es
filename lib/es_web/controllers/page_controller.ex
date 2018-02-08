defmodule EsWeb.PageController do
  use EsWeb, :controller

  alias Es.Accounts

  def index(conn, _params) do
    render conn, "index.html", accounts: Accounts.list_accounts()
  end

  def handle_command(conn, %{ "command" => %{"type" => "create_account", "account_number" => an, "name" => n, "initial_balance" => ib}}) do
    {ib, _} = Float.parse(ib)

    with {:ok, _account} <- Accounts.create_account(%{account_number: an, initial_balance: ib, name: n}) do
    	redirect(conn, to: page_path(conn, :index))
    end
  end

  def handle_command(conn, %{ "command" => %{"type" => "withdrawal", "account_number" => an, "amount" => a, "where" => w}}) do
    {a, _} = Float.parse(a)

    case Accounts.account_by_account_number(an) do
      nil -> nil
      account -> Accounts.withdraw(account, %{amount: a, where: w})        
    end

    redirect(conn, to: page_path(conn, :index))
  end

  def handle_command(conn, %{ "command" => %{"type" => "deposit", "account_number" => an, "amount" => a}}) do
    {a, _} = Float.parse(a)

    case Accounts.account_by_account_number(an) do
      nil -> nil
      account -> Accounts.deposit(account, %{amount: a})        
    end
    
    redirect(conn, to: page_path(conn, :index))
  end

  def detail(conn, %{"account" => account}) do
  	accounts = Accounts.list_accounts()
  	
  	selected = Enum.find(accounts, nil, fn 
  		%{account_number: ^account} -> true 
  		_ -> false 
  	end)

  	selected = 
  		case selected do
  		  nil -> nil
  		  _ -> %{selected | balance: :erlang.float_to_binary(selected.balance, [decimals: 2])}
  		end

  	number = 
  		case selected do
  		  %{account_number: a} -> a
  		  _ -> nil
  		end

  	withdrawal_stats = Accounts.withdrawal_stats_by_account_number(account)
  	account_statement = Accounts.account_statement_by_account_number(account)

    render conn, "detail.html", 
    	accounts: accounts, 
    	selected: selected, 
    	number: number,
    	withdrawal_stats: withdrawal_stats,
    	account_statement: account_statement
  end

  def detail(conn, _params) do
    render conn, "detail.html", 
    	accounts: [], 
    	selected: nil, 
    	number: nil,
    	withdrawal_stats: nil,
    	account_statement: nil
  end
end

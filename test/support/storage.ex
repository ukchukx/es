defmodule Es.Storage do
  @doc """
  Clear the event store and read store databases
  """
  def reset! do
    :ok = Application.stop(:es)
    :ok = Application.stop(:commanded)
    :ok = Application.stop(:eventstore)

    reset_eventstore()
    reset_readstore()

    {:ok, _} = Application.ensure_all_started(:es)
  end

  defp reset_eventstore do
    EventStore.configuration
    |> EventStore.Config.parse
    |> Postgrex.start_link
    |> elem(1)
    |> EventStore.Storage.Initializer.reset!
  end

  defp reset_readstore do
    :es
    |> Application.get_env(Es.Repo)
    |> Postgrex.start_link
    |> elem(1)
    |> Postgrex.query!(truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      accounts,
      projection_versions
    RESTART IDENTITY;
    """
  end
end
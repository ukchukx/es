defmodule Es.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Es.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Es.Factory
      import Es.Fixture
      import Es.DataCase
      import Es.Helpers.Wait
      import Es.Helpers.ProcessHelper
    end
  end

  setup do
    Es.Storage.reset!()

    :ok
  end
end

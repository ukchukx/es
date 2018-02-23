defmodule Es.Support.Cache do 
    use GenServer  
  
    def start_link, do: GenServer.start_link(__MODULE__, MapSet.new(), name: __MODULE__)  
  
    def store(term), do: GenServer.call(__MODULE__, {:store, term})  
  
    def remove(term), do: GenServer.call(__MODULE__, {:remove, term})  
  
    def seen?(term), do: GenServer.call(__MODULE__, {:find, term})  
  
    def init(state), do: {:ok, state}  
  
    def handle_call({:store, term}, _from, set) do  
      state = MapSet.put(set, term)  
      {:reply, state, state}  
    end  
  
    def handle_call({:remove, term}, _from, set) do  
      state = MapSet.delete(set, term)  
      {:reply, state, state}  
    end  
  
    def handle_call({:find, term}, _from, set) do  
      {:reply, MapSet.member?(set, term), set}  
    end  
  end 
defmodule DPW.EventPersister do
  use GenServer

  def start_link(repo, _opts \\ []) do
    GenServer.start_link(__MODULE__, repo, name: DPW.EventPersister)
  end

  def handle_cast({:track, event}, repo) do
    event_changeset = DPW.Event.changeset(%DPW.Event{}, event) 
    repo.insert!(event_changeset)
    {:noreply, repo}
  end

end

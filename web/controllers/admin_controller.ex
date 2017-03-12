defmodule DPW.AdminController do
  use DPW.Web, :controller

  plug DPW.Plugs.Admin

  def new_project(conn, _params) do
    render conn, "new-project.html"
  end

  def create_project(conn, %{"project" => project}) do 
    is_featured = case project["featured"] do 
      "on" -> true
      nil -> false
    end

    project = Map.put(project, "featured", is_featured)

    problem = DPW.Problem.changeset(%DPW.Problem{}, project)
      |> Repo.insert!()

    redirect(conn, to: "/problem/#{problem.id}")
  end

end


defmodule DPW.AdminController do
  use DPW.Web, :controller

  plug DPW.Plugs.Admin

  alias DPW.{Response, Repo}

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

  def responses(conn, %{"key" => key}) do
    responses = from(response in Response, where: response.form_key == ^key, order_by: response.inserted_at)
                |> Repo.all()
    render(conn, "responses.html", responses: responses, form_key: key)
  end

  def response(conn, %{"id" => id}) do 
    render(conn, "response.html", response: Repo.get!(Response, id))
  end

  def response_types(conn, _) do
    keys = from(r in Response, group_by: r.form_key, select: r.form_key) |> Repo.all()
    render(conn, "all_responses.html", keys: keys)
  end

end


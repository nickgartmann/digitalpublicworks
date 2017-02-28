defmodule DPW.PageController do
  use DPW.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def problem(conn, %{"id" => problem_id}) do
    render conn, "problem.html"
  end
end

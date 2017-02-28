defmodule DPW.PageController do
  use DPW.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def problem(conn, _params) do
    render conn, "problem.html"
  end
end

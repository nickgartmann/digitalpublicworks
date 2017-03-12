defmodule DPW.PageController do
  use DPW.Web, :controller

  alias DPW.{Repo, Problem, Vote, Response}

  def index(conn, _params) do
    problems = Problem.featured() 
      |> Repo.all()
    render conn, "index.html", problems: problems
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
  
  def privacy(conn, _params) do
    render conn, "privacy.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end
  
  def terms(conn, _params) do
    render conn, "terms.html"
  end

  def submit(conn, _params) do
    render conn, "submit.html"
  end

  def settings(conn, _params) do
    render conn, "settings.html"
  end

  
  def problem(conn, %{"id" => problem_id}) do
    case Repo.get(Problem, problem_id) |> Repo.preload(:votes) do 
      nil     -> redirect(conn, to: "/")
      problem -> 
        conn
        |> meta(:title, "DPW - #{problem.title}")
        |> meta(:facebook_title, "Problem: #{problem.title}")
        |> meta(:description, problem.description)
        |> render("problem.html", problem: problem)
    end
  end

  def cast_vote(conn, %{"id" => problem_id, "direction" => "yes"}) do
    case Repo.get(Problem, problem_id) do 
      nil     -> redirect(conn, to: "/")
      problem -> 
        case vote(conn, problem, conn.assigns[:current_user], true) do
          {:ok, _vote, conn} -> redirect(conn, to: "/problem/#{problem.id}")
          _ -> 
            conn
            |> put_flash(:error, "Already voted")
            |> redirect(to: "/problem/#{problem.id}")
        end
    end
  end

  def cast_vote(conn, %{"id" => problem_id, "direction" => "no"}) do
    case Repo.get(Problem, problem_id) do 
      nil     -> redirect(conn, to: "/")
      problem -> 
        case vote(conn, problem, conn.assigns[:current_user], false) do
          {:ok, _vote, conn} -> redirect(conn, to: "/problem/#{problem.id}")
          _ -> 
            conn
            |> put_flash(:error, "Already voted")
            |> redirect(to: "/problem/#{problem.id}")
        end
    end
  end

  def respond(conn, %{"_redirect" => redir_path, "form_key" => form_key, "answers" => answers}) do
    response_changeset = Response.changeset(%Response{}, %{"form_key" => form_key,"answers" => answers})
    Repo.insert!(response_changeset)
    redirect(conn, to: redir_path)
  end

  def thanks(conn, _) do
    render(conn, "thank-you.html")
  end

  def contact_thanks(conn, _) do 
    render(conn, "thank-you-contact.html")
  end
  
  def problem_thanks(conn, _) do
    render(conn, "thank-you-problem.html")
  end

    defp vote(conn, _, nil, _), do: conn |> put_flash(:error, "You must have an account to vote.") |> redirect(to: "/register")
  defp vote(conn, problem, user, direction) do

    vote = from(v in Vote, where: v.problem_id == ^problem.id and v.user_id == ^user.id) |> Repo.one()
    
    case vote do
      nil -> {:ok, Vote.create!(problem, user, direction) |> Repo.insert!, conn}
      vote -> {:ok, Vote.update!(vote, direction) |> Repo.update!(), conn}
    end

  end

end

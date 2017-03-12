defmodule DPW.Plugs.Analytics do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params) do 
    conn = set_tracking_cookie(conn)
    DPW.Event.track(%{
      path: conn.request_path,
      method: conn.method,
      identifier: conn.cookies[cookie_name()],
      query: conn.query_string,
      ip: Tuple.to_list(conn.remote_ip) |> Enum.join("."),
      user_agent: header(conn, "user-agent"),
      meta: %{} # not tracking anything else for now
    })
    conn
  end

  defp header(conn, header_key) do 
    [{_, val} | _] = Enum.filter(conn.req_headers, fn({key, _}) -> 
      key == header_key 
    end) 
    val
  end

  defp set_tracking_cookie(conn) do
    case conn.cookies[cookie_name()] do
      nil -> put_resp_cookie(conn, cookie_name(), generate_cookie(), max_age: cookie_age())
      _   -> conn
    end
  end

  defp cookie_name() do 
    Application.fetch_env!(:dpw, DPW.Plugs.Analytics)[:tracking_cookie]
  end

  defp cookie_age() do 
    24 * 60 * 60 * 365 * 5 # Five years
  end

  defp generate_cookie() do 
    :crypto.strong_rand_bytes(128) |> Base.url_encode64() |> binary_part(0, 128) 
  end

end

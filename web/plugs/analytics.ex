defmodule DPW.Plugs.Analytics do

  def init(opts), do: opts

  def call(conn, _params) do 
    DPW.Event.track(%{
      path: conn.request_path,
      method: conn.method,
      query: conn.query_string,
      ip: Tuple.to_list(conn.remote_ip) |> Enum.join("."),
      user_agent: header(conn, "user-agent"),
      meta: %{} # not tracking anything else for now
    })
    conn
  end

  defp header(conn, header_key) do 
    [{_, val} | _] = Enum.filter(conn.req_headers, fn({key, val}) -> 
      key == header_key 
    end) 
    val
  end

end

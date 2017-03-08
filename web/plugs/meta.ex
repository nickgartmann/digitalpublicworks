defmodule DPW.Plugs.Meta do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do 
    assign(conn, :meta, %{
      title: "Milwaukee Digital Public Works",
      description: "Digital Public Works helps people fix problems in Milwaukee using technology and design thinking. Submit your problem and let Milwaukeeans try to help.",
      keywords: "civic design programming Milwaukee"
    })
  end

end

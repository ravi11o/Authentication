defmodule GoogleAuth.PageController do
  use GoogleAuth.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

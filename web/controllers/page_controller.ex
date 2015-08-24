defmodule Personal.PageController do
  use Personal.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def resume(conn, _params) do
    render conn, "resume.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end
end

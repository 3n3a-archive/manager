defmodule ManagerWeb.Api.ProjectController do
  use ManagerWeb, :controller

  alias Manager.Api.Website

  action_fallback ManagerWeb.FallbackController

  def index(conn, _params) do
    projects = Website.list_projects()
    render(conn, "index.json", projects: projects)
  end
end

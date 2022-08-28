defmodule ManagerWeb.ProjectController do
  use ManagerWeb, :controller

  alias Manager.Homepage
  alias Manager.Homepage.Project

  def index(conn, _params) do
    projects = Homepage.list_projects()
    render(conn, "index.html", projects: projects)
  end

  def new(conn, _params) do
    changeset = Homepage.change_project(%Project{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"project" => project_params}) do
    case Homepage.create_project(project_params) do
      {:ok, project} ->
        trigger_deploy(project)
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Homepage.get_project!(id)
    render(conn, "show.html", project: project)
  end

  def edit(conn, %{"id" => id}) do
    project = Homepage.get_project!(id)
    changeset = Homepage.change_project(project)
    render(conn, "edit.html", project: project, changeset: changeset)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Homepage.get_project!(id)

    case Homepage.update_project(project, project_params) do
      {:ok, project} ->
        trigger_deploy(project)
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Homepage.get_project!(id)
    {:ok, _project} = Homepage.delete_project(project)

    trigger_deploy(project)
    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :index))
  end

  def trigger_deploy(project) do
    if project.status == :live do
      WebhookAdapter.trigger_deploy("home")
    end
  end
end

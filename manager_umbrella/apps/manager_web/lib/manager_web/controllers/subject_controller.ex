defmodule ManagerWeb.SubjectController do
  use ManagerWeb, :controller

  alias Manager.School
  alias Manager.School.Subject

  def index(conn, _params) do
    subjects = School.list_subjects()
    render(conn, "index.html", subjects: subjects)
  end

  def new(conn, _params) do
    changeset = School.change_subject(%Subject{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subject" => subject_params}) do
    case School.create_subject(subject_params) do
      {:ok, subject} ->
        trigger_deploy(subject)
        conn
        |> put_flash(:info, "Subject created successfully.")
        |> redirect(to: Routes.subject_path(conn, :show, subject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subject = School.get_subject!(id)
    render(conn, "show.html", subject: subject)
  end

  def edit(conn, %{"id" => id}) do
    subject = School.get_subject!(id)
    changeset = School.change_subject(subject)
    render(conn, "edit.html", subject: subject, changeset: changeset)
  end

  def update(conn, %{"id" => id, "subject" => subject_params}) do
    subject = School.get_subject!(id)

    case School.update_subject(subject, subject_params) do
      {:ok, subject} ->
        trigger_deploy(subject)
        conn
        |> put_flash(:info, "Subject updated successfully.")
        |> redirect(to: Routes.subject_path(conn, :show, subject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", subject: subject, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subject = School.get_subject!(id)
    {:ok, _subject} = School.delete_subject(subject)

    trigger_deploy(subject)
    conn
    |> put_flash(:info, "Subject deleted successfully.")
    |> redirect(to: Routes.subject_path(conn, :index))
  end

  def trigger_deploy(subject) do
    if subject.status == :live do
      WebhookAdapter.trigger_deploy("school")
    end
  end
end

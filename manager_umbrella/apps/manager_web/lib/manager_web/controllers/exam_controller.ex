defmodule ManagerWeb.ExamController do
  use ManagerWeb, :controller

  alias Manager.School
  alias Manager.School.Exam

  def index(conn, _params) do
    exams = School.list_exams()

    render(conn, "index.html", exams: exams)
  end

  def new(conn, _params) do
    changeset = School.change_exam(%Exam{})
    subject_list = School.select_list_subjects()

    render(conn, "new.html", changeset: changeset, subject_list: subject_list)
  end

  def create(conn, %{"exam" => exam_params}) do
    subject_list = School.select_list_subjects()

    case School.create_exam(exam_params) do
      {:ok, exam} ->
        trigger_deploy(exam)
        conn
        |> put_flash(:info, "Exam created successfully.")
        |> redirect(to: Routes.exam_path(conn, :show, exam))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, subject_list: subject_list)
    end
  end

  def show(conn, %{"id" => id}) do
    exam = School.get_exam!(id)
    render(conn, "show.html", exam: exam)
  end

  def edit(conn, %{"id" => id}) do
    exam = School.get_exam!(id)
    changeset = School.change_exam(exam)
    subject_list = School.select_list_subjects()

    render(conn, "edit.html", exam: exam, changeset: changeset, subject_list: subject_list)
  end

  def update(conn, %{"id" => id, "exam" => exam_params}) do
    exam = School.get_exam!(id)
    subject_list = School.select_list_subjects()

    case School.update_exam(exam, exam_params) do
      {:ok, exam} ->
        trigger_deploy(exam)
        conn
        |> put_flash(:info, "Exam updated successfully.")
        |> redirect(to: Routes.exam_path(conn, :show, exam))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", exam: exam, changeset: changeset, subject_list: subject_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    exam = School.get_exam!(id)
    {:ok, _exam} = School.delete_exam(exam)

    trigger_deploy(exam)
    conn
    |> put_flash(:info, "Exam deleted successfully.")
    |> redirect(to: Routes.exam_path(conn, :index))
  end

  def trigger_deploy(exam) do
    if exam.status == :live do
      WebhookAdapter.trigger_deploy("school")
    end
  end
end

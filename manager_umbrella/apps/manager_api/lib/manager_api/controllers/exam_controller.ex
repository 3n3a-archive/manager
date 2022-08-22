defmodule ManagerApi.ExamController do
  use ManagerApi, :controller

  alias Manager.School
  alias Manager.School.Exam

  action_fallback ManagerApi.FallbackController

  def index(conn, _params) do
    exams = School.list_exams()
    render(conn, "index.json", exams: exams)
  end

  def create(conn, %{"exam" => exam_params}) do
    with {:ok, %Exam{} = exam} <- School.create_exam(exam_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.exam_path(conn, :show, exam))
      |> render("show.json", exam: exam)
    end
  end

  def show(conn, %{"id" => id}) do
    exam = School.get_exam!(id)
    render(conn, "show.json", exam: exam)
  end

  def update(conn, %{"id" => id, "exam" => exam_params}) do
    exam = School.get_exam!(id)

    with {:ok, %Exam{} = exam} <- School.update_exam(exam, exam_params) do
      render(conn, "show.json", exam: exam)
    end
  end

  def delete(conn, %{"id" => id}) do
    exam = School.get_exam!(id)

    with {:ok, %Exam{}} <- School.delete_exam(exam) do
      send_resp(conn, :no_content, "")
    end
  end
end

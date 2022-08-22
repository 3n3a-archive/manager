defmodule ManagerApi.ExamView do
  use ManagerApi, :view
  alias ManagerApi.ExamView

  def render("index.json", %{exams: exams}) do
    %{data: render_many(exams, ExamView, "exam.json")}
  end

  def render("show.json", %{exam: exam}) do
    %{data: render_one(exam, ExamView, "exam.json")}
  end

  def render("exam.json", %{exam: exam}) do
    %{
      id: exam.id,
      name: exam.name,
      mark: exam.mark,
      type: exam.type,
      status: exam.status
    }
  end
end

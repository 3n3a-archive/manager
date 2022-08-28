defmodule ManagerApi.ExamView do
  use ManagerApi, :view
  alias ManagerApi.ExamView

  alias Manager.School


  def get_subject(exam) do
    subject = School.get_subject!(exam.subject_id)
    %{
      id: subject.id,
      name: subject.name,
      description: subject.description,
      teacher: subject.teacher
    }
  end

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
      subject: get_subject(exam),
      status: exam.status
    }
  end
end

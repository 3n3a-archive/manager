defmodule ManagerWeb.ExamView do
  use ManagerWeb, :view

  alias Manager.School


  def get_subject_name(exam) do
    School.get_subject!(exam.subject_id).name
  end
end

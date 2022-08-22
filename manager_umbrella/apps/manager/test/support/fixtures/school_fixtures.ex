defmodule Manager.SchoolFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Manager.School` context.
  """

  @doc """
  Generate a unique exam name.
  """
  def unique_exam_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a exam.
  """
  def exam_fixture(attrs \\ %{}) do
    {:ok, exam} =
      attrs
      |> Enum.into(%{
        mark: 42,
        name: unique_exam_name(),
        status: :draft,
        type: :uk
      })
      |> Manager.School.create_exam()

    exam
  end

  @doc """
  Generate a unique subject name.
  """
  def unique_subject_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a subject.
  """
  def subject_fixture(attrs \\ %{}) do
    {:ok, subject} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: unique_subject_name(),
        teacher: "some teacher"
      })
      |> Manager.School.create_subject()

    subject
  end
end

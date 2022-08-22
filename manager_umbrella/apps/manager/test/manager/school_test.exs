defmodule Manager.SchoolTest do
  use Manager.DataCase

  alias Manager.School

  describe "exams" do
    alias Manager.School.Exam

    import Manager.SchoolFixtures

    @invalid_attrs %{mark: nil, name: nil, status: nil, type: nil}

    test "list_exams/0 returns all exams" do
      exam = exam_fixture()
      assert School.list_exams() == [exam]
    end

    test "get_exam!/1 returns the exam with given id" do
      exam = exam_fixture()
      assert School.get_exam!(exam.id) == exam
    end

    test "create_exam/1 with valid data creates a exam" do
      valid_attrs = %{mark: 42, name: "some name", status: :draft, type: :uk}

      assert {:ok, %Exam{} = exam} = School.create_exam(valid_attrs)
      assert exam.mark == 42
      assert exam.name == "some name"
      assert exam.status == :draft
      assert exam.type == :uk
    end

    test "create_exam/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_exam(@invalid_attrs)
    end

    test "update_exam/2 with valid data updates the exam" do
      exam = exam_fixture()
      update_attrs = %{mark: 43, name: "some updated name", status: :live, type: :bf}

      assert {:ok, %Exam{} = exam} = School.update_exam(exam, update_attrs)
      assert exam.mark == 43
      assert exam.name == "some updated name"
      assert exam.status == :live
      assert exam.type == :bf
    end

    test "update_exam/2 with invalid data returns error changeset" do
      exam = exam_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_exam(exam, @invalid_attrs)
      assert exam == School.get_exam!(exam.id)
    end

    test "delete_exam/1 deletes the exam" do
      exam = exam_fixture()
      assert {:ok, %Exam{}} = School.delete_exam(exam)
      assert_raise Ecto.NoResultsError, fn -> School.get_exam!(exam.id) end
    end

    test "change_exam/1 returns a exam changeset" do
      exam = exam_fixture()
      assert %Ecto.Changeset{} = School.change_exam(exam)
    end
  end

  describe "subjects" do
    alias Manager.School.Subject

    import Manager.SchoolFixtures

    @invalid_attrs %{description: nil, name: nil, teacher: nil}

    test "list_subjects/0 returns all subjects" do
      subject = subject_fixture()
      assert School.list_subjects() == [subject]
    end

    test "get_subject!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert School.get_subject!(subject.id) == subject
    end

    test "create_subject/1 with valid data creates a subject" do
      valid_attrs = %{description: "some description", name: "some name", teacher: "some teacher"}

      assert {:ok, %Subject{} = subject} = School.create_subject(valid_attrs)
      assert subject.description == "some description"
      assert subject.name == "some name"
      assert subject.teacher == "some teacher"
    end

    test "create_subject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_subject(@invalid_attrs)
    end

    test "update_subject/2 with valid data updates the subject" do
      subject = subject_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", teacher: "some updated teacher"}

      assert {:ok, %Subject{} = subject} = School.update_subject(subject, update_attrs)
      assert subject.description == "some updated description"
      assert subject.name == "some updated name"
      assert subject.teacher == "some updated teacher"
    end

    test "update_subject/2 with invalid data returns error changeset" do
      subject = subject_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_subject(subject, @invalid_attrs)
      assert subject == School.get_subject!(subject.id)
    end

    test "delete_subject/1 deletes the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{}} = School.delete_subject(subject)
      assert_raise Ecto.NoResultsError, fn -> School.get_subject!(subject.id) end
    end

    test "change_subject/1 returns a subject changeset" do
      subject = subject_fixture()
      assert %Ecto.Changeset{} = School.change_subject(subject)
    end
  end
end

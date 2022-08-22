defmodule Manager.HomepageTest do
  use Manager.DataCase

  alias Manager.Homepage

  describe "projects" do
    alias Manager.Homepage.Project

    import Manager.HomepageFixtures

    @invalid_attrs %{body: nil, color: nil, customBg: nil, href: nil, status: nil, title: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Homepage.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Homepage.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{body: "some body", color: "some color", customBg: "some customBg", href: "some href", status: :draft, title: "some title"}

      assert {:ok, %Project{} = project} = Homepage.create_project(valid_attrs)
      assert project.body == "some body"
      assert project.color == "some color"
      assert project.customBg == "some customBg"
      assert project.href == "some href"
      assert project.status == :draft
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Homepage.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{body: "some updated body", color: "some updated color", customBg: "some updated customBg", href: "some updated href", status: :live, title: "some updated title"}

      assert {:ok, %Project{} = project} = Homepage.update_project(project, update_attrs)
      assert project.body == "some updated body"
      assert project.color == "some updated color"
      assert project.customBg == "some updated customBg"
      assert project.href == "some updated href"
      assert project.status == :live
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Homepage.update_project(project, @invalid_attrs)
      assert project == Homepage.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Homepage.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Homepage.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Homepage.change_project(project)
    end
  end
end

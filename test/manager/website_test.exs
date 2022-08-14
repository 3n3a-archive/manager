defmodule Manager.WebsiteTest do
  use Manager.DataCase

  alias Manager.Website

  describe "projects" do
    alias Manager.Website.Project

    import Manager.WebsiteFixtures

    @invalid_attrs %{body: nil, color: nil, customBg: nil, href: nil, title: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Website.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Website.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{body: "some body", color: "some color", customBg: "some customBg", href: "some href", title: "some title"}

      assert {:ok, %Project{} = project} = Website.create_project(valid_attrs)
      assert project.body == "some body"
      assert project.color == "some color"
      assert project.customBg == "some customBg"
      assert project.href == "some href"
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Website.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{body: "some updated body", color: "some updated color", customBg: "some updated customBg", href: "some updated href", title: "some updated title"}

      assert {:ok, %Project{} = project} = Website.update_project(project, update_attrs)
      assert project.body == "some updated body"
      assert project.color == "some updated color"
      assert project.customBg == "some updated customBg"
      assert project.href == "some updated href"
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Website.update_project(project, @invalid_attrs)
      assert project == Website.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Website.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Website.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Website.change_project(project)
    end
  end
end

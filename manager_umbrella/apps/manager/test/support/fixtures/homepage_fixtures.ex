defmodule Manager.HomepageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Manager.Homepage` context.
  """

  @doc """
  Generate a unique project href.
  """
  def unique_project_href, do: "some href#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique project title.
  """
  def unique_project_title, do: "some title#{System.unique_integer([:positive])}"

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        body: "some body",
        color: "some color",
        customBg: "some customBg",
        href: unique_project_href(),
        status: :draft,
        title: unique_project_title()
      })
      |> Manager.Homepage.create_project()

    project
  end
end

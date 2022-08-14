defmodule Manager.WebsiteFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Manager.Website` context.
  """

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
        href: "some href",
        title: unique_project_title()
      })
      |> Manager.Website.create_project()

    project
  end
end

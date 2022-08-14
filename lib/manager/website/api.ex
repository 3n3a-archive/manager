defmodule Manager.Api.Website do
  @moduledoc """
  The Website's Api context.
  """

  import Ecto.Query, warn: false
  alias Manager.Repo

  alias Manager.Website.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end
end

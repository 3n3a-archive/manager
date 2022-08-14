defmodule Manager.Website.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :body, :string
    field :color, :string
    field :customBg, :string
    field :href, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :body, :href, :color, :customBg])
    |> validate_required([:title, :href])
    |> unique_constraint(:title)
  end
end

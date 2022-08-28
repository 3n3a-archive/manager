defmodule Manager.Homepage.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :body, :string
    field :color, :string
    field :customBg, :string
    field :href, :string
    field :status, Ecto.Enum, values: [:draft, :live, :trash], default: :draft
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :body, :href, :color, :customBg, :status])
    |> validate_required([:title, :body, :href, :status])
    |> unique_constraint(:title)
    |> unique_constraint(:href)
  end
end

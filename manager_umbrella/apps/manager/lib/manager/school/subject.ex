defmodule Manager.School.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :description, :string
    field :name, :string
    field :teacher, :string

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :description, :teacher])
    |> validate_required([:name, :description, :teacher])
    |> unique_constraint(:name)
  end
end

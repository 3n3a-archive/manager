defmodule Manager.School.Exam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exams" do
    field :mark, :integer
    field :name, :string
    field :status, Ecto.Enum, values: [:draft, :live, :trash]
    field :type, Ecto.Enum, values: [:uk, :bf]
    field :subject_id, :id

    timestamps()
  end

  @doc false
  def changeset(exam, attrs) do
    exam
    |> cast(attrs, [:name, :mark, :type, :status])
    |> validate_required([:name, :mark, :type, :status])
    |> unique_constraint(:name)
  end
end

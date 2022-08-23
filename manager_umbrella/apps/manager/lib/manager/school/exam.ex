defmodule Manager.School.Exam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exams" do
    field :mark, :float
    field :name, :string
    field :status, Ecto.Enum, values: [:draft, :live, :trash], default: :draft
    field :type, Ecto.Enum, values: [:uk, :bf]
    field :subject_id, :id

    timestamps()
  end

  @doc false
  def changeset(exam, attrs) do
    exam
    |> cast(attrs, [:name, :mark, :type, :status, :subject_id])
    |> validate_required([:name, :mark, :type, :status, :subject_id])
  end
end

defmodule Manager.Repo.Migrations.CreateExams do
  use Ecto.Migration

  def change do
    create table(:exams) do
      add :name, :string
      add :mark, :integer
      add :type, :string
      add :status, :string
      add :subject_id, references(:subjects, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:exams, [:name])
    create index(:exams, [:subject_id])
  end
end

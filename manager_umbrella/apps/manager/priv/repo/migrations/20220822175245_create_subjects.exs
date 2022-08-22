defmodule Manager.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string
      add :description, :text
      add :teacher, :string

      timestamps()
    end

    create unique_index(:subjects, [:name])
  end
end

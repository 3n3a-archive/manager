defmodule Manager.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :string
      add :body, :text
      add :href, :text
      add :color, :text
      add :customBg, :text
      add :status, :string

      timestamps()
    end

    create unique_index(:projects, [:href])
    create unique_index(:projects, [:title])
  end
end

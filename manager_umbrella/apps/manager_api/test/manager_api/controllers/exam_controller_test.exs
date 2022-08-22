defmodule ManagerApi.ExamControllerTest do
  use ManagerApi.ConnCase

  import Manager.SchoolFixtures

  alias Manager.School.Exam

  @create_attrs %{
    mark: 42,
    name: "some name",
    status: :draft,
    type: :uk
  }
  @update_attrs %{
    mark: 43,
    name: "some updated name",
    status: :live,
    type: :bf
  }
  @invalid_attrs %{mark: nil, name: nil, status: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all exams", %{conn: conn} do
      conn = get(conn, Routes.exam_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create exam" do
    test "renders exam when data is valid", %{conn: conn} do
      conn = post(conn, Routes.exam_path(conn, :create), exam: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.exam_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "mark" => 42,
               "name" => "some name",
               "status" => "draft",
               "type" => "uk"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.exam_path(conn, :create), exam: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update exam" do
    setup [:create_exam]

    test "renders exam when data is valid", %{conn: conn, exam: %Exam{id: id} = exam} do
      conn = put(conn, Routes.exam_path(conn, :update, exam), exam: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.exam_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "mark" => 43,
               "name" => "some updated name",
               "status" => "live",
               "type" => "bf"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, exam: exam} do
      conn = put(conn, Routes.exam_path(conn, :update, exam), exam: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete exam" do
    setup [:create_exam]

    test "deletes chosen exam", %{conn: conn, exam: exam} do
      conn = delete(conn, Routes.exam_path(conn, :delete, exam))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.exam_path(conn, :show, exam))
      end
    end
  end

  defp create_exam(_) do
    exam = exam_fixture()
    %{exam: exam}
  end
end

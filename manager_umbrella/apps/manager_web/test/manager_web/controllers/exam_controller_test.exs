defmodule ManagerWeb.ExamControllerTest do
  use ManagerWeb.ConnCase

  import Manager.SchoolFixtures

  @create_attrs %{mark: 42, name: "some name", status: :draft, type: :uk}
  @update_attrs %{mark: 43, name: "some updated name", status: :live, type: :bf}
  @invalid_attrs %{mark: nil, name: nil, status: nil, type: nil}

  describe "index" do
    test "lists all exams", %{conn: conn} do
      conn = get(conn, Routes.exam_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Exams"
    end
  end

  describe "new exam" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.exam_path(conn, :new))
      assert html_response(conn, 200) =~ "New Exam"
    end
  end

  describe "create exam" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.exam_path(conn, :create), exam: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.exam_path(conn, :show, id)

      conn = get(conn, Routes.exam_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Exam"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.exam_path(conn, :create), exam: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Exam"
    end
  end

  describe "edit exam" do
    setup [:create_exam]

    test "renders form for editing chosen exam", %{conn: conn, exam: exam} do
      conn = get(conn, Routes.exam_path(conn, :edit, exam))
      assert html_response(conn, 200) =~ "Edit Exam"
    end
  end

  describe "update exam" do
    setup [:create_exam]

    test "redirects when data is valid", %{conn: conn, exam: exam} do
      conn = put(conn, Routes.exam_path(conn, :update, exam), exam: @update_attrs)
      assert redirected_to(conn) == Routes.exam_path(conn, :show, exam)

      conn = get(conn, Routes.exam_path(conn, :show, exam))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, exam: exam} do
      conn = put(conn, Routes.exam_path(conn, :update, exam), exam: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Exam"
    end
  end

  describe "delete exam" do
    setup [:create_exam]

    test "deletes chosen exam", %{conn: conn, exam: exam} do
      conn = delete(conn, Routes.exam_path(conn, :delete, exam))
      assert redirected_to(conn) == Routes.exam_path(conn, :index)

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

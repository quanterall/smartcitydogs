defmodule SmartCityDogs.ProcedureTypesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.ProcedureTypes

  describe "procedure_types" do
    alias SmartCityDogs.ProcedureTypes.ProcedureType

    @valid_attrs %{deleted_at: ~N[2010-04-17 14:00:00.000000], name: "some name"}
    @update_attrs %{deleted_at: ~N[2011-05-18 15:01:01.000000], name: "some updated name"}
    @invalid_attrs %{deleted_at: nil, name: nil}

    def procedure_type_fixture(attrs \\ %{}) do
      {:ok, procedure_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProcedureTypes.create_procedure_type()

      procedure_type
    end

    test "list_procedure_types/0 returns all procedure_types" do
      procedure_type = procedure_type_fixture()
      assert ProcedureTypes.list_procedure_types() == [procedure_type]
    end

    test "get_procedure_type!/1 returns the procedure_type with given id" do
      procedure_type = procedure_type_fixture()
      assert ProcedureTypes.get_procedure_type!(procedure_type.id) == procedure_type
    end

    test "create_procedure_type/1 with valid data creates a procedure_type" do
      assert {:ok, %ProcedureType{} = procedure_type} =
               ProcedureTypes.create_procedure_type(@valid_attrs)

      assert procedure_type.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert procedure_type.name == "some name"
    end

    test "create_procedure_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProcedureTypes.create_procedure_type(@invalid_attrs)
    end

    test "update_procedure_type/2 with valid data updates the procedure_type" do
      procedure_type = procedure_type_fixture()

      assert {:ok, procedure_type} =
               ProcedureTypes.update_procedure_type(procedure_type, @update_attrs)

      assert %ProcedureType{} = procedure_type
      assert procedure_type.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert procedure_type.name == "some updated name"
    end

    test "update_procedure_type/2 with invalid data returns error changeset" do
      procedure_type = procedure_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ProcedureTypes.update_procedure_type(procedure_type, @invalid_attrs)

      assert procedure_type == ProcedureTypes.get_procedure_type!(procedure_type.id)
    end

    test "delete_procedure_type/1 deletes the procedure_type" do
      procedure_type = procedure_type_fixture()
      assert {:ok, %ProcedureType{}} = ProcedureTypes.delete_procedure_type(procedure_type)

      assert_raise Ecto.NoResultsError, fn ->
        ProcedureTypes.get_procedure_type!(procedure_type.id)
      end
    end

    test "change_procedure_type/1 returns a procedure_type changeset" do
      procedure_type = procedure_type_fixture()
      assert %Ecto.Changeset{} = ProcedureTypes.change_procedure_type(procedure_type)
    end
  end
end

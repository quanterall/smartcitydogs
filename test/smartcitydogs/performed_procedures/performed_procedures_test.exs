defmodule SmartCityDogs.PerformedProceduresTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.PerformedProcedures

  describe "performed_procedure" do
    alias SmartCityDogs.PerformedProcedures.PerformedProcedure

    @valid_attrs %{date: ~N[2010-04-17 14:00:00.000000], deleted_at: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{date: ~N[2011-05-18 15:01:01.000000], deleted_at: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{date: nil, deleted_at: nil}

    def performed_procedure_fixture(attrs \\ %{}) do
      {:ok, performed_procedure} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PerformedProcedures.create_performed_procedure()

      performed_procedure
    end

    test "list_performed_procedure/0 returns all performed_procedure" do
      performed_procedure = performed_procedure_fixture()
      assert PerformedProcedures.list_performed_procedure() == [performed_procedure]
    end

    test "get_performed_procedure!/1 returns the performed_procedure with given id" do
      performed_procedure = performed_procedure_fixture()
      assert PerformedProcedures.get_performed_procedure!(performed_procedure.id) == performed_procedure
    end

    test "create_performed_procedure/1 with valid data creates a performed_procedure" do
      assert {:ok, %PerformedProcedure{} = performed_procedure} = PerformedProcedures.create_performed_procedure(@valid_attrs)
      assert performed_procedure.date == ~N[2010-04-17 14:00:00.000000]
      assert performed_procedure.deleted_at == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_performed_procedure/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PerformedProcedures.create_performed_procedure(@invalid_attrs)
    end

    test "update_performed_procedure/2 with valid data updates the performed_procedure" do
      performed_procedure = performed_procedure_fixture()
      assert {:ok, performed_procedure} = PerformedProcedures.update_performed_procedure(performed_procedure, @update_attrs)
      assert %PerformedProcedure{} = performed_procedure
      assert performed_procedure.date == ~N[2011-05-18 15:01:01.000000]
      assert performed_procedure.deleted_at == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_performed_procedure/2 with invalid data returns error changeset" do
      performed_procedure = performed_procedure_fixture()
      assert {:error, %Ecto.Changeset{}} = PerformedProcedures.update_performed_procedure(performed_procedure, @invalid_attrs)
      assert performed_procedure == PerformedProcedures.get_performed_procedure!(performed_procedure.id)
    end

    test "delete_performed_procedure/1 deletes the performed_procedure" do
      performed_procedure = performed_procedure_fixture()
      assert {:ok, %PerformedProcedure{}} = PerformedProcedures.delete_performed_procedure(performed_procedure)
      assert_raise Ecto.NoResultsError, fn -> PerformedProcedures.get_performed_procedure!(performed_procedure.id) end
    end

    test "change_performed_procedure/1 returns a performed_procedure changeset" do
      performed_procedure = performed_procedure_fixture()
      assert %Ecto.Changeset{} = PerformedProcedures.change_performed_procedure(performed_procedure)
    end
  end
end

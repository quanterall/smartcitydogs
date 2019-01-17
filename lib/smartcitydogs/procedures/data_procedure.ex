defmodule Smartcitydogs.DataProcedure do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.PerformedProcedure
  alias Smartcitydogs.ProcedureType
  alias Smartcitydogs.Rescue

  ### Performed Procedures function
  def list_performed_procedure do
    Repo.all(PerformedProcedure)
  end

  def get_performed_procedure!(id) do
    Repo.get!(PerformedProcedure, id)
  end

  def create_performed_procedure(args \\ %{}) do
    %PerformedProcedure{}
    |> PerformedProcedure.changeset(args)
    |> Repo.insert()
  end

  def update_performed_procedure(%PerformedProcedure{} = procedure, args) do
    procedure
    |> PerformedProcedure.changeset(args)
    |> Repo.update()
  end

  def delete_performed_procedure(%PerformedProcedure{} = procedure) do
    Repo.delete(procedure)
  end

  def change_performed_procedure(%PerformedProcedure{} = procedure) do
    PerformedProcedure.changeset(procedure, %{})
  end

  ### Procedure Type function
  def list_procedure_type do
    Repo.all(ProcedureType)
  end

  def get_procedure_type!(id) do
    Repo.get!(ProcedureType, id)
  end

  def create_procedure_type(args \\ %{}) do
    %ProcedureType{}
    |> ProcedureType.changeset(args)
    |> Repo.insert()
  end

  def update_procedure_type(%ProcedureType{} = procedure, args) do
    procedure
    |> ProcedureType.changeset(args)
    |> Repo.update()
  end

  def delete_procedure_type(%ProcedureType{} = procedure) do
    Repo.delete(procedure)
  end

  def change_procedure_type(%ProcedureType{} = procedure) do
    ProcedureType.changeset(procedure, %{})
  end

  ###  Rescue function
  def list_rescues do
    Repo.all(Rescue)
  end

  def get_rescues!(id) do
    Repo.get!(Rescue, id)
  end

  def create_rescues(args \\ %{}) do
    %Rescue{}
    |> Rescue.changeset(args)
    |> Repo.insert()
  end

  def update_rescues(%Rescue{} = rescues, args) do
    rescues
    |> Rescue.changeset(args)
    |> Repo.update()
  end

  def delete_rescues(%Rescue{} = rescues) do
    Repo.delete(rescues)
  end

  def change_rescues(%Rescue{} = rescues) do
    Rescue.changeset(rescues, %{})
  end
end

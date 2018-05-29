defmodule Smartcitydogs.DataProcedure do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.PerformedProcedures
  alias Smartcitydogs.ProcedureType
  alias Smartcitydogs.Rescues

  import Plug.Conn

  ### Performed Procedures function
  def list_performed_procedure do
    Repo.all(PerformedProcedures)
  end

  def get_performed_procedure!(id) do
    Repo.get!(PerformedProcedures, id)
  end

  def create_performed_procedure(args \\ %{}) do
    %PerformedProcedures{}
    |> PerformedProcedures.changeset(args)
    |> Repo.insert()
  end

  def update_performed_procedure(%PerformedProcedures{} = procedure, args) do
    procedure
    |> PerformedProcedures.changeset(args)
    |> Repo.update()
  end

  def delete_performed_procedure(%PerformedProcedures{} = procedure) do
    Repo.delete(procedure)
  end

  def change_performed_procedure(%PerformedProcedures{} = procedure) do
    PerformedProcedures.changeset(procedure, %{})
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

  ###  Rescues function 
  def list_rescues do
    Repo.all(Rescues)
  end

  def get_rescues!(id) do
    Repo.get!(Rescues, id)
  end

  def create_rescues(args \\ %{}) do
    %Rescues{}
    |> Rescues.changeset(args)
    |> Repo.insert()
  end

  def update_rescues(%Rescues{} = rescues, args) do
    rescues
    |> Rescues.changeset(args)
    |> Repo.update()
  end

  def delete_rescues(%Rescues{} = rescues) do
    Repo.delete(rescues)
  end

  def change_rescues(%Rescues{} = rescues) do
    Rescues.changeset(rescues, %{})
  end
end

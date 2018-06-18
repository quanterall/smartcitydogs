defmodule SmartCityDogs.SignalsTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.Signals

  describe "signals" do
    alias SmartCityDogs.Signals.Signal

    @valid_attrs %{address: "some address", chip_number: "some chip_number", deleted_at: ~N[2010-04-17 14:00:00.000000], description: "some description", signals_categories_id: 42, signals_types_id: 42, support_count: 42, title: "some title", users_id: 42, view_count: 42}
    @update_attrs %{address: "some updated address", chip_number: "some updated chip_number", deleted_at: ~N[2011-05-18 15:01:01.000000], description: "some updated description", signals_categories_id: 43, signals_types_id: 43, support_count: 43, title: "some updated title", users_id: 43, view_count: 43}
    @invalid_attrs %{address: nil, chip_number: nil, deleted_at: nil, description: nil, signals_categories_id: nil, signals_types_id: nil, support_count: nil, title: nil, users_id: nil, view_count: nil}

    def signal_fixture(attrs \\ %{}) do
      {:ok, signal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Signals.create_signal()

      signal
    end

    test "list_signals/0 returns all signals" do
      signal = signal_fixture()
      assert Signals.list_signals() == [signal]
    end

    test "get_signal!/1 returns the signal with given id" do
      signal = signal_fixture()
      assert Signals.get_signal!(signal.id) == signal
    end

    test "create_signal/1 with valid data creates a signal" do
      assert {:ok, %Signal{} = signal} = Signals.create_signal(@valid_attrs)
      assert signal.address == "some address"
      assert signal.chip_number == "some chip_number"
      assert signal.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert signal.description == "some description"
      assert signal.signals_categories_id == 42
      assert signal.signals_types_id == 42
      assert signal.support_count == 42
      assert signal.title == "some title"
      assert signal.users_id == 42
      assert signal.view_count == 42
    end

    test "create_signal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Signals.create_signal(@invalid_attrs)
    end

    test "update_signal/2 with valid data updates the signal" do
      signal = signal_fixture()
      assert {:ok, signal} = Signals.update_signal(signal, @update_attrs)
      assert %Signal{} = signal
      assert signal.address == "some updated address"
      assert signal.chip_number == "some updated chip_number"
      assert signal.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert signal.description == "some updated description"
      assert signal.signals_categories_id == 43
      assert signal.signals_types_id == 43
      assert signal.support_count == 43
      assert signal.title == "some updated title"
      assert signal.users_id == 43
      assert signal.view_count == 43
    end

    test "update_signal/2 with invalid data returns error changeset" do
      signal = signal_fixture()
      assert {:error, %Ecto.Changeset{}} = Signals.update_signal(signal, @invalid_attrs)
      assert signal == Signals.get_signal!(signal.id)
    end

    test "delete_signal/1 deletes the signal" do
      signal = signal_fixture()
      assert {:ok, %Signal{}} = Signals.delete_signal(signal)
      assert_raise Ecto.NoResultsError, fn -> Signals.get_signal!(signal.id) end
    end

    test "change_signal/1 returns a signal changeset" do
      signal = signal_fixture()
      assert %Ecto.Changeset{} = Signals.change_signal(signal)
    end
  end
end

defmodule SmartCityDogs.SignalsCommentsTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.SignalsComments

  describe "signals_comments" do
    alias SmartCityDogs.SignalsComments.SignalsComment

    @valid_attrs %{
      comment: "some comment",
      deleted_at: ~N[2010-04-17 14:00:00.000000],
      signals_id: 42,
      users_id: 42
    }
    @update_attrs %{
      comment: "some updated comment",
      deleted_at: ~N[2011-05-18 15:01:01.000000],
      signals_id: 43,
      users_id: 43
    }
    @invalid_attrs %{comment: nil, deleted_at: nil, signals_id: nil, users_id: nil}

    def signals_comment_fixture(attrs \\ %{}) do
      {:ok, signals_comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SignalsComments.create_signals_comment()

      signals_comment
    end

    test "list_signals_comments/0 returns all signals_comments" do
      signals_comment = signals_comment_fixture()
      assert SignalsComments.list_signals_comments() == [signals_comment]
    end

    test "get_signals_comment!/1 returns the signals_comment with given id" do
      signals_comment = signals_comment_fixture()
      assert SignalsComments.get_signals_comment!(signals_comment.id) == signals_comment
    end

    test "create_signals_comment/1 with valid data creates a signals_comment" do
      assert {:ok, %SignalsComment{} = signals_comment} =
               SignalsComments.create_signals_comment(@valid_attrs)

      assert signals_comment.comment == "some comment"
      assert signals_comment.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert signals_comment.signals_id == 42
      assert signals_comment.users_id == 42
    end

    test "create_signals_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SignalsComments.create_signals_comment(@invalid_attrs)
    end

    test "update_signals_comment/2 with valid data updates the signals_comment" do
      signals_comment = signals_comment_fixture()

      assert {:ok, signals_comment} =
               SignalsComments.update_signals_comment(signals_comment, @update_attrs)

      assert %SignalsComment{} = signals_comment
      assert signals_comment.comment == "some updated comment"
      assert signals_comment.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert signals_comment.signals_id == 43
      assert signals_comment.users_id == 43
    end

    test "update_signals_comment/2 with invalid data returns error changeset" do
      signals_comment = signals_comment_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SignalsComments.update_signals_comment(signals_comment, @invalid_attrs)

      assert signals_comment == SignalsComments.get_signals_comment!(signals_comment.id)
    end

    test "delete_signals_comment/1 deletes the signals_comment" do
      signals_comment = signals_comment_fixture()
      assert {:ok, %SignalsComment{}} = SignalsComments.delete_signals_comment(signals_comment)

      assert_raise Ecto.NoResultsError, fn ->
        SignalsComments.get_signals_comment!(signals_comment.id)
      end
    end

    test "change_signals_comment/1 returns a signals_comment changeset" do
      signals_comment = signals_comment_fixture()
      assert %Ecto.Changeset{} = SignalsComments.change_signals_comment(signals_comment)
    end
  end
end

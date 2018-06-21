defmodule SmartCityDogs.SignalsLikesTest do
  use SmartCityDogs.DataCase

  alias SmartCityDogs.SignalsLikes

  describe "signals_likes" do
    alias SmartCityDogs.SignalsLikes.SignalsLike

    @valid_attrs %{
      deleted_at: ~N[2010-04-17 14:00:00.000000],
      like: 42,
      signals_id: 42,
      users_id: 42
    }
    @update_attrs %{
      deleted_at: ~N[2011-05-18 15:01:01.000000],
      like: 43,
      signals_id: 43,
      users_id: 43
    }
    @invalid_attrs %{deleted_at: nil, like: nil, signals_id: nil, users_id: nil}

    def signals_like_fixture(attrs \\ %{}) do
      {:ok, signals_like} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SignalsLikes.create_signals_like()

      signals_like
    end

    test "list_signals_likes/0 returns all signals_likes" do
      signals_like = signals_like_fixture()
      assert SignalsLikes.list_signals_likes() == [signals_like]
    end

    test "get_signals_like!/1 returns the signals_like with given id" do
      signals_like = signals_like_fixture()
      assert SignalsLikes.get_signals_like!(signals_like.id) == signals_like
    end

    test "create_signals_like/1 with valid data creates a signals_like" do
      assert {:ok, %SignalsLike{} = signals_like} = SignalsLikes.create_signals_like(@valid_attrs)
      assert signals_like.deleted_at == ~N[2010-04-17 14:00:00.000000]
      assert signals_like.like == 42
      assert signals_like.signals_id == 42
      assert signals_like.users_id == 42
    end

    test "create_signals_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SignalsLikes.create_signals_like(@invalid_attrs)
    end

    test "update_signals_like/2 with valid data updates the signals_like" do
      signals_like = signals_like_fixture()
      assert {:ok, signals_like} = SignalsLikes.update_signals_like(signals_like, @update_attrs)
      assert %SignalsLike{} = signals_like
      assert signals_like.deleted_at == ~N[2011-05-18 15:01:01.000000]
      assert signals_like.like == 43
      assert signals_like.signals_id == 43
      assert signals_like.users_id == 43
    end

    test "update_signals_like/2 with invalid data returns error changeset" do
      signals_like = signals_like_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SignalsLikes.update_signals_like(signals_like, @invalid_attrs)

      assert signals_like == SignalsLikes.get_signals_like!(signals_like.id)
    end

    test "delete_signals_like/1 deletes the signals_like" do
      signals_like = signals_like_fixture()
      assert {:ok, %SignalsLike{}} = SignalsLikes.delete_signals_like(signals_like)
      assert_raise Ecto.NoResultsError, fn -> SignalsLikes.get_signals_like!(signals_like.id) end
    end

    test "change_signals_like/1 returns a signals_like changeset" do
      signals_like = signals_like_fixture()
      assert %Ecto.Changeset{} = SignalsLikes.change_signals_like(signals_like)
    end
  end
end

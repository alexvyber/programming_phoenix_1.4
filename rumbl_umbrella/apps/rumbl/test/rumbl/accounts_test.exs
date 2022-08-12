defmodule Rumbl.AccountsTest do
  use Rumbl.DataCase, async: true

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  describe "redister_user/1" do
    @valid_attrs %{
      name: "Some User",
      username: "someuser",
      password: "UserPassword"
    }

    @invalid_attrs %{}

    test "with valid data insserts user" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert user.name == "Some User"
      assert user.username == "someuser"
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "with invalid data does not insert user" do
      assert {:error, _changeset} = Accounts.register_user(@invalid_attrs)
      assert Accounts.list_users() == []
    end

    test "enforces unique usernames" do
      assert {:ok, %User{id: id}} = Accounts.register_user(@valid_attrs)
      assert {:error, changeset} = Accounts.register_user(@valid_attrs)

      assert %{username: ["has already been taken"]} = errors_on(changeset)

      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "does not accepts long username" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 101))
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{username: ["should be at most 30 character(s)"]} = errors_on(changeset)

      assert Accounts.list_users() == []
    end

    test "does not accepts short username" do
      attrs = Map.put(@valid_attrs, :username, "a")
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{username: ["should be at least 5 character(s)"]} = errors_on(changeset)

      assert Accounts.list_users() == []
    end

    test "requires password to be at least 8 characters long" do
      attrs = Map.put(@valid_attrs, :password, "asdf")
      {:error, changeset} = Accounts.register_user(attrs)

      assert %{password: ["should be at least 8 character(s)"]} = errors_on(changeset)

      assert Accounts.list_users() == []
    end
  end

  describe "authenticate_by_username_and_pass/2" do
    @pass "12345678"

    setup do
      {:ok, user: user_fixture(password: @pass)}
    end

    test "returns user with correct password", %{user: user} do
      assert {:ok, auth_user} =
               Accounts.authenticate_by_username_and_password(user.username, @pass)

      assert auth_user.id == user.id
    end

    test "returns unauthorized error with invalid password", %{user: user} do
      assert {:error, :unauthorized} =
               Accounts.authenticate_by_username_and_password(user.username, "badpassword")
    end

    test "returns not found error with no matching user for email" do
      assert {:error, :not_found} =
               Accounts.authenticate_by_username_and_password("uknownusername", @pass)
    end
  end
end

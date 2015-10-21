defmodule StartTest do
  use ExUnit.Case, async: true

  test "connection_errors" do
    assert {:error, %Mariaex.Error{mariadb: %{message: "Unknown database 'non_existing'"}}} =
      Mariaex.Connection.start_link(username: "root", database: "non_existing")
    assert {:error, %Mariaex.Error{mariadb: %{message: "Access denied for user " <> _}}} =
      Mariaex.Connection.start_link(username: "non_existing", database: "mariaex_test")
    assert {:error, %Mariaex.Error{message: "tcp connect: econnrefused"}} =
      Mariaex.Connection.start_link(username: "root", database: "mariaex_test", port: 60999)
  end

  test "secure auth false" do
    {:ok, _} = Mariaex.Connection.start_link(username: "mariaex_user_2", database: "mariaex_test", password: "mariaex_pass")
  end
end

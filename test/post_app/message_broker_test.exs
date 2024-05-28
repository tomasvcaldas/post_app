defmodule PostApp.MesssageBrokerTest do
  use ExUnit.Case, async: false

  alias PostApp.MessageBroker

  describe "subscribe/1" do
    test "subscribes to the post topic" do
      assert :ok = MessageBroker.subscribe("1")
    end
  end

  describe "broadcast/1" do
    test "broadcasts and received comment created event on subscribed topics" do
      MessageBroker.subscribe("1")
      assert :ok = MessageBroker.broadcast("1")

      assert_received {:comment_created, "1"}
    end

    test "does not receive comment created event on no subscribed topics" do
      assert MessageBroker.broadcast("1")

      refute_received {:comment_created, "1"}
    end
  end
end

require_relative 'bench_init'

context "Configure a Receiver" do
  receiver = OpenStruct.new

  context "Default attribute name" do
    test "The receiver has an instance of the post object" do
      OpsGenieClient::Alert::HTTP::Post.configure receiver

      assert(receiver.ops_genie_post.is_a? OpsGenieClient::Alert::HTTP::Post)
    end
  end

  context "Specific attribute name" do
    test "The receiver has an instance of the post object" do
      OpsGenieClient::Alert::HTTP::Post.configure receiver, :other_attr

      assert(receiver.other_attr.is_a? OpsGenieClient::Alert::HTTP::Post)
    end
  end
end

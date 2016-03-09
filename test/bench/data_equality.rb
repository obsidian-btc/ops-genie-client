require_relative 'bench_init'

context "Data Equality" do
  test "Data object equality can be tested" do
    data_1 = OpsGenieClient::Controls::Alert::Data.example
    data_2 = OpsGenieClient::Controls::Alert::Data.example

    assert(data_1 == data_2)
  end
end

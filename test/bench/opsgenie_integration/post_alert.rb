require_relative '../bench_init'

context "Post Alert Data to the OpsGenie API" do
  test "Results in HTTP Status of 202 Accepted" do
    data = OpsGenieClient::Controls::Alert::Data.example
    response = OpsGenieClient::Alert::HTTP::Post.(data)

    assert(response.status_code == 202)
  end
end

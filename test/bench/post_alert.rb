require_relative 'bench_init'

context "Post Alert Data to the OpsGenie API" do
  test "Results in HTTP Status of 200 OK" do
    data = OpsGenieClient::Controls::Alert::Data.example
    response = OpsGenieClient::Alert::HTTP::Post.(data)

    __logger.focus response.inspect

    assert(response.status_code == 200)
  end
end

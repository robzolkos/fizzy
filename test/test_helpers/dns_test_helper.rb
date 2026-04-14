module DnsTestHelper
  FCM_PUBLIC_TEST_IP = "142.250.185.206" # stable public IP for FCM DNS stubs in tests

  private

  def stub_dns_resolution(*ips)
    dns_mock = mock("dns")
    dns_mock.stubs(:each_address).multiple_yields(*ips)
    Resolv::DNS.stubs(:open).yields(dns_mock)
  end

  def stub_fcm_dns_resolution
    stub_dns_resolution(FCM_PUBLIC_TEST_IP)
  end
end

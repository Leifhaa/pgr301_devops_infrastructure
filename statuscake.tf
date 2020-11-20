resource "statuscake_test" "taskapptest" {
  website_name = "Alive test"
  #Find the url by other resource
  website_url = "https://foobaaarImnotalivelol.com"
  test_type = "HTTP"
  #Time in seconds
  check_rate = 60
  #Id of the contact group (found in the URL when clicking the contact group)
  contact_group =  ["195395"]
}

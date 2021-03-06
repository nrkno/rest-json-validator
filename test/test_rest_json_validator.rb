require 'json'
gem "minitest"
require 'minitest/autorun'
require 'minitest/spec'
require "mediaelement_test_spec"
require 'tester'
include MediaelementTestSpec

class RestJsonValidatorTest < Minitest::Spec
  def test_the_mediaelement_has_the_expected_specification
    tester = Tester.new
    tester.add_listener self
    mediaelement = JSON.parse open("./test/mediaelement.json").read()
    tester.validate_json_api_compliance(mediaelement, MEDIAELEMENT_V9_CHECKS )
    assert_equal 0, tester.num_bugs, "Expected no errors found here"
    assert_equal true, tester.check_title_called?, "Field_validator: Expected check_title to be called"
    assert_equal true, tester.check_parts_called?, "Content_checker: Expected check_parts to be called"
    assert_equal true, tester.check_nonplayable_called?, "Composite_checker: Expected check_nonplayable to be called"
  end
end

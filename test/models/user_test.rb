require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # validates :email presence - positive, negative, minimal
  # bob is a normal user
  # nameless is a minimal user (lacking name but having all required attributes)

  test "A user must have an email to be valid" do
    assert users(:bob).valid?
    users(:bob).email = nil
    assert_not users(:bob).valid?

    assert users(:nameless).valid?
    users(:nameless).email = nil
    assert_not users(:nameless).valid?
  end

  # validates :uid presence
  test "A user must have a uid to be valid" do
    assert users(:bob).valid?
    users(:bob).uid = nil
    assert_not users(:bob).valid?

    assert users(:nameless).valid?
    users(:nameless).uid = nil
    assert_not users(:nameless).valid?
  end

  # validates :provider presence
  test "A user must have a provider to be valid" do
    assert users(:bob).valid?
    users(:bob).provider = nil
    assert_not users(:bob).valid?

    assert users(:nameless).valid?
    users(:nameless).provider = nil
    assert_not users(:nameless).valid?
  end

  # build_from_github(auth_hash) custom method
  test "A user can be correctly built from a normal Github auth hash" do
    user = User.build_from_github(OmniAuth.config.mock_auth[:github])
    assert user
    assert_equal(user.name, 'Satine')
    assert_equal(user.uid, '123545'.to_i)
    assert_equal(user.provider, 'github')
    assert_equal(user.email, 'satine@catworld.com')
  end

  test "A user can be correctly built from a minimal Github auth hash" do
    user = User.build_from_github(OmniAuth::AuthHash.new({:provider => 'github', :uid => '123545', :info => {:email => 'satine@catworld.com'}}))
    assert user
    assert_equal(user.uid, '123545'.to_i)
    assert_equal(user.provider, 'github')
    assert_equal(user.email, 'satine@catworld.com')
  end

  test "A user cannot be built from an insufficient Github auth hash" do
    user = User.build_from_github(OmniAuth::AuthHash.new({:provider => 'github', :info => {:email => 'satine@catworld.com'}}))
    assert_not user.valid?
    user = User.build_from_github(OmniAuth::AuthHash.new({:provider => 'github', :uid => '123545', :info => {}}))
    assert_not user.valid?
  end

end

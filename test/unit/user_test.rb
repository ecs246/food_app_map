require 'test_helper'


class UserTest < ActiveSupport::TestCase
  
  def setup 
    @generic = {
      :name=> 'name',
      :password=> 'password',
      :password_confirmation=> 'password'
    }
  end
  # Replace this with your real test
  test "should create a user with valid attributes" do 
    user = User.new(@generic)
    assert user.save(@generic), "Can't create user with valid attributes";
  end
  
  test "should not save user without name" do
    user = User.new(@generic.merge(:name=>''));
    assert !user.save, "Saved user without a name"
  end
  
  test "should not save user with the same name" do
    
    user = User.new(@generic);
    user.save
    user2 = User.new(@generic);
    assert !user2.save, "Saved user with the same name"
  end
  test "should require a password" do 
    user = User.new(:name=>'p');
    assert !user.save, 'Saved user without password'
  end
  test "should require matching validation" do 
    user = User.new(@generic.merge(:password_confirmation=>'pass'));
    assert !user.save, 'Saved user when password and password confirmation do not match';
  end
  test "should encrypt password before saving" do 
      user = User.new(@generic)
      user.save
      assert !user.encrypted_password.blank? ,'user did not encyrpt password';
  end

  
  
  test "should return true if passwords match " do
        user = User.create!(@generic)
      assert user.has_password?('password'), "Correct password invalid"
  end

  test "should return false if passwords don't match" do
            user = User.create!(@generic)

      assert !user.has_password?('pass'), "Invalid password working"

  end
  
  
end

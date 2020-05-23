require 'test_helper'

class UserTest < ActiveSupport::TestCase

    test "user table exists" do
        assert ActiveRecord::Base.connection.table_exists? 'users'
    end

    test "users table has following columns" do
        assert User.column_names.include?("name"), "Column status exist"
        assert User.column_names.include?("email"), "Column status exist"
        assert User.column_names.include?("password"), "Column status exist"
    end

    test 'valid user' do
        user = User.new(name: 'John', email: 'john@example.com', password: "john123")
        assert user.valid?
    end

    test "user name should not be empty" do
        user = User.create(name: '')
        assert user.errors[:name].include? "can't be blank"
    end

    test "user email should not be empty" do
        user = User.create(email: '')
        assert user.errors[:email].include? "can't be blank"
    end

    test "user password should not be empty" do
        user = User.create(password: '')
        assert user.errors[:password].include? "can't be blank"
    end

end
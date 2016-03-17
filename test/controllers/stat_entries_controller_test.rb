require 'test_helper'

class StatEntriesControllerTest < ActionController::TestCase
  setup do
    @stat_entry = stat_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stat_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stat_entry" do
    assert_difference('StatEntry.count') do
      post :create, stat_entry: { belongs_to: @stat_entry.belongs_to, name: @stat_entry.name, value: @stat_entry.value, week: @stat_entry.week, year: @stat_entry.year }
    end

    assert_redirected_to stat_entry_path(assigns(:stat_entry))
  end

  test "should show stat_entry" do
    get :show, id: @stat_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stat_entry
    assert_response :success
  end

  test "should update stat_entry" do
    patch :update, id: @stat_entry, stat_entry: { belongs_to: @stat_entry.belongs_to, name: @stat_entry.name, value: @stat_entry.value, week: @stat_entry.week, year: @stat_entry.year }
    assert_redirected_to stat_entry_path(assigns(:stat_entry))
  end

  test "should destroy stat_entry" do
    assert_difference('StatEntry.count', -1) do
      delete :destroy, id: @stat_entry
    end

    assert_redirected_to stat_entries_path
  end
end

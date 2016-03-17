require 'test_helper'

class StatLinesControllerTest < ActionController::TestCase
  setup do
    @stat_line = stat_lines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stat_lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stat_line" do
    assert_difference('StatLine.count') do
      post :create, stat_line: { fumbles: @stat_line.fumbles, ints: @stat_line.ints, nfl_player_id: @stat_line.nfl_player_id, pass_att: @stat_line.pass_att, pass_comp: @stat_line.pass_comp, pass_tds: @stat_line.pass_tds, pass_yards: @stat_line.pass_yards, qb_rating: @stat_line.qb_rating, rec_tds: @stat_line.rec_tds, rec_yards: @stat_line.rec_yards, receptions: @stat_line.receptions, rush_atts: @stat_line.rush_atts, rush_tds: @stat_line.rush_tds, rush_yards: @stat_line.rush_yards, week: @stat_line.week, year: @stat_line.year }
    end

    assert_redirected_to stat_line_path(assigns(:stat_line))
  end

  test "should show stat_line" do
    get :show, id: @stat_line
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stat_line
    assert_response :success
  end

  test "should update stat_line" do
    patch :update, id: @stat_line, stat_line: { fumbles: @stat_line.fumbles, ints: @stat_line.ints, nfl_player_id: @stat_line.nfl_player_id, pass_att: @stat_line.pass_att, pass_comp: @stat_line.pass_comp, pass_tds: @stat_line.pass_tds, pass_yards: @stat_line.pass_yards, qb_rating: @stat_line.qb_rating, rec_tds: @stat_line.rec_tds, rec_yards: @stat_line.rec_yards, receptions: @stat_line.receptions, rush_atts: @stat_line.rush_atts, rush_tds: @stat_line.rush_tds, rush_yards: @stat_line.rush_yards, week: @stat_line.week, year: @stat_line.year }
    assert_redirected_to stat_line_path(assigns(:stat_line))
  end

  test "should destroy stat_line" do
    assert_difference('StatLine.count', -1) do
      delete :destroy, id: @stat_line
    end

    assert_redirected_to stat_lines_path
  end
end

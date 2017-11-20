require 'test_helper'

class PrepNotesControllerTest < ActionController::TestCase
  setup do
    @prep_note = prep_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prep_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prep_note" do
    assert_difference('PrepNote.count') do
      post :create, prep_note: { note: @prep_note.note }
    end

    assert_redirected_to prep_note_path(assigns(:prep_note))
  end

  test "should show prep_note" do
    get :show, id: @prep_note
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prep_note
    assert_response :success
  end

  test "should update prep_note" do
    patch :update, id: @prep_note, prep_note: { note: @prep_note.note }
    assert_redirected_to prep_note_path(assigns(:prep_note))
  end

  test "should destroy prep_note" do
    assert_difference('PrepNote.count', -1) do
      delete :destroy, id: @prep_note
    end

    assert_redirected_to prep_notes_path
  end
end

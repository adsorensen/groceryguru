class PrepNotesController < ApplicationController
  before_action :set_prep_note, only: [:show, :edit, :update, :destroy]

  # GET /prep_notes
  # GET /prep_notes.json
  def index
    @prep_notes = PrepNote.all
  end

  # GET /prep_notes/1
  # GET /prep_notes/1.json
  def show
  end

  # GET /prep_notes/new
  def new
    @prep_note = PrepNote.new
  end

  # GET /prep_notes/1/edit
  def edit
  end

  # POST /prep_notes
  # POST /prep_notes.json
  def create
    @prep_note = PrepNote.new(prep_note_params)

    respond_to do |format|
      if @prep_note.save
        format.html { redirect_to @prep_note, notice: 'Prep note was successfully created.' }
        format.json { render :show, status: :created, location: @prep_note }
      else
        format.html { render :new }
        format.json { render json: @prep_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prep_notes/1
  # PATCH/PUT /prep_notes/1.json
  def update
    respond_to do |format|
      if @prep_note.update(prep_note_params)
        format.html { redirect_to @prep_note, notice: 'Prep note was successfully updated.' }
        format.json { render :show, status: :ok, location: @prep_note }
      else
        format.html { render :edit }
        format.json { render json: @prep_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prep_notes/1
  # DELETE /prep_notes/1.json
  def destroy
    @prep_note.destroy
    respond_to do |format|
      format.html { redirect_to prep_notes_url, notice: 'Prep note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prep_note
      @prep_note = PrepNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prep_note_params
      params.require(:prep_note).permit(:note)
    end
end

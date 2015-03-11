class VersesController < ApplicationController
  before_action :set_verse, only: [:show, :edit, :update, :destroy]

  # GET /verses
  # GET /verses.json
  def index
    @chapter = Chapter.find params[:chapter_id]
    @verses = @chapter.verses
  end

  # GET /verses/1
  # GET /verses/1.json
  def show
    @translation = @translator.translations.where({ chapter_number: @chapter.number, verse_number: @verse.number }).first
  end

  # GET /verses/new
  def new
    @chapter = Chapter.find params[:chapter_id]
    @verse = Verse.new chapter: @chapter
  end

  # GET /verses/1/edit
  def edit
  end

  # POST /verses
  # POST /verses.json
  def create
    @chapter = Chapter.find params[:chapter_id]
    @verse = Verse.new(verse_params)

    respond_to do |format|
      if @verse.save
        format.html { redirect_to [@chapter, @verse], notice: 'Verse was successfully created.' }
        format.json { render :show, status: :created, location: [@chapter, @verse] }
      else
        format.html { render :new }
        format.json { render json: @verse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /verses/1
  # PATCH/PUT /verses/1.json
  def update
    respond_to do |format|
      if @verse.update(verse_params)
        format.html { redirect_to [@chapter, @verse], notice: 'Verse was successfully updated.' }
        format.json { render :show, status: :ok, location: [@chapter, @verse] }
      else
        format.html { render :edit }
        format.json { render json: @verse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verses/1
  # DELETE /verses/1.json
  def destroy
    @verse.destroy
    respond_to do |format|
      format.html { redirect_to chapter_verses_url, notice: 'Verse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def translation
    author = Author.find params[:author_slug]
    @translation = author.translations.where({ chapter_number: params[:chapter_number], verse_number: params[:verse_number] }).first
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verse
      @chapter = Chapter.find params[:chapter_id]
      @verse = @chapter.verses.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verse_params
      params.require(:verse).permit!
    end
end

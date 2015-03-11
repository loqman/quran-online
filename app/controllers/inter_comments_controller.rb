class InterCommentsController < ApplicationController
  before_action :set_inter_comment, only: [:show, :edit, :update, :destroy]

  # GET /inter_comments
  # GET /inter_comments.json
  def index
    @inter_comments = InterComment.all
  end

  # GET /inter_comments/1
  # GET /inter_comments/1.json
  def show
  end

  # GET /inter_comments/new
  def new
    @inter_comment = InterComment.new
  end

  # GET /inter_comments/1/edit
  def edit
  end

  # POST /inter_comments
  # POST /inter_comments.json
  def create
    @inter_comment = InterComment.new(inter_comment_params)

    respond_to do |format|
      if @inter_comment.save
        format.html { redirect_to @inter_comment, notice: 'Inter comment was successfully created.' }
        format.json { render :show, status: :created, location: @inter_comment }
      else
        format.html { render :new }
        format.json { render json: @inter_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inter_comments/1
  # PATCH/PUT /inter_comments/1.json
  def update
    respond_to do |format|
      if @inter_comment.update(inter_comment_params)
        format.html { redirect_to @inter_comment, notice: 'Inter comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @inter_comment }
      else
        format.html { render :edit }
        format.json { render json: @inter_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inter_comments/1
  # DELETE /inter_comments/1.json
  def destroy
    @inter_comment.destroy
    respond_to do |format|
      format.html { redirect_to inter_comments_url, notice: 'Inter comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inter_comment
      @inter_comment = InterComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inter_comment_params
      params.require(:inter_comment).permit(:content)
    end
end

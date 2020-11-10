class GamesController < ApplicationController


  # TODO load CSRF Token in game creation form
  skip_before_action :verify_authenticity_token
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all.select(:updated_at, :created_at, :uuid).to_a
    @games.select! { |game| game.created_at != game.updated_at }
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update

    # Converts state hash into state array
    box_objects = []
    params[:state].each do |state_obj|
      box_objects.push(state_obj.permit!.to_h)
    end

    serialized_state = YAML.dump(box_objects)

    @game.state = serialized_state

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find_by_uuid(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params
        .require(:game)
        .permit(:rows,
                :cols,
                :mines,
                state: [
                  :col,
                  :row,
                  :status,
                  :has_mine
                ])
    end
end

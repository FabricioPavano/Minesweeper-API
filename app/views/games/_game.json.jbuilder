json.extract! game, :id, :rows, :cols, :mines, :created_at, :updated_at
json.url game_url(game, format: :json)

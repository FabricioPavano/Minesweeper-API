json.extract! game, :uuid, :rows, :cols, :mines, :state, :used_flags, :mines_flagged, :time_ellapsed,  :created_at, :updated_at

json.boxes game.boxes, :row, :col, :has_mine, :status

json.url game_url(game, format: :json)

json.partial! "boards/board", board: @board
json.user_ids @board.users.ids if !@board.all_access?

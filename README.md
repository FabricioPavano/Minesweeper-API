# Minesweeper Ruby on Rails' API

Minesweeper Backend application

## Important Design considerations

- API authentorization is handled using Jason Web Tokens (JWT) on every request

- For improvements in performance and space, the state of each box is in a game is serialized and stored on a single column, this avoids the need to create hundreds of records for each box/tile in each game

- For further performance on the frontend, the number of adjacent mines for each box is precomputed before being sent to the client app.

- The whole API has been designed to respect Rails "convention over configuration" principles and best practices


- Enjoy!


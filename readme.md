# XO Game in Lua 

### This is a simple command-line Tic-Tac-Toe (XO) game implemented in Lua.
### Two players, X and O, take turns entering their moves until one of them wins or the game ends in a draw.

## How to Play

1. Player X always goes first.
2. Players take turns by entering the row and column where they want to place their mark (X or O).
3. The game board is displayed after each move.
4. The first player to align three of their marks (horizontally, vertically, or diagonally) wins the game.
5. If all nine cells are filled and there is no winner, the game ends in a draw.

## Requirements

- Lua interpreter (version 5.1 or later)

You can download Lua from the official website: [https://www.lua.org/download.html](https://www.lua.org/download.html)

## How to Run

1. Download or clone this repository.
2. Open a terminal or command prompt in the directory where the file is located.
3. Run the game using the Lua interpreter:

```bash
rm xo_game.lua
wget https://raw.githubusercontent.com/dev-ir/xo-lua/master/xo_game.lua
lua xo_game.lua

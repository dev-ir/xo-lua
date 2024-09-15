-- XO Game in Lua with Enhanced Error Handling

local board = {}

function dvhost_init_board()
    board = { {" ", " ", " "}, {" ", " ", " "}, {" ", " ", " "} }
end

function dvhost_clear_screen()
    os.execute("clear")  -- Clear the terminal screen on Ubuntu
end

function dvhost_display_board()
    print("    1     2     3")
    for i = 1, 3 do
        io.write(i .. "   ")
        for j = 1, 3 do
            io.write(board[i][j])
            if j < 3 then
                io.write("  |  ")
            end
        end
        print()
        if i < 3 then
            print("   -----------------")
        end
    end
end

function dvhost_is_valid_move(x, y)
    if x < 1 or x > 3 or y < 1 or y > 3 then
        return false, "Move is out of bounds!"
    elseif board[x][y] ~= " " then
        return false, "Cell is already occupied!"
    end
    return true
end

function dvhost_make_move(player, x, y)
    local valid, err_msg = dvhost_is_valid_move(x, y)
    if valid then
        board[x][y] = player
        return true
    else
        print("Error: " .. err_msg)
        return false
    end
end

function dvhost_check_winner()
    local lines = {
        -- Rows
        {{1, 1}, {1, 2}, {1, 3}},
        {{2, 1}, {2, 2}, {2, 3}},
        {{3, 1}, {3, 2}, {3, 3}},
        -- Columns
        {{1, 1}, {2, 1}, {3, 1}},
        {{1, 2}, {2, 2}, {3, 2}},
        {{1, 3}, {2, 3}, {3, 3}},
        -- Diagonals
        {{1, 1}, {2, 2}, {3, 3}},
        {{1, 3}, {2, 2}, {3, 1}}
    }

    for _, line in ipairs(lines) do
        local a, b, c = line[1], line[2], line[3]
        if board[a[1]][a[2]] ~= " " and
           board[a[1]][a[2]] == board[b[1]][b[2]] and
           board[a[1]][a[2]] == board[c[1]][c[2]] then
            return board[a[1]][a[2]]
        end
    end
    return nil
end

function dvhost_is_draw()
    for i = 1, 3 do
        for j = 1, 3 do
            if board[i][j] == " " then
                return false
            end
        end
    end
    return true
end

function dvhost_switch_player(player)
    return (player == "X") and "O" or "X"
end

function dvhost_get_player_move()
    local x, y
    while true do
        print("Enter your move (row and column): ")
        x = tonumber(io.read())
        y = tonumber(io.read())

        if not x or not y then
            print("Invalid input. Please enter numeric values.")
        elseif x < 1 or x > 3 or y < 1 or y > 3 then
            print("Move out of bounds! Enter row and column between 1 and 3.")
        else
            break
        end
    end
    return x, y
end

function dvhost_game()
    dvhost_init_board()
    local current_player = "X"
    local winner

    while true do
        dvhost_clear_screen()  -- Clear screen before each turn
        dvhost_display_board()
        print("Player " .. current_player .. "'s turn")

        -- استفاده از pcall برای حفاظت از بخش حساس که ممکن است دچار خطا شود
        local status, x, y = pcall(dvhost_get_player_move)
        
        if not status then
            print("An error occurred while reading input. Please try again.")
            break
        end

        if dvhost_make_move(current_player, x, y) then
            winner = dvhost_check_winner()
            if winner then
                dvhost_clear_screen()
                dvhost_display_board()
                print("Player " .. winner .. " wins!")
                break
            elseif dvhost_is_draw() then
                dvhost_clear_screen()
                dvhost_display_board()
                print("It's a draw!")
                break
            end
            current_player = dvhost_switch_player(current_player)
        end
    end
end

dvhost_game()

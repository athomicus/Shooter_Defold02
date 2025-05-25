-- Define a module table to hold shared properties and functions
local M = {}

-- Example property to store the life value
M.life = 1123 -- Initial life value

-- Function to get the current life value
function M.get_life()
    return M.life -- Return the current life value
end

-- Function to set a new life value
function M.set_life(value)
    M.life = value -- Update the life value
end

-- Return the module table to make its properties and functions accessible
return M

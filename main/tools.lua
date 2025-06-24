local T={}
function T.remove_object_from_table(tbl, object)
    for i, v in ipairs(tbl) do
        if v == object then
            table.remove(tbl, i)
            break
        end
    end
end

 function T.is_empty(list)
    return next(list) == nil -- Returns true if the list is empty, false otherwise
end

return T
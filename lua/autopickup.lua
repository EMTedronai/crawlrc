----------------------------------------------------------------------
--                       Autopickup Function                        --
----------------------------------------------------------------------

-- Auto pickup function which picks up items for free aux slots
function autopickup(it, name)
  if it.is_useless then
    return
  end
  if it.artefact then
    return true
  end
  local class  = it.class(true)
  if class == "armour" then
    local good_slots = { cloak="Cloak", helmet="Helmet",
                         gloves="Gloves", boots="Boots" }
    st, _ = it.subtype()
    if good_slots[st] ~= nil and items.equipped_at(good_slots[st]) == nil then
      return true
    end
  end
  if class == "missile" then
    if name:find("curare") then
      return true
    end
    if name:find("throwing net") then
      return true
    end
  end
  return
end

add_autopickup_func(autopickup)


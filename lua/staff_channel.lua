----------------------------------------------------------------------
--                    Automated Staff Channeling                    --
----------------------------------------------------------------------

-- Global variables for storing channeling information. The ready
-- function should contain the following code to switch back to
-- the previous wepaon once channeling has been finished:
--
-- if channel_switched_weapon then
--   if not is_enemy_in_los() then
--       crawl.sendkeys('w' .. pre_channel_slot)
--   end
--
--   pre_channel_slot        = nil
--   channel_switched_weapon = false
-- end
channel_switched_weapon = false
pre_channel_slot        = nil

-- Helper function returning true if a hostile creature is in LOS
function is_enemy_in_los()
  local x,y
  for x = -7,7 do
    for y = -7,7 do
      m = monster.get_monster_at(x,y)
      -- 0 = hostile, 1 = neutral, 2 = friendly
      if m and m:attitude() < 1 then
        return true
      end
    end
  end
  return false
end

-- Custom function for equipping a staff of energy and channeling until
-- full MP is full (if no enemies are visible).
function custom_channel()
  channel_switched_weapon = false
  local have_staff        = false
  local weapon            = items.equipped_at("Weapon")

  if mp_percent() == 100 then
    crawl.mpr("You arleady have full MP!")
    return
  end

  if weapon and (weapon.name():find("staff of energy") or
                 weapon.name():find("staff of Wucad")) then
    have_staff = true
  else
    for it in iter.invent_iterator:new(items.inventory()) do
      if it and (it.name():find("staff of energy") or
                 it.name():find("staff of Wucad")) then
        have_staff              = true
        channel_switched_weapon = true
        pre_channel_slot        = items.index_to_letter(weapon.slot)
        local slot              = items.index_to_letter(it.slot)
        crawl.sendkeys('w' .. slot)
        break
      end
    end
  end

  if is_enemy_in_los() then
    crawl.mpr("Don't channel like a madman with enemies in LOS ;)")
  elseif not have_staff then
    crawl.mpr("No staff of energy for channeling!")
  else
    crawl.sendkeys('0' .. '1' .. '0' .. '0' .. 'v')
  end
end


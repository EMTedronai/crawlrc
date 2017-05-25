----------------------------------------------------------------------
--                           Target Skill                           --
----------------------------------------------------------------------

-- Functions for setting skill training targets
-- Bind set_target_skill via macro to change on the fly.
skill_list = { "Fighting","Short Blades","Long Blades","Axes","Maces & Flails",
               "Polearms","Staves","Unarmed Combat","Bows","Crossbows",
               "Throwing","Slings","Armour","Dodging","Shields","Spellcasting",
               "Conjurations","Hexes","Charms","Summonings","Necromancy",
               "Translocations","Transmutations","Fire Magic","Ice Magic",
               "Air Magic","Earth Magic","Poison Magic","Invocations",
               "Evocations","Stealth" }
need_target_skill = nil

function record_current_skills(maxlev)
  c_persist.current_skills = { }
  for _,sk in ipairs(skill_list) do
    if you.train_skill(sk) > 0 and you.base_skill(sk) < (maxlev or 27) then
      table.insert(c_persist.current_skills, sk)
    end
  end
end

function check_skills()
  if not c_persist.current_skills or not c_persist.target_skill then
    return
  end
  for _,sk in ipairs(c_persist.current_skills) do
    if you.base_skill(sk) >= c_persist.target_skill then
      crawl.formatted_mpr(sk .. " reached " .. c_persist.target_skill
                          .. ".", "prompt")
      crawl.more()
      set_new_skill_training()
      break
    end
  end
end

function init_target_skill()
  c_persist.target_skill = nil
  c_persist.current_skills = { }
  need_target_skill = true
end

function set_new_skill_training()
  init_target_skill()
  c_persist.target_skill = 0
  crawl.sendkeys("m")
end

function set_target_skill()
  record_current_skills()
  local str = "Currently training: "
  local first_skill = true
  for _,sk in ipairs(c_persist.current_skills) do
    val = you.base_skill(sk)
    if first_skill then
      str = str .. sk .. "(" .. val .. ")"
    else
      str = str .. ", " .. sk .. "(" .. val .. ")"
    end
    first_skill = false
  end
  str = str .. "."
  crawl.formatted_mpr(str, "prompt")
  crawl.formatted_mpr("Choose a target skill level: ", "prompt")
  c_persist.target_skill = tonumber(crawl.c_input_line())
  record_current_skills(c_persist.target_skill)
  if save_default_target_skill and you.turns() == 0 then
      save_default_target_skill()
  end
end


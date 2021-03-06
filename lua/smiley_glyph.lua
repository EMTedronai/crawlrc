----------------------------------------------------------------------
--                     Obligatory Smiley Glyph                      --
----------------------------------------------------------------------

--                           oooo$$$$$$$$$$$$oooo
--                       oo$$$$$$$$$$$$$$$$$$$$$$$$o
--                    oo$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o         o$   $$ o$
--    o $ oo        o$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o       $$ $$ $$o$
-- oo $ $ "$      o$$$$$$$$$    $$$$$$$$$$$$$    $$$$$$$$$o       $$$o$$o$
-- "$$$$$$o$     o$$$$$$$$$      $$$$$$$$$$$      $$$$$$$$$$o    $$$$$$$$
--   $$$$$$$    $$$$$$$$$$$      $$$$$$$$$$$      $$$$$$$$$$$$$$$$$$$$$$$
--   $$$$$$$$$$$$$$$$$$$$$$$    $$$$$$$$$$$$$    $$$$$$$$$$$$$$  """$$$
--    "$$$""""$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$     "$$$
--     $$$   o$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$     "$$$o
--    o$$"   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$       $$$o
--    $$$    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$" "$$$$$$ooooo$$$$o
--   o$$$oooo$$$$$  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$   o$$$$$$$$$$$$$$$$$
--   $$$$$$$$"$$$$   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$     $$$$""""""""
--  """"       $$$$    "$$$$$$$$$$$$$$$$$$$$$$$$$$$$"      o$$$
--             "$$$o     """$$$$$$$$$$$$$$$$$$"$$"         $$$
--               $$$o          "$$""$$$$$$""""           o$$$
--                $$$$o                                o$$$"
--                 "$$$$o      o$$$$$$o"$$$$o        o$$$$
--                   "$$$$$oo     ""$$$$o$$$$$o   o$$$$""
--                      ""$$$$$oooo  "$$$o$$$$$$$$$"""
--                         ""$$$$$$$oo $$$$$$$$$$
--                                 """"$$$$$$$$$$$
--                                     $$$$$$$$$$$$
--                                      $$$$$$$$$$"
--                                       "$$$""""

-- If HP is over 50%, the player glyph is happy :) The glyph is very
-- sad if HP is below 50% :(
function hp_is_low()
  local hp, mhp = you.hp()
  return (100*hp <= 50*mhp)
end

glyph_is_happy = true

-- Needs to be called in the ready function
function update_glyph()
  local low_hp = hp_is_low()
  if low_hp and glyph_is_happy then
    crawl.setopt("mon_glyph ^= player : x2639")
    glyph_is_happy = false
  elseif not low_hp and not glyph_is_happy then
    crawl.setopt("mon_glyph ^= player : x263b")
    glyph_is_happy = true
  end
end


----------------------------------------------------------------------
--                           Custom Rest                            --
----------------------------------------------------------------------

-- Custom rest function (prompt when trying to rest at full HP)
function hp_percent() a,b=you.hp() return 100*a/b end
function mp_percent() a,b=you.mp() return 100*a/b end

function custom_rest()
  if hp_percent() == 100 and mp_percent() == 100 then
    if crawl.yesnoquit("Wait 100 turns?", true, 'n') == 1 then
      crawl.process_keys("5")
    end
  else
    crawl.process_keys("5")
  end
end


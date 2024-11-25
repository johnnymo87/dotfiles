-- For automatically generating and updating ctags.
-- Depends on some sort of ctags software being already
-- installed. I recommend Universal Ctags, because it seeks to maintain the
-- popular but now-abandoned Exuberant Ctags.

return {
  "ludovicchabant/vim-gutentags",
  lazy = false, -- Load during startup
}

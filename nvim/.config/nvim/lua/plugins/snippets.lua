return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local sn = ls.snippet_node
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      local r = ls.restore_node
      
      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- GORM Struct Tag Snippet for Go
      ls.add_snippets("go", {
        s("gorm", {
          t('`gorm:"'),
          c(1, {
            t("column:"),
            t("primaryKey"),
            t("uniqueIndex"),
            t("size:255"),
            t("not null"),
            t("default:"),
            t("type:varchar(255)"),
            t("type:enum('customer','admin')"),
            t("index"),
            t("autoCreateTime"),
            t("autoUpdateTime"),
            t("embedded"),
            t("embeddedPrefix:"),
            t("foreignKey:"),
            t("references:"),
            t("many2many:"),
            t("-"), -- Skip field
            t(""), -- Empty for custom input
          }),
          i(2), -- For additional input after choice
          t('"`'),
        }),
        
        -- Advanced multi-option GORM tag snippet
        s("gormtag", {
          t('`gorm:"'),
          c(1, {
            t("column:"),
            t("primaryKey;autoIncrement"),
            t("uniqueIndex;not null"),
            t("size:255;not null"),
            t("type:varchar(255);not null;default:''"),
            t("type:enum('customer','admin');default:'customer'"),
            t("index:idx_name,priority:1"),
            t("foreignKey:ID;references:UserID"),
            t("many2many:user_roles;joinForeignKey:UserID;joinReferences:RoleID"),
            t(""), -- Empty for custom input
          }),
          i(2), -- For additional input after choice
          t('"`'),
        }),
        
        -- Commonly used full GORM model tags for ID fields
        s("gormid", {
          t('`gorm:"primaryKey;autoIncrement"`'),
        }),
        
        -- JSON tag to complement GORM
        s("jsongorm", {
          t('`gorm:"'),
          c(1, {
            t("column:"),
            t("primaryKey"),
            t("uniqueIndex"),
            t("size:255"),
            t("not null"),
            t("default:"),
            t("type:varchar(255)"),
          }),
          i(2), -- For additional input after choice
          t('" json:"'),
          i(3, "field_name"),
          t('"`'),
        }),
      })
      
      -- Key mappings for navigating and expanding snippets
      vim.keymap.set({"i", "s"}, "<C-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, {silent = true})
      
      vim.keymap.set({"i", "s"}, "<C-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, {silent = true})
      
      vim.keymap.set({"i", "s"}, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, {silent = true})
    end,
  },
}

local function current_github_repo()
  local remote = vim.fn.systemlist("git config --get remote.origin.url")[1]
  if not remote or remote == "" then
    return nil
  end
  local owner_repo = remote:match("github%.com[:/](.-)%.git$") or remote:match("github%.com[:/](.+)$")
  return owner_repo
end

return {
  "emrearmagan/atlas.nvim",
  config = function(_, opts)
    require("atlas").setup(opts)

    -- atlas.nvim registers its own `Atlas*` highlight groups on load *and* re-runs
    -- that setup every time a view is (re)opened, clobbering our onedark overrides.
    -- Re-apply them after atlas' setup and whenever an atlas buffer appears.
    local highlights = require("config.highlights")
    highlights.apply()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("atlas_highlights", { clear = true }),
      pattern = "atlas.*",
      callback = function()
        vim.schedule(highlights.apply)
      end,
      desc = "Re-apply onedark overrides over atlas.nvim's own highlights",
    })
  end,
  opts = function()
    local repo = current_github_repo()
    local repo_filter = repo and ("repo:" .. repo .. " ") or ""

    return {
      global_statusline = true,

      keymaps = {
        pulls = {
          review = {
            explorer = {
              open_file = "o",
            },
            diff = {
              next_comment = "<C-j>",
              previous_comment = "<C-k>",
            },
          },
        },
      },
      pulls = {
        diff = {
          open_cmd = "CodeDiff", -- route PR diffs through codediff.nvim instead of AtlasDiff
        },
        providers = {
          ---@type AtlasGitHubConfig
          github = {
            cache_ttl = 300,
            views = {
              {
                name = "This repo",
                key = "1",
                layout = "plain",
                search = repo_filter .. "is:pr sort:updated-desc",
              },
              {
                name = "My PRs",
                key = "2",
                layout = "plain",
                search = "author:@me sort:updated-desc",
              },
              {
                name = "Review requested",
                key = "3",
                layout = "plain",
                search = "is:pr is:open review-requested:@me",
              },
            },
            bookmarks = {
              items = {
                ["Drafts"] = "is:pr is:draft author:@me",
                ["Recently merged"] = "is:pr is:merged author:@me sort:updated-desc",
              },
            },
          },
        },
      },

      issues = {
        max_results = 100,
        providers = {
          ---@type AtlasGitHubIssuesConfig
          github = {
            cache_ttl = 300,
            views = {
              {
                name = "This repo",
                key = "1",
                layout = "plain",
                search = repo_filter .. "is:open sort:updated-desc",
              },
              {
                name = "Assigned",
                key = "2",
                layout = "plain",
                search = "assignee:@me is:open",
              },
              {
                name = "Created",
                key = "3",
                layout = "plain",
                search = "author:@me is:open",
              },
            },
            bookmarks = {
              items = {
                ["Bugs"] = repo_filter .. "is:issue is:open label:bug",
              },
            },
          },
        },
      },
    }
  end,
}

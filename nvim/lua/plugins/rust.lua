return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rouge8/neotest-rust",
    },
    opts = function()
      local adapter = require("neotest-rust")

      local workspace_root
      local target_directory

      local function resolve_metadata()
        if workspace_root or vim.in_fast_event() then
          return
        end
        local result = vim
          .system({ "cargo", "metadata", "--no-deps", "--format-version=1" }, {
            cwd = vim.fn.getcwd(),
            text = true,
          })
          :wait()
        if result.code ~= 0 then
          return
        end
        local ok, metadata = pcall(vim.json.decode, result.stdout)
        if ok and metadata then
          workspace_root = metadata.workspace_root
          target_directory = metadata.target_directory
        end
      end

      resolve_metadata()

      function adapter.root(dir)
        resolve_metadata()
        return workspace_root or vim.fs.root(dir, "Cargo.toml")
      end

      function adapter.filter_dir(_, rel_path, root)
        return target_directory == nil or root .. "/" .. rel_path ~= target_directory
      end

      local treesitter = require("neotest.lib").treesitter
      local parse_positions = treesitter.parse_positions
      function treesitter.parse_positions(file_path, query, opts)
        if type(query) == "string" then
          query = query:gsub('"test" "rstest" "case"', '"test" "rstest" "case" "test_case"')
        end
        return parse_positions(file_path, query, opts)
      end

      local build_spec = adapter.build_spec
      function adapter.build_spec(args)
        local spec = build_spec(args)
        if spec == nil or type(spec.command) ~= "string" then
          return spec
        end
        local package = spec.command:match("package%(([^)]+)%)")
        if package then
          spec.command = spec.command:gsub("%-%-workspace", "--package " .. package, 1)
        end
        -- Match parametrized subtests (rstest/test_case generate `<fn>::<case>`)
        -- by broadening the exact `^<id>$` filter; plain tests have no children.
        spec.command = spec.command:gsub("%$/%)", "(::.*)?$/)", 1)
        return spec
      end

      return {
        adapters = { adapter },
        output = { open_on_run = true },
      }
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>to", function() require("neotest").output.open() end, desc = "Test output" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test summary" },
    },
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "rust", "ron", "toml" },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "codelldb" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          mason = false,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                targetDir = true,
                buildScripts = {
                  enable = true,
                },
              },
              check = {
                workspace = false,
              },
              diagnostics = {
                enable = true,
              },
              procMacro = {
                enable = true,
              },
              rustfmt = {
                overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
              },
              files = {
                exclude = {
                  ".direnv",
                  ".git",
                  ".jj",
                  ".github",
                  ".gitlab",
                  "bin",
                  "node_modules",
                  "target",
                  "venv",
                  ".venv",
                },
                watcher = "client",
              },
            },
          },
        },
      },
    },
  },
}

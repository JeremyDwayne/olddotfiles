  local nvim_lsp = require('lspconfig')
  local protocol = require'vim.lsp.protocol'

  -- Use an on_attach function to only map the following keys 
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- formatting
    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_command [[augroup Format]]
      vim.api.nvim_command [[autocmd! * <buffer>]]
      vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
      vim.api.nvim_command [[augroup END]]
    end

    --require'completion'.on_attach(client, bufnr)

    --protocol.SymbolKind = { }
    protocol.CompletionItemKind = {
      '', -- Text
      '', -- Method
      '', -- Function
      '', -- Constructor
      '', -- Field
      '', -- Variable
      '', -- Class
      'ﰮ', -- Interface
      '', -- Module
      '', -- Property
      '', -- Unit
      '', -- Value
      '', -- Enum
      '', -- Keyword
      '﬌', -- Snippet
      '', -- Color
      '', -- File
      '', -- Reference
      '', -- Folder
      '', -- EnumMember
      '', -- Constant
      '', -- Struct
      '', -- Event
      'ﬦ', -- Operator
      '', -- TypeParameter
    }
  end

  local servers = {'pyright', 'gopls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
  end

  nvim_lsp.intelephense.setup{
    on_attach=on_attach,
    settings = {
      diagnostic = {
        checkCurrentLine = true,
        errorSign = "✘",
        warningSign = "",
        infoSign = "",
      },
      intelephense = {
        telemetry = { enabled = false },
        completion = {
          triggerParameterHints = true,
          insertUseDeclaration = true,
          fullyQualifyGlobalConstantsAndFunctions = true,
        },
        trace = { server = "messages" },
        stubs = {
          "apache",
          "bcmath",
          "bz2",
          "calendar",
          "com_dotnet",
          "Core",
          "ctype",
          "curl",
          "date",
          "dba",
          "dom",
          "enchant",
          "exif",
          "FFI",
          "fileinfo",
          "filter",
          "fpm",
          "ftp",
          "gd",
          "gettext",
          "gmp",
          "hash",
          "iconv",
          "imap",
          "intl",
          "json",
          "ldap",
          "libxml",
          "mbstring",
          "meta",
          "mysqli",
          "oci8",
          "odbc",
          "openssl",
          "pcntl",
          "pcre",
          "PDO",
          "pdo_ibm",
          "pdo_mysql",
          "pdo_pgsql",
          "pdo_sqlite",
          "pgsql",
          "Phar",
          "posix",
          "pspell",
          "readline",
          "Reflection",
          "session",
          "shmop",
          "SimpleXML",
          "snmp",
          "soap",
          "sockets",
          "sodium",
          "SPL",
          "sqlite3",
          "standard",
          "superglobals",
          "sysvmsg",
          "sysvsem",
          "sysvshm",
          "tidy",
          "tokenizer",
          "xml",
          "xmlreader",
          "xmlrpc",
          "xmlwriter",
          "xsl",
          "Zend OPcache",
          "zip",
          "zlib",
          "wordpress"
        }
      }
    }
  }

  nvim_lsp.solargraph.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    cmd = { "solargraph", "stdio" },
    filetypes = { "ruby" },
    flags = { debounce_text_changes = 150, },
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          -- Disable virtual_text on file load
          -- Show with vim.lsp.diagnostic.show_line_diagnostics()
          virtual_text = false
        }
      ),
    },
  }

  nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }

  nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    --filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
    init_options = {
      linters = {
        eslint = {
          command = 'eslint_d',
          rootPatterns = { '.git' },
          debounce = 100,
          args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
          sourceName = 'eslint_d',
          parseJson = {
            errorsRoot = '[0].messages',
            line = 'line',
            column = 'column',
            endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[eslint] ${message} [${ruleId}]',
            security = 'severity'
          },
          securities = {
            [2] = 'error',
            [1] = 'warning'
          }
        },
      },
      filetypes = {
        javascript = 'eslint',
        javascriptreact = 'eslint',
        typescript = 'eslint',
        typescriptreact = 'eslint',
      },
      formatters = {
        eslint_d = {
          command = 'eslint_d',
          args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
          rootPatterns = { '.git' },
        },
        prettier = {
          command = 'prettier',
          args = { '--stdin-filepath', '%filename' }
        }
      },
      formatFiletypes = {
        css = 'prettier',
        javascript = 'eslint_d',
        javascriptreact = 'eslint_d',
        json = 'prettier',
        scss = 'prettier',
        less = 'prettier',
        typescript = 'eslint_d',
        typescriptreact = 'eslint_d',
        json = 'prettier',
        markdown = 'prettier',
      }
    }
  }

  -- icon
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      -- This sets the spacing and the prefix, obviously.
      virtual_text = {
        spacing = 4,
        prefix = ''
      }
    }
  )


  -- For installation instructions: https://www.chrisatmachine.com/Neovim/28-neovim-lua-development/ 
  -- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
  USER = vim.fn.expand('$USER')

  local sumneko_root_path = ""
  local sumneko_binary = ""

  local system_name
  if vim.fn.has("mac") == 1 then
    system_name = "macOS"
  elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
  else
    print("Unsupported system for sumneko")
  end

  sumneko_root_path = "/usr/local/share/lua-language-server"
  sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

  require'lspconfig'.sumneko_lua.setup {
      cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
      settings = {
          Lua = {
              runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT',
                  -- Setup your lua path
                  path = vim.split(package.path, ';')
              },
              diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = {'vim'}
              },
              workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
              }
          }
      }
  }

  require"lspconfig".efm.setup {
      init_options = {documentFormatting = true},
      filetypes = {"lua"},
      settings = {
          rootMarkers = {".git/"},
          languages = {
              lua = {
                  {
                      formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
                      formatStdin = true
                  }
              }
          }
      }
  }
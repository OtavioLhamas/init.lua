# 💤 LazyVim

<!--toc:start-->
- [TODO](#todo)
  - [Keymaps & Preconfigs](#keymaps-preconfigs)
  - [Language and framework setups](#language-and-framework-setups)
  - [Improvements to current plugins](#improvements-to-current-plugins)
- [Possible future plugins](#possible-future-plugins)
<!--toc:end-->

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## TODO

- [ ] Floating windows coloring
- [ ] Fix snacks image rendering

### Keymaps & Preconfigs

A few keymaps and distro premade configurations I should try to incorporate into my workflow:

| Keymap | Plugin | Description |
| --------------- | --------------- | --------------- |
| <leader>sr | grug-far | Search/replace |
| <leader>." | snacks | Scratch buffer |
| <leader>r | refactoring | Various refactoring utils |

### Language and framework setups

**Pre-configured language extras that I might need to tweak:**

- [ ] Ansible
  - [ ] [ansiblels](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ansiblels) config
  - [ ] [nvim-ansible](https://github.com/mfussenegger/nvim-ansible) keymaps
- [ ] Docker
  - [ ] [docker_compose_language_service](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#docker_compose_language_service) config
  - [ ] [dockerls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#dockerls) config
- [ ] Omnisharp/Dotnet
  - [ ] [omnisharp-extended-lsp](https://github.com/Hoffs/omnisharp-extended-lsp.nvim)
  - [ ] [omnisharp](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#omnisharp) config
  - [ ] compare with other alternatives like omnisharp-mono and [csharp_ls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#csharp_ls)
- [ ] JSON
  - [ ] [jsonls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls) config
- [ ] Markdown
  - [ ] [marksman](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman) config
  - [ ] [preview](https://github.com/iamcco/markdown-preview.nvim) config
  - [ ] [render](https://github.com/MeanderingProgrammer/render-markdown.nvim) config
- [ ] Rust
  - [ ] [crates](https://github.com/Saecki/crates.nvim) config
  - [ ] [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) config
  - [ ] [rust_analyzer](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#rust_analyzer) config
  - [ ] [bacon_ls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bacon_ls) config
- [ ] Sql
  - [ ] Explore [vim-dadbod](https://github.com/tpope/vim-dadbod) and its [ui](https://github.com/kristijanhusak/vim-dadbod-ui) and [completion](https://github.com/kristijanhusak/vim-dadbod-completion)
- [ ] Typescript
  - [ ] [vtsls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls) config
- [ ] Vue
  - [ ] [vue_ls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vue_ls) config and how it interacts with vtsls
- [ ] YAML
  - [ ] [SchemaStore](https://github.com/b0o/SchemaStore.nvim) config
  - [ ] [yamlls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls) config

### Improvements to current plugins

Learn and explore the configuration for the following installed plugins:

- [ ] [conform](https://github.com/stevearc/conform.nvim) code formatter
- [ ] [refactoring](https://github.com/ThePrimeagen/refactoring.nvim) commands
- [ ] Create type annotations with [neogen](https://github.com/danymat/neogen)
- [ ] [nvim-lint](https://github.com/mfussenegger/nvim-lint)
- [ ] [grug-far](https://github.com/MagicDuck/grug-far.nvim) search and replace

## Possible future plugins

Extra plugins I might want to install later as the necessity arises:

- [ ] Manage GitHub stuff with [Octo](https://github.com/pwntester/octo.nvim) and/or [blink-cmp-git](https://github.com/Kaiser-Yang/blink-cmp-git) for a more minimalist tool that just helps with completion using GitHub/GitLab as source
- [ ] [overseer](https://github.com/stevearc/overseer.nvim) for running tasks
- [ ] Run tests with [neotest](https://github.com/nvim-neotest/neotest) and its integration with overseer
- [ ] API REST requests with [kulala](https://github.com/mistweaverco/kulala.nvim)
- [ ] [edgy](https://github.com/folke/edgy.nvim) window layouts
- [ ] Something to help with writing, like [blink-cmp-dictionary](https://github.com/Kaiser-Yang/blink-cmp-dictionary) and/or [blink-cmp-spell](https://github.com/ribru17/blink-cmp-spell)
- [ ] Experiment with different AI plugins like:
  - [ ] [minuet](https://github.com/milanglacier/minuet-ai.nvim) for code completion
  - [ ] [ogpt](https://github.com/huynle/ogpt.nvim) as a chat-based code assistant
  - [ ] [codecompanion](https://github.com/olimorris/codecompanion.nvim) as a chat-based code assistant
  - [ ] [avante](https://github.com/yetone/avante.nvim) as a chat-based code assistant
- [ ] And other AI tools:
  - [ ] [aider](https://aider.chat) for pair programming inside the terminal
  - [ ] [VectorCode](https://github.com/Davidyz/VectorCode) to help with indexing the repository and providing context to the LLM
  - [ ] [OpenCode](https://opencode.ai)

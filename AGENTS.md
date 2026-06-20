# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**dircmd** is a bash utility that automatically executes scripts when you `cd` into or out of directories. It hooks into `PROMPT_COMMAND` to detect directory changes and sources entry/exit scripts from `.dircmd/` folders.

## Architecture

### Core File: `src/bash`
The entire runtime is a single bash script installed to `/etc/profile.d/dircmd.sh`. Key components:

- **`_dircmd_hook`** - The main hook called via PROMPT_COMMAND on every prompt. Detects directory changes by comparing SHA1 hashes of the current path against `DIRCMD_HASH`.

- **`_dircmd_source`** - Sources all files matching `.dircmd/*entry` or `.dircmd/*exit` in sorted order. Files like `00entry`, `01entry` execute in numeric order.

- **`_dircmd_save` / `_dircmd_restore`** - Helper functions for entry/exit scripts to save and restore environment variables (like PATH) scoped to a directory.

- **`DIRCMD_STORAGE`** - Associative array (regular array on macOS) storing saved variables keyed by directory hash.

### Directory Detection Logic

The hook handles three traversal patterns:
1. **Up** - Walking up the tree (e.g., `/a/b/c` → `/a`): runs exit scripts for each intermediate directory
2. **Down** - Walking into subdirectories: collects directories with `.dircmd/`, then runs entry scripts in order from shallowest to deepest
3. **Out** - Jumping between unrelated paths: runs exit scripts going up, then entry scripts going down the new path

### Installation: `bin/dircmd-installer`
Curl-based installer that places the bash script in `/etc/profile.d/` and creates example scripts in `~/.dircmd/`.

## Entry/Exit Script Conventions

Scripts in `.dircmd/` directories:
- Files ending in `entry` run when entering the directory
- Files ending in `exit` run when leaving
- Numeric prefixes control execution order: `00entry`, `01entry`, `99exit`
- Scripts are sourced (not executed), so they can modify the current shell environment

## Testing Changes

No test framework. Manual testing workflow:

```bash
# Enable debug output to trace hook behavior
export DIRCMD_DEBUG=1

# Reload after modifying src/bash
source src/bash

# Test by changing directories
cd /some/test/path
cd ..
cd -
```

## Examples Directory

The `examples/` folder contains copy-paste-ready `.dircmd` configurations:
- `virtualenv/` - Auto-activate/deactivate Python virtualenvs
- `path/` - Demonstrates `_dircmd_save`/`_dircmd_restore` for PATH management
- `prompt/` - Modify PS1 on entry/exit
- `django/` - Django project setup
- `helloworld/` - Basic demonstration

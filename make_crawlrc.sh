#!/bin/bash

command -v vim >/dev/null 2>&1 || { echo >&2 "Vim not found."; exit 1; }
cp CrawlSettings.rc crawlrc
vim -u NONE -S include_lua_files.vim crawlrc


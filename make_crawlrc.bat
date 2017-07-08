@ECHO OFF

where /Q vim
IF ERRORLEVEL 1 (
        ECHO Vim not found! Ensure it is installed and placed in your PATH.
        EXIT /B
)

copy /Y CrawlSettings.rc crawlrc
vim -u NONE -S include_lua_files.vim crawlrc


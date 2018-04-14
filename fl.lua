#!/usr/bin/lua
--conding:utf-8

package.path=package.path..";/usr/share/folder/?.lua;/usr/share/folder/luagy/?.lua;/usr/share/folder/luagy/Penlight/lua/?.lua;".."./luagy/?.lua;./luagy/Penlight/lua/?.lua"

Command=require("REPL.command")
Folder=require "folder"

f=Folder(".")
f:list()
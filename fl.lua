#/bin/bash
--conding:utf-8

package.path=package.path..";./luagy/?.lua"

Command=require("REPL.command")
Folder=require "folder"

f=Folder(".")
f:list()
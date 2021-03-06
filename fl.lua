#!/usr/bin/lua
--conding:utf-8
appdata=os.getenv("APPDATA") or ""
function addpath(path)
    package.path=package.path..";"..path
end

addpath(appdata.."\\folder\\luagy\\Penlight\\lua\\?.lua")
addpath("/usr/share/folder/luagy/Penlight/lua/?.lua;")    
addpath(               "./luagy/Penlight/lua/?.lua") 

addpath(appdata.."\\folder\\luagy\\?.lua;")
addpath("/usr/share/folder/luagy/?.lua")
addpath(                "./luagy/?.lua")
 
addpath(appdata.."\\folder\\?.lua")
addpath("/usr/share/folder/?.lua")  

Command=require("REPL.command")
Folder=require "folder"


f=Folder(".")
if(arg[1]~=nil) then 
    f:edit(arg[1])
    return 
end
f:list()
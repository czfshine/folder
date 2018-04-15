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


luaunit=require('luaunit.luaunit')
importall=require("require.importall")
importall("./test")

os.exit(luaunit.LuaUnit.run("-v"))
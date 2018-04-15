
package.path=package.path..";./luagy/?.lua"
Class=require("grammar.class")
require("Penlight.lua.pl.stringx").import()
--[[
    代表一个文件或者目录
]]
local File=Class(function ( self ,filepath)
    --public:
    self.filename=filepath or ""
    self.Descript=""
    self.attr={}
end)

--public:
function File:toString()
    return ((self.filename):ljust(20," "))..((not self.Descript=="") and self.Descript  or "Not has Descript")
end
--解析md的字符串
function File:initFromMDstr(str)
    self.parseSuccess=true
    self.filename=str
end

return File
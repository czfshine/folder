
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
    return ((self.filename):ljust(20," "))..(((self.Descript~="") and self.Descript ) or "Not has Descript")
end
--解析md的字符串
function File:initFromMDstr(str)
    if not str:startswith("*") then
        self.parseSuccess=false
        return
    end

    con=str:split('`')
    if(con:len()~= 3 ) then
        self.parseSuccess=false
        return
    end
    self.filename=con[2]
    c=con[3]

    endl=con[3]:lfind("|") and con[3]:lfind("|")-1 or #c
    self.Descript=c:sub(1,endl):strip()
    self.parseSuccess=true

    --todo:tag
end

function File:toMDstr()
    str="* "
    str=str.."`"..self.filename.."` "
    str=str..self.Descript
    return str
end
return File
--conding:utf-8
package.path=package.path..";./luagy/?.lua"
Class=require("grammar.class")

--[[
    代表一个文件或者目录
]]
local File=Class(function ( self ,filepath)
    --public:
    self.filename=filepath
    self.Descript=""
    self.attr={}
end)

--public:
function File:toString()

end
--解析md的字符串
function File:initFromMDstr(str)

end

return File
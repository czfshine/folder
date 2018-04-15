Class=require("./luagy/grammar/class")
stringx=require("pl.stringx")
if(string.startswith==nil) then
    stringx.import()
end
require("table.len")

MDwriter =Class(function (self,dirdata)
    --[[
        dirdata={ -- Is A MDFile Object
            path="",   --required
            dirname="",--required
            dirdesc="",
            dirusage="",

            dirs={File...},
            files={File...}
        }
    ]]

    assert(dirdata.path~=nil,"MDwriter.dirdata.path are required")
    assert(dirdata.dirname~=nil,"MDwriter.dirdata.dirname are required")
    self.path=dirdata.path
    self.data=dirdata
    self.dirs=dirdata.dirs or {}
    self.files=dirdata.files or {}
end)

local function newWriter(obj)
    local o=obj
    return function (...)
        o:write(...)
    end
end
local nl="\r\n"
local MDH1="================="..nl
local DIRM="----- -"..nl
local FILEM="----- --"..nl
local OPSM="----- ---"..nl
function MDwriter:writeToFile()
    outfile=io.open(self.path,"wb")
    assert(outfile,"Cant open file"..self.path)
    w=newWriter(outfile)

    w(self.data.dirname..nl);
    w(MDH1);
    _=(self.data.dirdesc and w(">"..self.data.dirdesc..nl))
    w(nl)
    _=(self.data.dirusage and w(self.data.dirusage))
    w(nl)
    if(table.len(self.dirs)>0 ) then 
        w("# 目录说明"..nl)
        w(DIRM)
        w(nl)
        for k,v in pairs(self.dirs) do 
            w(v:toMDstr())
            w(nl)
        end 
        w(nl)
    end
    if(table.len(self.files)>0 ) then 
        w("# 文件说明"..nl)
        w(FILEM)
        w(nl)
        for k,v in pairs(self.files) do 
            w(v:toMDstr())
            w(nl)
        end 
        w(nl)
    end
end
return MDwriter
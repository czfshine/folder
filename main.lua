--conding:utf-8
package.path=package.path..";./luagy/?.lua"
Class=require("grammar.class")
require("print.printtable")

require"lfs"
--------------------------------
--Config:
FOLDER_FILE_NAME="FOLDER.MD"


local File=Class(function(self)
    self.filecontant={}
    self.MainDesrc={}
    self:getContant();
    self.dirDesrc={}
    self.fileDesrc={}
    self.cur=3;
end)    
function File:getContant()
    local theFile=io.open(FOLDER_FILE_NAME,"r");
    if theFile==nil then 
        self.filecontant={};
    else
        for i in theFile:lines() do
            table.insert( self.filecontant, i );
        end
    end
end

function File:getMainName()
    return self.filecontant[1] --???????????
end
function File:addMainDesrc( )
    for i=self.cur,#(self.filecontant) do
        line=self.filecontant[i]
        if(line:sub(1,1)=='>') then
            table.insert(  self.MainDesrc, line:sub(2,-1))
            table.insert(  self.MainDesrc, "\n")
        else
            self.cur=i+1
            return
        end
    end
    
end

function File:gotoNext()
    for i=self.cur,#(self.filecontant) do
        line=self.filecontant[i]
        if(line:sub(1,1)=='*') then
            self.cur=i
            break
        end
    end
    --print(self.filecontant[self.cur])
    --print(self.filecontant[self.cur+1])

end

function File:getDirDesrc()
    for i=self.cur,#(self.filecontant) do
        line=self.filecontant[i]
        if(line:sub(1,1)=='*') then
            string.gsub(line,"`(.+)`(.+)",function (f,s )
               self.dirDesrc[f]=s
               print(f,s)
            end)
        else
            self.cur=i+1;
            break
        end
    end
end


function File:getFileDesrc()
    for i=self.cur,#(self.filecontant) do
        line=self.filecontant[i]
        if(line:sub(1,1)=='*') then
            string.gsub(line,"`(.+)`(.+)",function (f,s )
               self.fileDesrc[f]=s
               print(f,s)
            end)
        else
            self.cur=i+1;
            break
        end
    end
end
function File:parse()
    self:addMainDesrc()
    ptt(self.MainDesrc)
    self:gotoNext()
    self:getDirDesrc()
    self:gotoNext()
    self:getFileDesrc()
end

local sep = "/"
local upper = ".."

function File:ListFile()
    for file in lfs.dir('.') do
		if file ~= "." and file ~= ".." then
			local p = '.'..sep..file
			local attr = lfs.attributes (p)
			assert (type(attr) == "table")
			if attr.mode == "directory" then
                print(file)
            else --is file
                print(file)
			end
		end
	end
end

file=File();

print(file:getMainName());
file:parse();
file:ListFile()
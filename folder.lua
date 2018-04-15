--conding:utf-8
package.path=package.path..";./luagy/?.lua"
Class=require("grammar.class")
require"lfs"
File=require("file")

MDFile = require("mdfile")

local Folder=Class(function(self,path)
    
    self.path=path
    --目前目录下的文件
    self.files={}
    self.dirs={}

    --md文件里面有描述的文件
    self.dirsinfo={}
    self.filesinfo={}
    self:init(path)
end)

--public:

--初始化对象
function Folder:init(path)
    
end

--===========功能==============

--模仿ls命令
function Folder:list(arg)
    self:getFiles()
    self:readMDfile()
    for k,v in pairs(self.dirs) do
        print(v:toString())
    end
    for k,v in pairs(self.files) do
        print(v:toString())
    end
end




--增加注释
function Folder:addDescript(filename,desc)

end

--增加属性
function Folder:addAtrr(filename,attr)

end

--private
--载入目前目录的所有文件和目录
local sep = "/"
local upper = ".."
function Folder:getFiles()

    for file in lfs.dir(self.path) do

        if file ~= "." and file ~= ".." then

            local p = self.path..sep..file
            local attr = lfs.attributes (p)
            if attr.mode == "directory" then
                self.dirs[file]=File(file)
            else --is file
                self.files[file]=File(file)
            end
		end
    end
end

--读入MD描述文件
function Folder:readMDfile()
    mdf=MDFile(self.path.."/FOLDER.MD")
    if(mdf.isexist==false) then
        return 
    end 
    for k,l in pairs(mdf.dirline) do 
        d=File()
        d:initFromMDstr(l)
        if(d.parseSuccess) then
            self.dirsinfo[d.filename]=d
        end
    end

    for k,l in pairs(mdf.fileline) do 
        d=File()
        d:initFromMDstr(l)
        if(d.parseSuccess) then
            self.filesinfo[d.filename]=d
        end
    end
end

--写入MD描述文件
function Folder:wirteMDfile()

end
return Folder
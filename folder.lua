--conding:utf-8
package.path=package.path..";./luagy/?.lua"
Class=require("grammar.class")
path=require "pl.path"
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

--- 初始化对象
-- @param path
--
function Folder:init(path)
    
end

--===========功能==============

--- 模仿ls命令
 -- @param arg
 --
function Folder:list(arg)
    self:getFiles()
    self:readMDfile()
    for k,v in pairs(self.dirs) do
        if(self.dirsinfo[v.filename]) then 
            print(self.dirsinfo[v.filename]:toString())
        else
            print(v:toString())
        end
    end
    for k,v in pairs(self.files) do
        if(self.filesinfo[v.filename]) then 
            print(self.filesinfo[v.filename]:toString())
        else
            print(v:toString())
        end
    end
end

--- edit 编辑命令
-- * 文件不存在                  -1
-- * 文件存在
--   * MD文件不存在            000
--       * 是否增加父文件夹描述  0_0
--   * MD文件存在              100
--       * 信息存在            010
--       * 信息不存在          000
-- @param filepath
---
--[[                             or

]]
function Folder:edit(filepath)

    if(not path.exists(filepath)) then
        print("file:`"..filepath.."` don't exists")
        return -1
    end

    r=self:readMDfile()

    if(r==false) then 
        --MD文件不存在
        mdf=MDFile(self.path.."/FOLDER.MD")

        io.write("Do you want add this folder decscript to FOLDER.MD?[Y/n]")

        r=io.read("*l")
        if(r=="" or r=="Y" or r=="y" or r=="yes") then
            print("Please input folder decscript:")
            io.write(">")
            dec=io.read("*l")
        end
       return 
    end

    infos=self.dirsinfo
    if(path.isfile(filepath)) then 
        infos=self.filesinfo
    end
    if(infos[filepath]) then
        --信息存在
        return 
    end
    --信息不存在


end


--===========输入输出=============

function Folder:inputDirDesc()

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
        return false
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
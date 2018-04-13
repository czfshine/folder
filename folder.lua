--conding:utf-8
package.path=package.path..";./luagy/?.lua"
Class=require("grammar.class")
File=require("file")

Folder=Class(function(self,path)
    
    self.path=path
    self.files={}
    self.dirs={}

    self:init(path)
end)

--public:

--初始化对象
function Folder:init(path)
    self:getFiles()

end

--模仿ls命令
function Folder:list(arg)
    
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
            
            local p = '.'..sep..file
            local attr = lfs.attributes (p)
            
            if attr.mode == "directory" then
                self.dirs=File(file)
            else --is file
                self.files=File(file)
            end
		end
    end
end

--读入MD描述文件
function Folder:readMDfile()

end

--写入MD描述文件
function Folder:wirteMDfile()

end

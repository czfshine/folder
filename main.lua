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

    
    self.dirs={}
    self.files={}
    self.dirsid={}
    self.filesid={}


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
        theFile:close()
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
function newfn( self,fn,n )
    local dirss=self.dirDesrc
    local filess=self.fileDesrc

    return function( k,v )
        if(dirss[k])then
           if(not n) then fn(v.id,k,dirss[k]) end
        else
            if(filess[k]) then
                if(not n) then fn(v.id,k,filess[k]) end
            else
                fn(v.id,k,"[hasn't desrc]")
            end
        end
    end
end
function File:ListFile()
    i=0
    j=0;
    for file in lfs.dir('.') do
		if file ~= "." and file ~= ".." then
			local p = '.'..sep..file
			local attr = lfs.attributes (p)
			assert (type(attr) == "table")
            if attr.mode == "directory" then
                self.dirs[file]={id=i,name=file} ;
                self.dirsid[i]=file;
                i=i+1
            else --is file
                self.files[file]={id=j,name=file} ;
                self.filesid[j]=file;
                j=j+1
            end
		end
    end
    
end
function File:List(n)
    pt(self.dirs,newfn(self,print,n))
    pt(self.files,newfn(self,print,n))
end
function File:ToFile(filename )
    filename=filename or FOLDER_FILE_NAME;
    local file=io.open(filename,"w")
    print(file)
    file:write(self:getMainName())

    file:write("\n=====================\n>")
    file:write(table.concat(self.MainDesrc,"\n>"))
    file:write("\n目录说明\n----------------\n>Directories Description\n\n")

    for k,v in pairs(self.dirDesrc) do
        file:write("* `"..k.."`  "..v.."\n")
    end
    file:write("\n\n")

    file:write("文件说明\n----------------\n>Files Description Description\n\n")
    for k,v in pairs(self.fileDesrc) do
        file:write("* `"..k.."`  "..v.."\n")
    end
    file:close()
end
REPL=require "repl.repl"

file=File();
print(file:getMainName());
file:parse();
file:ListFile()
file:ToFile("test.md")


config={
    list={
      long={"*print","+dev","?none"},
      short={
        p={"pages"},
        r={}
      },
      other={
        "filename..."
      },
      fn=function (t )
        if(t.other[1]=="n") then 
            file:List(true)
        else
            file:List()
        end

      end
    },
    q={
        fn=function ( ... )
            os.exit(0)
        end
    },
    e={
        fn=function ( t )
            if(t.other[1]) then
                ids=t.other[1]
                if(ids:sub(1,1)=='f') then
                    filename=file.filesid[tonumber(ids:sub(2,-1))]
                    if(not filename) then 
                        print("找不到对应的文件")
                    else
                        print("修改"..filename.."的描述")
                        str=io.read("*l")
                        file.fileDesrc[filename]=str
                        file:ToFile("test.md")
                    end
                else
                end
            end

        end
    }
}

r=REPL(config)
r:run()
--conding:utf-8
package.path=package.path..";./luagy/?.lua"
Class=require("grammar.class")
require("print.printtable")

require"lfs"
--------------------------------
--Config:
FOLDER_FILE_NAME="FOLDER.MD"


local MDFile=Class(function(self)
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


function MDFile:getMainName()
    return self.filecontant[1] --???????????
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
function MDFile:ListMDFile()
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
function MDFile:List(n)
    pt(self.dirs,newfn(self,print,n))
    pt(self.files,newfn(self,print,n))
end
function MDFile:ToMDFile(filename )
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

    file:write("文件说明\n----------------\n>MDFiles Description Description\n\n")
    for k,v in pairs(self.fileDesrc) do
        file:write("* `"..k.."`  "..v.."\n")
    end
    file:close()
end
REPL=require "repl.repl"

file=MDFile();
print(file:getMainName());
file:parse();
file:ListMDFile()
file:ToMDFile("test.md")


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
                        file:ToMDFile("test.md")
                    end
                else
                end
            end

        end
    }
}

r=REPL(config)
r:run()

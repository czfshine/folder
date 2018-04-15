Class=require("./luagy/grammar/class")
stringx=require("pl.stringx")
stringx.import()
local MDFile=Class(function(self,path)
    self.path=path
    self.isexist=true
    self:init()
end)

function MDFile:init()
    infile=io.open(self.path,"rb")
    if(infile==nil) then 
        self.isexist=false
        return 0
    end

    self.filecontant={};
    for l in infile:lines() do
        l=l:gsub("\n","")
        l=l:gsub("\r","")
        table.insert( self.filecontant, l );
    end
    infile:close()
    self.filelen=#self.filecontant
    self.cur=1
    self:getHead()
    self:getDirInfo()
    --[[
    self:getDirs()
    self:getFiles()
    self:getOps()
    ]]
end

function MDFile:getHead()
    firstline=self.filecontant[1]
    if(firstline:startswith("---")) then
        self.hasHead=true
    else   
        self.hasHead=false
        return 
    end

    --todo:完善头部信息解析，目前用不到

    --skip head
    len=#self.filecontant
    self.cur=self.cur+1
    while(self.cur<=len)do
        if(self.filecontant[self.cur]:startswith("---"))then
            self.cur=self.cur+1
            self.headend=self.cur-1
            return 
        end
        self.cur=self.cur+1
    end
    self:parseError(cur,"解析头部错误，找不到结束标记")
end

function MDFile:getcurline()
    return self.filecontant[self.cur];
end
function MDFile:inc()
    self.cur=self.cur+1
end
function MDFile:getDirInfo()
    self.dirname=self:getcurline()
    self:inc()
    self:inc()--skip ==========
    self.dirdesc=self:getcurline()
    self:inc()
    m=0
    dm=self:findDirMark()
    if(dm==0)then
        fm=self:findFileMark()
        if(fm==0)then
            om=self:findOpsMark()
            if(om==0) then
                m=self.filelen
            else
                m=om-2
            end
        else
            m=fm-2
        end
    else
        m=dm-2
    end
    --todo 
    --skip dirusage
    self.dirusageend=m
    self.cur=m+1
end

function MDFile:findline(start,con)
    ends=self.filelen
    cur=start
    while(cur<=ends)do
        res=self.filecontant[cur]==con 
        if(res==true) then
            return cur
        end
        cur=cur+1
    end
    return -1
end

function MDFile:findDirMark()
    res=self:findline(self.cur,"----- -")
    
    if(res>0) then return res end
    return 0
end


function MDFile:findFileMark()
    res=self:findline(self.cur,"----- --")
    if(res>0) then return res end
    return 0
end

function MDFile:findOpsMark()
    res=self:findline(self.cur,"----- ---")
    if(res>0) then return res end
    return 0
end


function MDFile:parseError(line,msg)
    self.error=true
    print("[ERROR]: "..self.path.."["..line.."] : "..msg)
end
return MDFile
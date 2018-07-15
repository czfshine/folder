Class=require("./luagy/grammar/class")
stringx=require("pl.stringx")
if(string.startswith==nil) then
    stringx.import()
end
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
    self:findDirMark()
    self:findFileMark()
    self:findOpsMark()
    self:getDirInfo()
    self:getAllDirLine()
    self:getAllFileLine()
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
    if(self.hasdirmark) then
        m=self.dirmark-2
    elseif(self.hasfilemark) then
        m=self.filemark-2
    elseif(self.hasopsmark) then
        m=self.opsmark-2
    else
        m=self.filelen
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
    if(res>0) then 
        self.hasdirmark=true
        self.dirmark=res
        return res 
    end
    return 0
end
function MDFile:findFileMark()
    res=self:findline(self.cur,"----- --")
    if(res>0) then 
        self.hasfilemark=true
        self.filemark=res
        return res 
    end
    return 0
end
function MDFile:findOpsMark()
    res=self:findline(self.cur,"----- ---")
    if(res>0) then 
        self.hasopsmark=true
        self.opsmark=res
        return res 
    end
    return 0
end

function MDFile:getAllDirLine()
    self.dirline={}
    if(self.hasdirmark ~= true) then 
        return false
    end
    endl= (self.hasfilemark and self.filemark-2) or
            (self.hasopsmark and self.opsmark-2) or
            self.filelen
    for i=self.dirmark ,endl do
        if(self.filecontant[i]:startswith("*") )then 
            table.insert(self.dirline,self.filecontant[i])
        end
    end
end

function MDFile:getAllFileLine()
    self.fileline={}
    if(self.hasfilemark ~= true) then 
        return false
    end
    endl= (self.hasopsmark and self.opsmark-2) or
            self.filelen
    for i=self.filemark ,endl do
        if(self.filecontant[i]:startswith("*") )then 
            table.insert(self.fileline,self.filecontant[i])
        end
    end
end

function MDFile:parseError(line,msg)
    self.error=true
    print("[ERROR]: "..self.path.."["..line.."] : "..msg)
end
return MDFile
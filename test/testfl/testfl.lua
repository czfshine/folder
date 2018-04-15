Folder=require "folder"
lu = require('luaunit.luaunit')
require("table.len")
TestFL= {}

function TestFL:testList()
    f=Folder("test/testfl/")
    f:list()
    lu.assertEquals(table.len(f.dirsinfo),2)
    lu.assertEquals(table.len(f.dirsinfo),2)
end
MDFile=require "mdfile"
lu = require('luaunit.luaunit')
TestMDFile= {}

function TestMDFile:testOpen()
    MDF=MDFile("./FOLDER.MD")
end

function TestMDFile:testHead()
    HMDF=MDFile("./test/testMDFile/hasHead.md")
    lu.assertEquals(HMDF.hasHead,true)
    lu.assertEquals(HMDF.headend,5)

    MDF=MDFile("./test/testMDFile/hasn_tHead.md")
    lu.assertEquals(MDF.hasHead,false)

end

function TestMDFile:testFull()
    MDF=MDFile("./test/testMDFile/full.md")
    lu.assertEquals(MDF.hasHead,true)
    lu.assertEquals(MDF.headend,5)
    lu.assertEquals(MDF.dirname,"测试文件夹")
    lu.assertEquals(MDF.dirdesc,">测试文件测试文件测试文件测试文件测试文件")
    lu.assertEquals(MDF.dirusageend,20)
end
lu = require('luaunit.luaunit')
File=require "file"

TestFile={}

function TestFile:testline()
    f=File()
    f:initFromMDstr("* `filename` abcd bdj jdfhjs |rcm")
    lu.assertEquals(f.filename,"filename")
    lu.assertEquals(f.Descript,"abcd bdj jdfhjs")


    f:initFromMDstr("* `filename` abcd bdj jdfhjs   ")
    lu.assertEquals(f.filename,"filename")
    lu.assertEquals(f.Descript,"abcd bdj jdfhjs")

    f:initFromMDstr("* `filename`    ")
    lu.assertEquals(f.filename,"filename")
    lu.assertEquals(f.Descript,"")
    


end

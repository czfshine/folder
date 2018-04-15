lu = require('luaunit.luaunit')

MDWriter=require("mdwriter")

TestMDWriter={}

function TestMDWriter:testWriteToFile()
    f1=File()
    f1:initFromMDstr("* `filename` abcd bdj jdfhjs |rcm")
    f2=File()
    f2:initFromMDstr("* `filename` abcd bdj jdfhjs |rcm")
    f3=File()
    f3:initFromMDstr("* `filename` abcd bdj jdfhjs |rcm")

    d1=File()
    d1:initFromMDstr("* `filename` abcd bdj jdfhjs |rcm")
    d2=File()
    d2:initFromMDstr("* `filename` abcd bdj jdfhjs |rcm")
    d3=File()
    d3:initFromMDstr("* `filename` abcd bdj jdfhjs |rcm")

    dirdata={ -- Is A MDFile Object
        path="./out/testout.md",   --required
        dirname="testdirname",--required
        dirdesc="testrddd",
        dirusage="ffffdffd ",

        dirs={d1,d2,d3},
        files={f1,f2,f3}
    }
    w=MDWriter(dirdata)
    w:writeToFile()   

end
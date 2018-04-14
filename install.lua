--conding=utf8
os.execute("cd")
function run (cmd,desc)
    a=os.execute(cmd)
    print("[INFO] running "..cmd)
    if a == 0 then 
    else
        print("[ERROR]: run `"..cmd.."` error")
        print(desc or "")
    end 
end
function sudo(cmd,desc)
    if not os.iswindow then 
        cmd="sudo "..cmd
    end
    run(cmd,desc)
end

print("[INFO] clone submodule ...")

run("git submodule init")
run("git submodule update")
run("cd luagy && git submodule init")
run("cd luagy && git submodule update")

--OK,can use luagy
package.path=package.path..";/usr/share/folder/?.lua;/usr/share/folder/luagy/?.lua;/usr/share/folder/luagy/Penlight/lua/?.lua;".."./luagy/?.lua;./luagy/Penlight/lua/?.lua"
require("system.osinfo")
print("[INFO] installing ...")
if os.islinux then 
    run("chmod 777 fl.sh")
end

if os.iswindow then 
    installdir="%APPDATA%\\folder\\"
    run("xcopy  /E /Q /Y  .  "..installdir)
else
    installdir="/usr/share/folder"
    sudo("cp -R . "..installdir)
end

if os.iswindow then 
    if arg[1]~="ci" then 
    print("请输入一个window 环境变量PATH内的文件夹")
    bindir=io.read("*l").."\\fl.bat"
    else
        bindir="./bin/fl.bat"
    end
    run("copy fl.bat ".."\""..bindir .."\"")
else
    sudo("ln -s /usr/share/folder/fl.sh /usr/bin/fl")
end

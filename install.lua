os.execute("chmod 777 fl.lua")
os.execute("git submodule init")
os.execute("git submodule update")
os.execute("cd luagy && git submodule init")
os.execute("cd luagy && git submodule update")
os.execute("sudo cp -R . /usr/share/folder")
os.execute("sudo ln -s /usr/share/folder/fl.lua /usr/bin/fl")


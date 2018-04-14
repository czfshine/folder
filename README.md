# folder
一个工具，对文件夹内的每个文件/目录进行描述(备注）

会在每个（需要注释的）文件夹下生成一个名为`FOLDER.MD`的描述文件，文件示例看本项目的[FOLDER.MD](.\FOLDER.MD).


# Usage
> 预期设计效果，还没成功

* 安装`fl.sh`或`fl.bat` 到PATH里，即可在任意地方使用

* 在文件夹内不带参数运行`fl` 命令，将类似ll的输出效果，但是每个文件还后面都会接上你编写的注释
* 运行`fl [filename]`将会显示一个**可编辑**的行，默认内容为上一次的注释，可修改，回车写入`FOLDER.MD` 文件

* 其他工具查看`fl --help`
# install
> 理论上适用在`luaFileSystem`（用来列文件）能被载入的系统都可以使用（其他都是纯lua）,[todo]抽象文件系统接口.

* 安装lua5.1 与其他的lua库
* clone
* `git submodule init`
* `git submodule update`
* 运行`lua install.lua PATH`将fl脚本写入到命令文件夹
* 完事 
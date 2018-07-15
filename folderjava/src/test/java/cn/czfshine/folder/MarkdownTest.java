package cn.czfshine.folder;

import com.vladsch.flexmark.ast.*;
import com.vladsch.flexmark.parser.Parser;

import static org.junit.Assert.*;

/**
 * @author:czfshine
 * @date:2018/5/8 13:32
 */

public class MarkdownTest {


    @org.junit.Test
    public void main(){

        Parser parser = Parser.builder().build();
        parser.withOptions()
        Node document = parser.parse("文件描述-项目\n" +
                "==================\n" +
                "> 用来给目录增加描述的\n" +
                "\n" +
                "目录说明\n" +
                "----- -\n" +
                ">Directories Description\n" +
                "\n" +
                "* `.vscode` vscode 配置文件\n" +
                "\n" +
                "文件说明\n" +
                "----- --\n" +
                ">Files Description\n" +
                "\n" +
                "* `main.lua`  主程序\n" +
                "* `README.MD` 描述文件\n");
        for(Node n:document.getChildren()){
            System.out.println(n.toString());
        }
       // System.out.println();
    }
}
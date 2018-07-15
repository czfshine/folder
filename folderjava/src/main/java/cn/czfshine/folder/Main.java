package cn.czfshine.folder;

import org.apache.commons.cli.*;

/**
 * @author:czfshine
 * @date:2018/5/7 21:24
 */

public class Main {

    public static void main(String[] args){
        // create Options object
        Options options = new Options();
        // add t option
        options.addOption("h", false, "show help info");
        CommandLineParser parser = new DefaultParser();
        try {
            CommandLine cmd = parser.parse( options, args);

            if(cmd.hasOption("h")){
                HelpFormatter formatter = new HelpFormatter();
                formatter.printHelp( "folder -[h] [path]", options );
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}


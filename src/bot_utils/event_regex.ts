import constants = require('../.constants');
import regexps = require('./reg_exps');
import * as commandFile from './commands';

export class EventRegex {

  readonly commandsRegex: regexps.RegExps;
  readonly commandsRegexNoName: regexps.RegExps;

  constructor() {
    // var commands = ['^[/|.]start', '^[/|.](mirrorTar|mt)', '^[/|.](mirror|m)', '^[/|.](mirrorStatus|ms)', '^[/|.](list|l)', '^[/|.](getFolder|gf)', '^[/|.](cancelMirror|cm)', '^[/|.](cancelAll|ca)', '^[/|.](stats)', '^[/|.](getLink|gl)', '^[/|.](clone|c)', '^[/|.]id', '^[/|.]mf', '^[/|.](tar|t)', '^[/|.](unzipMirror|um)', '^[/|.](count|cnt)', '^[/|.](help|h)', '^[/|.](authorize|a)', '^[/|.](unauthorize|ua)'];

    var commands: string[] = [];
    var commandAfter: string[] = [];
    var commandsNoName: string[] = [];
    // var commandAfter = ['$', '($| (.+))', '($| (.+))', '$', ' (.+)', '$', '($| (.+))', '$', '$', ' (.+)', ' (.+)', '$', '$', ' (.+)', ' (.+)', ' (.+)', '$', '$', '$'];

    Object.entries(commandFile.commands).forEach(
      ([key, command]) => {
        commands.push(`^[/|.](${command})`);
        commandAfter.push(commandFile.commandsAfter[key]);
      }
    );

    if (constants.COMMANDS_USE_BOT_NAME && constants.COMMANDS_USE_BOT_NAME.ENABLED) {
      commands.forEach((command, i) => {
        if (command === '^[/|.](list|l)') {
          // In case of more than one of these bots in the same group, we want all of them to respond to /list
          commands[i] = command + commandAfter[i];
        } else {
          commands[i] = command + constants.COMMANDS_USE_BOT_NAME.NAME + commandAfter[i];
        }
        commandsNoName.push(this.getNamelessCommand(command, commandAfter[i]));
      });
    } else {
      commands.forEach((command, i) => {
        commands[i] = command + commandAfter[i];
        commandsNoName.push(this.getNamelessCommand(command, commandAfter[i]));
      });
    }

    this.commandsRegex = new regexps.RegExps(commands);
    this.commandsRegexNoName = new regexps.RegExps(commandsNoName);
  }

  private getNamelessCommand(command: string, after: string): string {
    return `(${command}|${command}@[\\S]+)${after}`;
  }
}
{//-------------------------------------------------------------------------}
{/*                                                                         }
{Copyright (C) 1990, 2009 - Apogee Software, Ltd.                           }
{                                                                           }
{This file is part of Supernova.  Supernova is free software; you can       }
{redistribute it and/or modify it under the terms of the GNU General Public }
{License as published by the Free Software Foundation; either version 2     }
{of the License, or (at your option) any later version.                     }
{                                                                           }
{This program is distributed in the hope that it will be useful,            }
{but WITHOUT ANY WARRANTY; without even the implied warranty of             }
{MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                       }
{                                                                           }
{See the GNU General Public License for more details.                       }
{                                                                           }
{You should have received a copy of the GNU General Public License          }
{along with this program; if not, write to the Free Software                }
{Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.}
{                                                                           }
{Original Source: 1990 Scott Miller                                         }
{Prepared for public release: 03/19/09 - Joe Siegler, Apogee Software, Ltd. }
{*/                                                                         }
{//-------------------------------------------------------------------------}
program
  line_Responce_Writer;

           {This program WRITES and READS from the text file:
                      'Line', 80 letters (Max),
               {This program has the line edit feature!}
const
  Max = 80;

type
  DescriptionLength = string[Max];
  OneChar = string[1];

var
  Line   : file of descriptionlength;
  Position,Counter,Start,Stop : integer;
  Text   : descriptionlength;
  Answer : char;
  Letter : onechar;
  List   : boolean;

procedure Diskwrite(text: Descriptionlength; pointer: integer);
  begin
    seek(Line,pointer);
    WRITE(Line,text);
    writeln('line responce ',pointer,
            ' is written!  Size = ',filesize(Line));
    close(Line);
  end; {End of Diskwrite.}

procedure Diskread(start,stop: integer);
var
counter : integer;
text    : descriptionlength;
  begin
   assign(Line,'Line');
   reset(Line);
   seek(Line,start);
    for counter:= start to stop do
      begin
        highvideo;
        READ(Line,text);
        if List then
          writeln(lst,counter,text)
        else
          begin
            writeln('Here is line responce # ',counter);
            lowvideo;
            writeln(text);
            highvideo;
          end;
      end;
    close(Line);
    write('The file contains ',filesize(Line),' line responces.');
  end;  {End of Diskread.}

procedure Beep;
begin
 if (length(text)=70) then write(^g);
end;

BEGIN
repeat          {Main loop.}
  text:='';

writeln;
writeln('Do you want to R)ead or W)rite?');
read(kbd,answer);
if upcase(answer) <> 'R' then       {Write to 'line' files.}
    begin
      writeln;
      assign(Line,'Line');
      writeln('Now RESETing line files.');
            RESET(Line);
      writeln;
      writeln('Input a string not more than ',Max,' characters.',
              '  ''\''-Ends string.');
      lowvideo;
        repeat
          read(trm,letter);
          if letter = ^h then
            begin
              write(^h,' ',^h);
              delete(text,length(text),2);
            end;
          beep;
          if (letter <> '\') and (letter <> ^h) then text:=text+letter
        until (length(text)=Max) or (letter='\');
        writeln;
        if letter = '\' then
          begin
            highvideo;
            writeln('Total of ',length(text),' characters.');
          end
        else
          begin
           highvideo
          end;
      writeln('Now WRITING string to disk.');
      writeln('  At what position?  (Next open is # ',filesize(Line),')');
      readln(position);
      Diskwrite(text,position);
    end
else                      {Read from 'Rooms'.}
  begin
    writeln;
    writeln('To the S)creen or P)rinter?');
    read(kbd,answer);
    if(upcase(answer)='P')then List:=True else List:=False;
    assign(Line,'Line');
    reset(Line);
    writeln('Filesize = ',filesize(Line),
            '  (From 0 to ',filesize(Line)-1,')');
    close(Line);
    writeln('Enter starting position:');
    readln(start);
    if(start > filesize(line)-7)then stop:=(filesize(line)-1) else
      begin
        writeln('Enter final position:');
        readln(stop);
      end;
    Diskread(start,stop);
  end;  {End of else clause.}
writeln;writeln('Another line responce?  Y)es or N)o');
read(kbd,answer);
until upcase(answer) = 'N';     {End of Main loop.}
writeln; writeln(^g,'You are now out of the program.')
END.



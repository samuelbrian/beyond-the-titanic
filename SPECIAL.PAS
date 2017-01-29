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
  Special_Responce_Writer;

         {This program WRITES and READS from the two text files:
    'special1' and 'special2'.  If a description exceeds 240 letters (Max),
       then the file 'special2' is used.  Otherwise 'special2' = ''.}
               {This program has the line edit feature!}
const
  Max = 240;

type
  DescriptionLength = string[Max];
  OneChar = string[1];

var
  Special1, Special2 : file of descriptionlength;
  Position,Counter,Start,Stop : integer;
  Text1, Text2 : descriptionlength;
  Answer : char;
  Letter : onechar;
  List   : boolean;

procedure Diskwrite(text1,text2: Descriptionlength; pointer: integer);
  begin
    seek(special1,pointer); seek(special2,pointer);
    WRITE(special1,text1); WRITE(special2,text2);
    writeln('Special responce ',pointer,
            ' is written!  Size = ',filesize(special1));
    close(special1); close(special2);
  end; {End of Diskwrite.}

procedure Diskread(start,stop: integer);
var
counter : integer;
text1, text2 : descriptionlength;
  begin
   assign(special1,'special1'); assign(special2,'special2');
   reset(special1); reset(special2);
   seek(special1,start); seek(special2,start);
    for counter:= start to stop do
      begin
        highvideo;
        READ(special1,text1); READ(special2,text2);
        if list then
          begin
            writeln(lst,'Special # ',counter);
            writeln(lst,text1,text2);
          end
        else
          begin
            writeln('Here is special responce # ',counter);
            lowvideo;
            writeln(text1,text2);
            highvideo;
          end;
      end;
    close(special1); close(special2);
    write('The file contains ',filesize(special1),' special responces.');
  end;  {End of Diskread.}

procedure Beep;
begin
 if(length(text1)in[70,150,230])or(length(text2)in[70,150,230])then write(^g);
end;

BEGIN
repeat          {Main loop.}
  text1:='';
  text2:='';

writeln;
writeln('Do you want to R)ead or W)rite?');
read(kbd,answer);
if upcase(answer) <> 'R' then       {Write to 'Special' files.}
    begin
      writeln;writeln;
      assign(special1,'special1'); assign(special2,'special2');
      writeln('Now RESETing Special files.');
            RESET(special1); RESET(special2);
      writeln;
      writeln('Input a string not more than ',2*Max,' characters.',
              '  ''\''-Ends string.');
      lowvideo;
        repeat
          read(trm,letter);
          if letter = ^h then
            begin
              write(^h,' ',^h);
              delete(text1,length(text1),2);
            end;
          beep;
          if (letter <> '\') and (letter <> ^h) then text1:=text1+letter
        until (length(text1)=Max) or (letter='\');
        writeln;
        if letter = '\' then
          begin
            highvideo;
            writeln('Total of ',length(text1),' characters.');
            text2:='';
          end
        else
          begin
            writeln;
            highvideo;
            writeln('String #1 is full!  Now writing to string #2.',^g);
            lowvideo;
              repeat
                read(trm,letter);
                if letter = ^h then
                  begin
                    write(^h,' ',^h);
                    delete(text2,length(text2),2);
                  end;
                beep;
                if (letter <> '\') and (letter <> ^h) then text2:=text2+letter
              until (length(text2)=Max) or (letter='\');
            writeln; highvideo;
            writeln('Total description length = ',
                     length(text1)+length(text2),' characters.');
          end;
      writeln('Now WRITING string to disk.');
      writeln('  At what position?  (Next open is # ',filesize(special1),')');
      readln(position);
      Diskwrite(text1,text2,position);
    end
else                      {Read from 'Rooms'.}
  begin
    writeln;writeln;
    writeln('To the S)creen or the P)rinter?');
    read(kbd,answer);
    if(upcase(answer)='P')then List:=True else List:=False;
    assign(special1,'special1');
    reset(special1);
    writeln('Filesize = ',filesize(special1),
            '  (From 0 to ',filesize(special1)-1,')');
    close(special1);
    writeln('Enter starting position:');
    readln(start);
    if(start > filesize(special1)-5)then stop:=(filesize(special1)-1) else
      begin
        writeln('Enter final position:');
        readln(stop);
      end;
    Diskread(start,stop);
  end;  {End of else clause.}
writeln;writeln('Another special responce?  Y)es or N)o');
read(kbd,answer);
until upcase(answer) = 'N';     {End of Main loop.}
writeln; writeln(^g,'You are now out of the program.')
END.



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
{*****************************************************************************}
{*                                 ADPARSER                                  *}
{*                             by Scott Miller                               *}
{*      This include file to Adgame contains the word parser commands.       *}
{*                          Copyright 1984 Pending                           *}
{*****************************************************************************}


procedure  RR(RoomNum : integer);
    begin FlagSA:='s';
      seek(rooms1,RoomNum);seek(rooms2,RoomNum);
      READ(rooms1,text1);READ(rooms2,text2);
      writeln(text1,text2);
    end; {of RoomRead}


procedure  RS(RoomNum : integer);
   begin
     FlagSA:='s';
     seek(Special1,RoomNum);seek(Special2,RoomNum);
     READ(Special1,text1);READ(Special2,text2);
     writeln(text1,text2);
   end;  {of SpecialRead}

procedure RL(RoomNum : integer);
   var text1 : str80;
   begin
     FlagSA:='s';
     seek(Line1,RoomNum);
     READ(Line1,text1);
     writeln(text1);
   end;  {of LineRead}


procedure Format(var input : Str80);
 procedure D(A:str14; B: Byte);
  begin while pos(A,input)<>0 do delete(input,pos(A,input),B) end;
   begin input:=input+' '; insert(' ',input,1);
    d(' of ',3); d(' go ',3); d('''',1); d('"',1); d(',',1);
    d(' a ',2); d('?',1);  d('!',1); d(';',1); d('#',1);
    d(' the ',4); d('fly ',4); d('drive ',6); d('run ',4);
    d('walk ',5); d('travel ',7); d('please ',7); d('room ',5);
    d('crawl se',6); d('crawl nw',6); d('steer ',6); d('crawl n ',6);
    d('crawl s ',6); d('crawl e',6); d('crawl w',6); d('that ',5);
    d('first ',6); d('second ',7); d('number ',7);
    d('this ',5); d('game ',5); d('i want to ',10); d(' my ',3); d('big ',4);
    d('those ',6); d('them ',5); d('broken ',7); d('large ',6);
    d('huge ',5); d('small ',6); d('tiny ',5);d('little ',7); d('within ',4);
    d('yes ',3); d('no ',2); d('wade ',4); d('swim ',4);
    while pos('examine ',input)>0 do delete(input,pos('examine ',input)+2,5);
    while pos('into ',input)>0 do delete(input,pos('into ',input)+2,2);
    while pos('. ',input)>0 do delete(input,pos('. ',input)+1,1);
    while pos('inside ',input)>0 do delete(input,pos('inside ',input)+2,4);
    d(' .',1); d('  ',1); d('..',1);
    if(input[1]='.')then delete(input,1,1);
    while(length(input)>0)and(input[1]=' ')do delete(input,1,1);
    while(length(input)>0)and(input[length(input)]=' ')do
     delete(input,length(input),1);
    if(input='')or(input[1]='.')then writeln('Whoops!')
   end;  {of Format}


procedure Chop(var input : Str80);
   var Word : Str80;
       j, l : integer;
   begin
     if length(input) >0 then
       begin
         input:=input+' ';
         j:=1;
         repeat
           Word:='';
           while(input[j]<>' ')and(input[j]<>'.')do begin
             Word:=Word+input[j];
             j:=j+1
           end;
           if length(Word) >7 then
             begin
               l:=pos(Word,input);
               j:=j+(7-length(Word));
               delete(input,l,length(Word));
               delete(Word,8,120);
               insert(Word,input,l)
             end;
           j:=j+1;
         until (j-1)=length(input);
         delete(input,length(input),1)
       end
   end;  {of Chop}


procedure LowerCase(var input : Str80);
    var j:byte;
   begin
     if length(input) > 0 then
      for j:=1 to length(input) do
       if(input[j] in ['A'..'Z'])then
        input[j]:=chr(ord(input[j])+32)
   end;   {of LowerCase}


procedure FindVerb (var input:Str80;var Word:Str14;var Verb:integer);
   var j, k, r : integer;
   begin
   j:=1;
   input:=input+' ';
   Word:='';
   while input[j]<>' ' do begin
     Word:=Word+input[j];
     j:=j+1
   end;
   if length(Word+' ')<length(input)then begin
     Word:=Word+' '; j:=j+1;
     while input[j]<>' ' do begin
       Word:=Word+input[j];
       j:=j+1
     end
   end;

   Verb:=Null;
   for r:= 0 to VMax do
     begin
       k:=0;
       repeat
         k:=k+1;
         if v[r,k]=Word then
           Verb:=r;
       until (v[r,k]=Q)or(k=5)
     end;

   if(pos(' ',Word)<>0)and(Verb=Null)then
     begin
       delete(Word,pos(' ',Word),8);
       for r:=0 to VMax do
         begin
           k:=0;
           repeat
             k:=k+1;
             if v[r,k]=Word then
               Verb:=r;
           until (v[r,k]=Q)or(k=5)
         end
     end;
     delete(input,length(input),1);
     if Verb<>Null then delete(input,1,length(Word));
     if input[1]=' 'then delete(input,1,1)
   end;  {of FindVerb}


procedure FindNoun(var input:Str80;var Word:Str14;var Noun:integer);
   var j, k, t  : integer;
   begin
   j:=1;
   input:=input+' ';
   Word:='';
   while input[j]<>' ' do begin
     Word:=Word+input[j];
     j:=j+1
   end;
   if length(Word+' ')<length(input)then begin
     Word:=Word+' ';j:=j+1;
     while input[j]<>' ' do begin
       Word:=Word+input[j];
       j:=j+1
     end
   end;

   Noun:=Null;
   for t:=0 to NMax do
     begin
       k:=0;
       repeat
         k:=k+1;
         if n[t,k]=Word then
           Noun:=t;
       until (n[t,k]=Q)or(k=5)
     end;

   if(pos(' ',Word)<>0)and(Noun=Null)then
     begin
       delete(Word,pos(' ',Word),8);
       for t:=0 to NMax do
         begin
           k:=0;
           repeat
             k:=k+1;
             if n[t,k]=Word then
               Noun:=t;
           until (n[t,k]=Q)or(k=5)
         end
     end;
     delete(input,length(input),1);
     if Noun<>Null then delete(input,1,length(Word));
     if input[1]=' 'then delete(input,1,1)
   end;  {of FindNoun}


procedure FindSep(var input : Str80; var h : Str14);
   var j  : integer;
   begin
     input:=input+' ';
     j:=1;
     h:='';
     while input[j]<>' ' do begin
       h:=h+input[j];
       j:=j+1
     end;
     if pos(' '+h+' ',' crawl on at to in off with within into '+
            ' above against through beside behind around across '+
            ' inside from by under using near over onto down ') >0 then
       begin
         delete(input,length(input),1);
         delete(input,1,length(h));
         if input[1]=' ' then delete(input,1,1);
         if(h='on')or(h='around')or(h='above')or(h='over')or(h='onto')
           then h:='to';
         if(h='inside')or(h='within')or(h='through')or(h='into')or(h='down')
           then h:='in';
         if(h='using')then h:='with';
         if(h='beside')or(h='by')then h:='near';
         if(h='against')then h:='at';
         if(h='across')then h:='over'
       end
     else
       begin
         h:='s';
         delete(input,length(input),1)
       end
   end;  {of FindSep}


procedure Check(var SepWord : Str14);
   var j  : integer;
   begin
   Verb:=Null; Noun:=Null; Noun2:=Null; DialNum:=Null; Flag:='?';
   SepWord:='s';
   if length(input)>0then
    begin
     FindVerb(input,Word,Verb);
     if Verb<>Null then
      if(length(input)>0)and not(Verb in [31,53,63])then
       begin
        FindNoun(input,Word,Noun);
        If(Noun<>Null)then LastNoun:=n[noun,1];
        if Noun<>Null then
         if(Verb in[0,8,9,21,36,6,7,15,17,32,26])and(length(input)=0)then
          begin
           Flag:='g';
           if(Verb in[36,15])then Verb:=9
          end
         else
         if(Verb in[0,8,21,36,37,29,9,39,6,15,7,17,32,26,40])then
          if length(input)>0 then
           begin
            if(Verb=9)then Verb:=29 else ;
            FindSep(input,SepWord);
            if SepWord<>'s' then
             if length(input)>0 then
              if Verb=39 then
               begin
                val(input,DialNum,j);
                Flag:='g'
               end
              else
               begin
                FindNoun(input,Word,Noun2);
                if Noun2<>Null then
                 if length(input)>0 then
                  Flag:='r'
                 else
                  Flag:='g'
                else
                 begin
                  FindVerb(input,Word,Verb);
                   if Verb=Null then Flag:='n'
                   else Flag:='b'
                 end
               end
             else
              if(Verb=39)and((SepWord='to')or(SepWord='off'))then
               Flag:='g' else Flag:='e'
            else
             Flag:='r'
           end
          else
           Flag:='s'
         else
          if length(input)>0 then
           begin FindVerb(input,Word,j);if j<>Null then Flag:='b' else
           begin FindSep(input,SepWord);if SepWord<>'s' then Flag:='b' else
           begin FindNoun(input,Word,j);if j<>Null then Flag:='h' end end;
            if Flag='?' then Flag:='v'
           end
          else
           Flag:='g'
        else
         begin
          FindVerb(input,Word,Verb);
           if Verb=Null then Flag:='n'
           else Flag:='b'
         end
       end
      else
       if Verb in OneWordCommands then Flag:='g'
       else Flag:='m'
     else
      begin
       FindNoun(input,Word,Noun2);
        If Noun2=Null then Flag:='v'
        else Flag:='a'
      end
    end;
   case flag of
   'v','n':if pos(' '+Word+' ',' crawl on at to in off with within into '+
                  ' above against through beside behind around down '+
                  ' inside by under using near over onto top below '+
                  ' from away want across ')>0 then begin
             write('The word ''',Word);RL(393)end
           else writeln('I don''t understand the word ''',Word,'.''');
     'b'  :begin
            if pos(' ',Word)>0 then delete(Word,pos(' ',Word),9);
            writeln('You can''t use the word ''',Word,''' here.')
           end;
     's'  :RL(129);
     'r'  :RL(130);
     'e'  :RL(131);
     'm'  :RL(132);
     'a'  :RL(316);
     'h'  :begin write(Word);RL(392)end
   end;
   Skip:=True;
   if flag<>'g' then begin Attack:=False;Line:='';Skip:=False end
  end;  {of Check}

{***************************** END OF ADPARSER ******************************}

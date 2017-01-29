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
{****************************************************************************}
{*                                COMMANDS                                  *}
{*                            by Scott Miller                               *}
{*  These are misc procedures and functions used with the main file: AdGame *}
{*                        Copyright 1984 Pending                            *}
{****************************************************************************}

procedure SA;
   begin FlagSA:='s' end;

function En(c : char) : boolean;
   begin
     if(c in Ev)then En:=True else En:=False
   end;

function Here(noun : integer): Boolean;
   begin
     if(noun in Inven)or(r[noun]=Prm)or(noun in p[Prm])then Here:=True
     else Here:=False
   end;

overlay procedure Crazy;
   begin SA;
    if(random(2)=1)then RL(107+random(7))else RL(300+random(6));
   end;

overlay procedure DEAD;
    var b,c:byte;
    FileName : file;
   begin SA; NoSound;
     gotoxy(1,25);for x:=1 to 7 do writeln;
     Textcolor(1);Textbackground(m9);
     gotoxy(1,18);
     write('*********************************************************',
           '***********************');writeln;
     gotoxy(1,19); for x:=1 to 3 do
     write('*                                                        ',
             '                      *');writeln;
     gotoxy(1,22);
     write('*********************************************************',
           '***********************');writeln;
     TextColor(m0);gotoxy(32,20);writeln('YOU HAVE DIED!!!');
     Textcolor(m2);Textbackground(0);
     for c:=700 downto 20 do for b:=70 downto 1 do sound(b*c);nosound;
     close(Rooms1);close(rooms2);close(special1);close(special2);close(line1);
     gotoxy(1,23);DelLine;DelLine;writeln;write('Do you wish to play again? ');
     read(kbd,flag);
     if(upcase(flag)<>'N')then
      begin
       writeln('Restarting...');window(1,1,80,25);
       assign(rooms1,'BEYOND.com');execute(rooms1)end
     else
      begin
       textcolor(7);
       textbackground(0);
       window(1,1,80,25);
       clrscr;
       writeln('    Beyond the Titanic');
       writeln('A Scott Miller Production');
       writeln('    Have a nice day...');
       delay(2000);
       assign(FileName,'MENU.COM');
       {$I-}
       execute(FileName);
       {$I+}
       if IOResult <> 0 then HALT;
      end
   end;

overlay procedure Home;
  var b,c:byte;
   begin SA;
     gotoxy(1,25);for x:=1 to 7 do writeln;
     Textcolor(25);Textbackground(m7);
     gotoxy(1,18);
     write('#########################################################',
           '#######################');writeln;
     gotoxy(1,19); for x:=1 to 3 do
     write('#                                                        ',
             '                      #');writeln;
     gotoxy(1,22);
     write('#########################################################',
           '#######################');writeln;
     TextColor(31);gotoxy(25,20);writeln('Y O U   H A V E   W O N ! ! !');
     Textcolor(m2);Textbackground(0);
     gotoxy(1,23);DelLine;DelLine;writeln;
     for x:=150 downto 1 do begin sound(x*55);delay(8);nosound;delay(20)end;
     if(Sc>1000)then Sc:=1000;
     write('You finished with a score of ',Sc,', which makes you a ');
     if(Sc=1000)then
      begin writeln('Perfect Adventurer!!!');
        for y:=1 to 7 do
         for o:=0 to 20 do
           for x:= 99+(o*430)to 998+(o*430)do begin sound(25);sound(x)end
      end
     else writeln('Master Adventurer!');
     for c:=1 to 999 do for b:=1 to 61 do sound(b*c);nosound;
     writeln;nosound;
     writeln('Reboot your computer to regain control...')
  end;

overlay procedure Say(o : integer; p : str14);
   begin
     writeln('The ',n[o,1],' is already ',p,'.'); SA
   end;

overlay procedure Diagnose;
   begin
     RL(191);
     if((tic>42)and not(en('c')))or((tic>146)and not(en('n')))or(en('r'))then
      begin
       if(tic>42)and (not(en('c')))then RL(192)
        else if(tic>146)and not(en('n'))then RL(192);
       if(en('r'))then RL(51)
      end
     else RL(207)
   end;

overlay procedure Monster(var NewRm : integer);
   begin
    if(NewRm=MnRm)and(MnRm=25)then begin Attack:=False;RL(384)end else
    if(NewRm<>35)or not(en('v'))then
     begin
      p[Prm]:=p[Prm]-[23];p[NewRm]:=p[NewRm]+[23];MnRm:=NewRm;Attack:=False;
       if not((NewRm=30)and(Verb in[27,28]))then
        case random(7) of
         0:RS(71);1:RS(72);2:RL(359);3:RL(360);4:RL(361);5:RL(362);6:RL(363)
        end
     end
    else begin RL(383);Attack:=False end
   end;

overlay procedure DescribeRm;
   var o : integer;
  procedure s(r : str14);
     begin TextColor(m8);writeln(r);TextColor(m2);loc:=r;end;
   begin SA;
if((en('a'))and(here(29)))or not(Prm in [6..24])then begin
     case Prm of
0:s('Ship''s Fore');1:s('Ship Mid-Deck');2:s('Rear of Ship');
3:s('Life Boat');4:s('Ocean Surface');5:s('Huge Cavern');
6:s('Cave of Pins');7:s('Ocean Bottom');8:s('Squeaky Cave');
9:s('Stream Bend');10:s('Waterfall');13:s('Sloppy Cave');
11:s('Hex Cave');12:s('Shallow Cleft');20:s('Zoo');
14:s('Winding Tunnel');15:s('Chasm');17:s('Chasm Bottom');
18:s('Tiny Opening');19:s('Etched Stairs');
21:s('Edge of Saucer');22:s('Side of Saucer');
23:s('Top of Saucer');24:s('Airlock');16:s('End of Rope');
76:s('Locked Cabin');25:s('Central Entry');
26:s('Lower Entry');27:s('Ship''s Systems');
30:s('Time Chamber');28:s('Ship''s Lab');34:s('Bridge');
29:s('Inside Tube');31:s('Life Support');58,69:s('Inside Shuttle');
32:s('Supply Chamber');33:s('Sleep Chamber');
35:s('Engine Room');36:s('Cargo Deck #1');37:s('Cargo Deck #2');
38:s('Cargo Deck #3');39:s('Cargo Deck #4');40:s('Large Cage');
41:s('Wooden Bridge');42:s('Broken End');43:s('South End');
44..46:s('Deserted Road');47:s('Crater Edge');48:s('Crater Floor');
49:s('Building Front');50:s('Lobby');51..54:s('Office Room');
55:s('Basement');56:s('Ladder Room');57:s('Building Roof');
59:case ShRm of 0:s('Above Mud Lake');
1:s('Above Rubble');2:s('Above Desert');3:s('Above Pits');
4:s('Above River');5:s('Above Stream');6:s('Above Town');
7:s('Above Mountain');8:s('Above Crator');9:s('Above Hills');
10:s('Above Canyon');11:s('Above Flatland');12:s('Above Dry Lake');
13:s('Above Desert');14:s('Above Bridge')end;{of Above Rooms}
63,64:s('Above Clouds');65..68:s('Outside City');70:s('Landing Bay');
71:s('Power Plant');72..74:s('Dark Corridor');75:s('Food Supply')
     end; {of case}

    if Verbose then begin FlagSA:='r';
      case Prm of
       2 :if(40 in p[2])then begin RR(2);RL(416)end;
       4 :if(en('B'))then RR(4)else begin RR(4);
           writeln('There is a safety harness here.')end;
       11:if(en('C'))then RS(15);
       40:if(en('g'))then RS(17);
       12:if not(en('G'))then begin RR(12);RL(146)end;
       31:if not(en('I'))then begin RR(31);RL(156)end;
       34:if(74 in p[34])then begin RR(34);RL(273)end;
       35:if(77 in p[35])then begin RR(35);RL(381);RL(382)end else
           if(en('W'))then begin RR(35);RL(381)end;
       42:if(13 in p[42])then begin RR(42);RL(214)end;
       48:if(27 in p[48])then begin RR(48);RL(276)end;
       59..69:begin SA;
               if(Prm=59)and not(ShRm in RmSh)then
                begin RmSh:=RmSh+[ShRm];RS(ShRm+46)end
               else if(Prm<>59)then RR(Prm);
               if KeyHole and here(63)then
                writeln('The shiny key is in the keyhole.')
              end
       else RR(Prm)
      end; {of case}
      if(FlagSA='r')and(Prm<>59)then RR(Prm)end;

     for o:= 0 to NMax do begin
       if(o in Mov)then
         if(r[o]=Prm)then
          if not((Prm in[59..69])and(KeyHole)and(o=63))then
           begin writeln('There is a ',n[o,1],' here.');
            if(here(ropecon))and(o=ropecon)and not(ropecon in inven)then
             writeln('  The rope is attatched to the ',n[o,1],'.');
            if(en('d'))and(o=70)and(here(70))then RL(147);
            if(o=SlotCon)and(here(o))then RL(388);
            if(o in CabiSet)and(here(o))then RL(389);
            if(o=PanelCon)and(here(o))then RL(390);
            if(o in KitSet)and(here(o))then RL(391);
           end
     end end
    else RL(54)
   end;  {of DescribeRm}

overlay procedure SAVE;
   begin SA; for x:=1 to 24 do writeln; nosound;
   window(1,3,80,25);
   gotoxy(1,4);
   if(Drive='A:')then
    writeln('Remove the GAME disk and insert your SAVE/RESTORE disk ',
            'in drive A:')else
    writeln('Make sure your SAVE/RESTORE disk is in drive B:');
   writeln('  (Press any key to continue...)');read(kbd,flag);
   writeln;writeln;
   write('Save under what name? ');BufLen:=8;readln(input);
   while pos(' ',input)>0 do delete(input,pos(' ',input),1);
   while pos('.',input)>0 do delete(input,pos('.',input),1);
   if(input='')then input:='LastRoom';
   writeln;writeln;input:=Drive+input;
   writeln('If your SAVE/RESTORE disk is in drive ',Drive,
            ' then press any key to start.');
   read(kbd,flag);
   with DiskSave do
    begin
     aInven:=Inven;aKitSet:=KitSet;aCabiSet:=CabiSet;aPanelCon:=PanelCon;
     aSlotCon:=SlotCon;aCompCon:=CompCon;aRopeCon:=RopeCon;aTic:=Tic;
     aYearDial:=YearDial;aPrm:=Prm;aMnRm:=MnRm;aSc:=Sc;aShots:=Shots;
     aShRm:=ShRm;aRx:=Rx;aEv:=Ev;aCode:=Code;aLoc:=Loc;aKeyHole:=KeyHole;
    end;
   assign(GameSave,input+'.a');
   rewrite(GameSave);
   write(GameSave,DiskSave);
   close(GameSave);
   assign(Objects,input+'.b');
   rewrite(Objects);
   for x:=0 to RMax do write(Objects,p[x]);
   close(Objects);
   assign(WordList,input+'.c');
   rewrite(Wordlist);
   for x:= 0 to NMax do
    for y:= 1 to 5 do
     write(WordList,n[x,y]);
   for x:= 0 to VMax do
    for y:= 1 to 5 do
     write(WordList,v[x,y]);
   close(WordList);
   assign(Things,input+'.d');
   rewrite(Things);
   for x:= 0 to NMax do write(Things,r[x]);
   close(Things);
   writeln; delete(input,1,2);
   writeln('Your present game location is now',
           ' SAVED to disk under the name ''',input,'.''');
   if(Drive='A:')then begin writeln;
    writeln('Remove the SAVE/RESTORE disk and insert your GAME disk.')end;
   writeln('  (Press any key to continue...)');read(kbd,flag);
   writeln;writeln;
   if(Verb<>54)then writeln('You may now resume your game...');
   if(Line='')then Line:='look';Tic:=Tic-2;Back:=True;
   if(Prm in[59..68])then sound(20);
   window(1,2,80,25)
   end; {of Save}

overlay procedure RESTORE;
 function Exist:Boolean;
 begin
 assign(GameSave,input+'.a');
 {$I-}
 Reset(GameSave);
 {$I+}
 Exist:=(IOresult=0)
 end;
   begin SA; for x:=1 to 24 do writeln; nosound;
   window(1,3,80,25);gotoxy(1,4);
   if(Drive='A:')then
    writeln('Remove the GAME disk and insert your SAVE/RESTORE disk ',
            'in drive ',Drive)else
    writeln('Make sure your SAVE/RESTORE disk is in drive B:');
   writeln('  (Press any key to continue...)');read(kbd,flag);
   writeln;writeln;
   write('Which file name do you want to RESTORE? ');BufLen:=8;readln(input);
   while pos(' ',input)>0 do delete(input,pos(' ',input),1);
   while pos('.',input)>0 do delete(input,pos('.',input),1);
   if(input='')then input:='LastRoom';
   writeln;writeln;input:=Drive+input;
   writeln('If your SAVE/RESTORE disk is now in drive ',Drive,
           ' then press any key to start.');
   read(kbd,flag);
   if Exist then
    begin
     close(GameSave);
     assign(GameSave,input+'.a');
     reset(GameSave);
     read(GameSave,DiskSave);
     close(GameSave);
     with DiskSave do
      begin
       Inven:=aInven;KitSet:=aKitSet;CabiSet:=aCabiSet;PanelCon:=aPanelCon;
       SlotCon:=aSlotCon;CompCon:=aCompCon;RopeCon:=aRopeCon;Tic:=aTic;
       YearDial:=aYearDial;Prm:=aPrm;MnRm:=aMnRm;Sc:=aSc;Shots:=aShots;
       ShRm:=aShRm;Rx:=aRx;Ev:=aEv;Code:=aCode;Loc:=aLoc;KeyHole:=aKeyHole;
      end;
     assign(Objects,input+'.b');
     reset(Objects);
     for x:=0 to RMax do read(Objects,p[x]);
     close(Objects);
     assign(WordList,input+'.c');
     reset(Wordlist);
     for x:= 0 to NMax do
      for y:= 1 to 5 do
       read(WordList,n[x,y]);
     for x:= 0 to VMax do
      for y:= 1 to 5 do
       read(WordList,v[x,y]);
     close(WordList);
     assign(Things,input+'.d');
     reset(Things);
     for x:= 0 to NMax do read(Things,r[x]);
     close(Things);
     writeln; delete(input,1,2);
     writeln('Your previously SAVED game location is now',
             ' RESTORED from the file ''',input,'.''');
     if(Drive='A:')then begin writeln;
      writeln('Remove the SAVE/RESTORE disk and insert your GAME disk.')end;
     writeln('  (Press any key to continue...)');read(kbd,flag);
    end
   else
    begin writeln;TextColor(28);
     writeln('             That name does not exist on this',
             ' SAVE/RESTORE disk.',^g);
     TextColor(m2);writeln;
     if(Drive='A:')then
      writeln('Put your GAME disk back in the disk drive and press any key.')
     else writeln('  (Press any key to continue...)');
     read(kbd,flag);
    end;
   writeln;writeln;writeln('You may now resume you game...');
   if(Line='')then Line:='look';Tic:=Tic-2;Back:=True;
   if(Prm in[59..68])then sound(20);
   window(1,2,80,25)
   end; {of Restore}

overlay procedure Vanish(o : integer);
   begin SA;
     inven:=inven-[o];
     r[o]:=Null;
     p[Prm]:=p[Prm]-[o];
     if(o=7)and not(en('I'))then Ev:=Ev+['I'];
     if(o=13)and(13 in p[42])then p[42]:=p[42]-[13];
     if(o=PanelCon)then PanelCon:=Null;
     if(o=SlotCon)then SlotCon:=Null;
     if(o in CabiSet)then CabiSet:=CabiSet-[o];
     if(o in kitset)then kitset:=kitset-[o];
     if(o=63)and KeyHole then KeyHole:=False;
     if(o=74)then Ev:=Ev-['p'];
     if(o=89)then Ev:=Ev-['i'];
     if(o=RopeCon)and(verb=36)then begin RopeCon:=Null;RL(402)end;
     if(o=RopeCon)and not(Verb in[9,14])then RopeCon:=Null
   end;

overlay procedure Play( Start, Stop, Wait: integer);
   var x : integer;
   begin
    if(Start<=Stop)then
     for x:= Start to Stop do
      begin sound(x); delay(Wait); end
    else
     for x:= Start downto Stop do
      begin sound(x); delay(Wait); end;
    if(Prm in[59..68])then sound(20)else nosound
   end; {of Play}

overlay procedure DropAll;
   var o : integer;
   begin
     for o:= 0 to NMax do
       if(o in inven)then
         begin
           r[o]:=Prm;
           inven:=inven-[o];writeln(n[o,1],': Dropped.');
         end;
     RL(106);
   end;  {of DropAll}

function FlasOff : Boolean;
   begin
     if not(En('a'))then FlasOff:=True
     else
       if(r[29]=Prm)or(29 in inven)then FlasOff:=False
       else FlasOff:=True;
   end;

procedure MoveTo(NewRm : integer);
 var o : integer;
 begin
   if(57 in inven)and(ropecon<>Null)and not(ropecon in inven)
     and(ropecon in mov)and not(ropecon=70)then
      begin r[ropecon]:=Prm;RL(158);end
   else if(57 in inven)and(ropecon<>Null)and(not(ropecon in mov)or
        ((ropecon=70)and(en('d'))))then
          begin RL(55);inven:=inven-[57];r[57]:=Prm;end
   else if not(57 in inven)and((ropecon in inven)or
          (ropecon in[60,56,44]))then r[57]:=NewRm
   else if not(57 in inven)and(r[57]=Prm)and(r[ropecon]=NewRm)then
          begin r[57]:=NewRm;RopeOld:=Prm;end
   else if not(57 in inven)and(r[57]=Prm)and(NewRm=RopeOld)and
              (r[ropecon]=Prm)then
          begin r[57]:=RopeOld;RopeOld:=Null;end;
   if(ropecon=Null)or((NewRm<>RopeOld)and(Prm<>RopeOld))then RopeOld:=Null;
   if(MnRm<>Null)then Monster(NewRm);
   if(Prm in[63..68])and not(NewRm in[59,69])then RL(343);
   if(Prm in[59,63..68])then for o:=0 to NMax do if(r[o]=Prm)then r[o]:=NewRm;
   Prm:=NewRm;
   DescribeRm
 end;  {of MoveTo}

procedure Time;
   begin
     Tic:=Tic+1;
  case Tic of
    3:RL(280);
    4:RS(1);
    17:if not(en('A'))then begin RS(3);DEAD end else RS(5);
    19:RL(4);
    20:RL(5);
    21:RL(6);
    23:RS(6);
    24:if(en('B'))then begin RS(8);writeln;RL(16);moveto(5);Sc:=Sc+25;
         n[64,5]:='ship';v[26,2]:='pick' end
       else begin RS(7);DEAD;end;
    43:if(not(en('c'))and not(en('n')))then RL(31);
    73:if(not(en('c'))and not(en('n')))then RL(32);
    93:if(not(en('c'))and not(en('n')))then begin RL(33); DEAD end;
    99:if(Prm in[6..24])and(here(29))and not(flasoff)and(not(en('s')))then
         begin RL(41);Ev:=Ev+['s'] end;
    147:if not(en('n'))then RL(31);
    149:if(here(29))and not(flasoff)then RL(59);
    153:if(Prm in[6..23])and(here(29))and not(flasoff)then
          begin RS(14);vanish(29) end;
    170:if not(en('n'))then RL(32);
    181:if not(en('n'))then begin RL(33); DEAD end;
    549:RL(281);
    586:RL(282);
    598:RL(283);
    607:begin RL(284);DEAD;end;
  end; {of case}

case Prm of
    1..3:if(tic>4)and(random(4)=1)then RL(405);
  36..39:if(random(5)=2)then RL(219);
     7  :if(random(8)=2)then RL(266);
     8  :if(random(3)=2)then begin RL(265);play(6666,7000,0);end;
  13..24:if(random(16)=2)then RL(246);
  25..35:if(random(30)=2)then RL(267);
   47,48:if(random(5)=2)and(inven <>[])then
           begin
            if(Prm=48)then begin writeln;RS(40)end
            else begin writeln;RS(44);moveto(48)end;
            o:=1;flag:='?';
            repeat o:=o+1;
             if(o in inven)then
             begin vanish(o);r[o]:=random(9)+41;flag:='g';end;
            until Flag = 'g';
           end;
end;
case Prm of
  5,6,9,10:if(random(9)=2)then RL(268);
  7..40:if(here(84))and(random(20)=2)then RL(269)
        else if(random(75)=2)then RS(36)
        else if(Prm in[5..22])and(random(33)=2)then
         begin RL(265);play(6500,6950,0)end;
  41..49:if(random(27)=2)then RL(285);
    59  :if(random(15)=1)then RL(406);
end;
if Attack and(MnRm=Prm)and(not Back)then
 begin case random(3) of 0:RS(80); 1:RS(81); 2:RS(82)end;DEAD end
else if(MnRm=Prm)then Attack:=True
   end;  {of Time}

function Present : Boolean;
   begin
    if(noun<>Null)and(noun<>1)then
     if(here(noun))then
      if(noun2<>Null)then
       if(here(noun2))then Present:=true
       else begin
         writeln('You can''t see any ',n[noun2,1],' here.');Present:=false end
      else Present:=true
     else begin
       writeln('You can''t see any ',n[noun,1],' here.');Present:=false end
    else Present:=true
   end;

overlay procedure Initialize;
 procedure Cn(S : Str80);
 begin
  gotoxy(40-(length(S)div 2),wherey);writeln(S);
 end;
  begin
   textcolor(15);
   writeln('Prepare to engage yourself in a most exciting adventure.');
   writeln('But first, two simple questions:');
   gotoxy(1,4);write('Are you using a COLOR screen (Y/N)? ');
   nosound; play(72,80,45);
   read(kbd,flag); play(2500,2490,6);
   m0:=20;m1:=14;m2:=11;m3:=4;m4:=15;m5:=28;m6:=1;m7:=4;m8:=10;m9:=10;
   if upcase(flag)='N' then
    begin
     writeln('No, I don''t have a color screen.');
     m0:=31;m1:=15;m2:=15;m3:=7;m4:=0;m5:=31;m6:=7;m7:=8;m8:=7;m9:=0;
    end else writeln('Yes, I do have a color screen.');writeln;
   write('How many disk drives do you have (1/2)? ');
   play(80,88,30);
   read(kbd,flag);play(2500,2490,6);
   Drive:='B:';
   if(upcase(flag)='O')or(flag='1')then
    begin Drive:='A:';writeln('I have ONE disk drive.')end else
    writeln('I have TWO disk drives.');
   delay(999);clrscr;textcolor(15);gotoxy(1,5);writeln;textcolor(7);
   cn('Beyond the Titanic');textcolor(6);cn('------------------');writeln;
   textcolor(7);
   cn('A Text & Sound Adventure Fantasy');writeln;writeln;
   cn('An Apogee Software Production');writeln;writeln;writeln;
   cn('Written and Programmed by Scott Miller');
   textcolor(11);
   gotoxy(32,24);textcolor(7);
   write('Press any key...');read(kbd,flag);clrscr;

   {                      *** SHAREWARE SCREEN ***                            }

   textcolor(15);
   writeln('Please note that Beyond the Titanic is a SHAREWARE game.');
   writeln;
   textcolor(7);
   writeln('This game has been placed in the public domain for your enjoyment.');
   writeln;
   writeln('If you like the game the author (Scott Miller) asks that you please');
   writeln('contribute $5 or $10 (your discretion) to him.  This minimal payment');
   writeln('will help compensent the author for the year of work that went into');
   writeln('Beyond the Titanic.  It will also encourage the author to make new and');
   writeln('better games, like Supernova and Kingdom of Kroz, both of which are');
   writeln('also shareware games recently released.');
   writeln;
   writeln('This fee also registers the payer for telephone support and clues.');
   writeln;writeln;
   writeln('Please make checks payable to Scott Miller.');
   writeln;
   textcolor(15);
   writeln('        Scott Miller           (214) 240-0614');
   writeln('        4206 Mayflower Dr.');
   writeln('        Garland, TX  75043');
   writeln;
   textcolor(7);
   writeln('Thanks, enjoy the game...');
   gotoxy(23,25);
   delay(12000);
   while keypressed do read(kbd,flag);
   write('Press any key to start the game...');
   read(kbd,flag);
   while keypressed do read(kbd,flag);
   clrscr;
   {                      ************************                            }

   gotoxy(1,25);
   TextColor(m1);
cn('APRIL 14, 1912    11:43 PM');
cn('You never knew the black canvas of the night was so full'+
   ' of twinkling detail.');
cn('Standing on deck of the White Star''s new super luxury liner, deep at sea,');
cn('where the bright lights of San Francisco don''t fade the night, you');
cn('can view thousands of stars you never realized existed.');
cn('Looking out over the icy sea you can barely see small pieces of'+
   ' broken ice');
cn('bobbing in the water.  Rumor has it that icebergs the size of small');
cn('mountains can be found in this region.  You don''t feel');
cn('too worried, though, the Titanic has been touted as');
cn('"unsinkable," and every single passenger knows');
cn('that White Star, the premier ship builder,');
cn('knows their stuff...');
for x:= 1 to 3 do writeln;
Line        :='';
LastNoun    :='';
KitSet      :=[2,29,57];
CabiSet     :=[89,63];
CompCon     :=Null;
PanelCon    :=8;
RopeCon     :=Null;
SlotCon     :=Null;
RopeOld     :=Null;
RmSh        :=[];
Mov         :=[2,7,8,13,27,29,32,34,40,52,51,57,63,70,74,77,89];
OneWordCommands:=[1,4,5,7,8,16,18,19,22,31,33..35,41,43..54,56..59,61..65];
Ev          :=[];
Inven       :=[];
Prm         :=0;
MnRm        :=Null;
Tic         :=Prm;
Sc          :=0;
Shots       :=6;
KeyHole     :=false;
Verbose     :=true;
Attack      :=False;
YearDial    :=135;
DayDial     :=60;
assign(rooms1,'rooms1');assign(rooms2,'rooms2');
assign(special1,'special1');assign(special2,'special2');assign(line1,'line');
reset(rooms1);reset(rooms2);reset(special1);reset(special2);reset(line1);
Str(Random(9998)+1,Code);
   DescribeRm; writeln; randomize;
   gotoxy(1,1);TextBackGround(m6);
   for x:=1 to 80 do write(' ');writeln;TextColor(m4);
   gotoxy(4,1);writeln('Move');gotoxy(68,1);writeln('Score');TextColor(m2);
   TextBackGround(0); Window(1,2,80,25);
  end; {of Initialize}
{***************************** END OF COMMANDS *****************************}

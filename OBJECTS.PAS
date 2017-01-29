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
{*                                 OBJECTS                                   *}
{*                             by Scott Miller                               *}
{*  This include file to AdGame initializes all of the immoveable objects.   *}
{*                         Copyright 1984 Pending                            *}
{*****************************************************************************}
overlay procedure Assign0;
begin
                      {INITIALIZE OBJECT'S ROOMS}
for o:=0 to NMax do r[o]:=Null;
p[0]:=[53,73,80,6,26,64,36];
p[1]:=[53,6,57,73,80,64,36];
p[2]:=[40,53,14,6,66,46,73,80,57,64,36];
p[3]:=[6,73,80,39,59,57,64,36];
p[4]:=[6,73,80,39,35,59,64,36];
p[5]:=[73,80,71];
p[6]:=[73,80,71];
p[7]:=[36,73,80,6];
p[8]:=[47,46];
p[9]:=[73,80];
p[10]:=[80,73,17];
p[11]:=[72];
p[12]:=[70];
p[13]:=[17,47,73,80];
p[14]:=[];
p[15]:=[17,73,80];
p[16]:=[17,57];
p[17]:=[17];
p[18]:=[];
p[19]:=[69];
p[20]:=[12,69,67,43];
p[21]:=[64,71,37];
p[22]:=[64,71,37];
p[23]:=[64,26,71,37];
p[24]:=[64,69,41,26,55];
p[25]:=[64,69,41,26,84];
p[26]:=[41,12,69,84];
p[27]:=[20,21,26,10,58,38,86];
p[28]:=[21,10,78,33,49,85];
p[29]:=[78,10,21,33,49,85];
p[30]:=[21,10,24,25,82,16,59,49,76,38,86];
p[31]:=[75,21,10,84,7,22];
p[32]:=[61,75,21,14];
p[33]:=[61,75,4,21,10,59,84];
p[34]:=[16,5,21,68,58,10,0,20,74,25,86];
p[35]:=[62,21,10,54,55];
p[36]:=[85,83,21,14,12,64,43];
p[37]:=p[36];
p[38]:=p[36]+[28];
p[39]:=p[36];
p[40]:=p[36]+[26,67];
p[41]:=[87,73,19,47,53,37];
p[42]:=p[41]+[13];
p[43]:=p[41];
p[44]:=[41,19,87];
p[45]:=[41,19];
p[46]:=[41,19];
p[47]:=[3,41,19,17,22];
p[48]:=[3,19,17,22,27,35];
p[49]:=[9,26,37,72];
p[50]:=[9,26,88,46,66,37,88,68];
p[51]:=[9,37];
p[52]:=[9,37];
p[53]:=[9,69,37];
p[54]:=[9,37];
p[55]:=[9,69,11,45,26,61,37,68];
p[56]:=[9,69,37];
p[57]:=[9,19,37,41,65,22,31,73,87];
p[58]:=[9,10,16,19,20,21,25,36,41,46,58,59,65,66,68,81,86];
p[59]:=p[58]+[17,18,22,31,71,73,87];
p[63]:=[9,10,16,18,19,20,21,25,36,41,46,58,59,65,66,68,81,86,88];
p[64]:=p[63];
p[65]:=p[63];
p[66]:=p[63];
p[67]:=p[63];
p[68]:=p[63];
p[69]:=p[63]+[9,14,37,53];
p[70]:=p[69]+[69]-[10,16,20,36,46,58,59,66,68,81,86];
p[71]:=[10,20,21,25,36,38,41,54,58,69];
p[72]:=[85];
p[73]:=p[72];
p[74]:=p[72];
p[75]:=[23,14,61];
p[76]:=[26,45];
for x:=0 to 76 do p[x]:=p[x]+[15,30,42,44,50,56,60,79]
end;
{****************************** END OF OBJECTS *******************************}

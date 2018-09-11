!-  MIND BOGGLE -- A Mastermind Game
!-  Originally a C64 program 'Mind Boggle' from Gazette Disk May 1984
!-  Rewritten in FreeBASIC
!-  Rewritten again back to C64 BASIC 2.0
!-  V 0.30 for C64 -- to add sound effects
!--------------------------------------------------------------------------------
1000 fr = 15: bg = 8:        rem default text and background colour
1010 col$ = "{blue}{green}{yellow}{red}{pink}{purple}" : rem 6 colours used in game
1020 dim ans(4): dim sel(4): rem answer and user's selection
1030 for i = 1 to 4: sel(i) = 1: next
1040 dim u(4): dim a(4):     rem temp holders for user answers n actual answers
1050 rem
1060 rem =======================================================================
1070 gosub 1290      :rem introduction
1080 x = rnd(ti)     :rem randomize
1090 rem start loop
1100     gosub 1440    :rem generate answer
1110     gosub 1610    :rem disp options
1120     sx = 1        :rem number of steps
1130     over = 0      :rem game over ?
1140     win = 0
1150     rem do until gameover = 1
1160         gosub 1900  :rem get selection
1170         gosub 2190  :rem print selection
1180         gosub 2310  :rem find matches
1190         gosub 2510  :rem print matches
1200         if black = 4 then win = 1: over = 1: goto 1240
1210         sx = sx+1
1220         if sx > 10 then over = 1: goto 1240
1230     goto 1160
1240     gosub 2690    :rem playagain = game over( win, st )
1250     if playagain = 1 then goto 1100
1260 end             :rem end of program
1270 rem
1280 rem =======================================================================
1290 rem initialize, introduction
1300 poke 53280,15: poke 53281,15: rem white background/border
1310 print "{dark gray}{clear}"
1320 sid = 54272: for i=sid to sid+24: poke i,0: next
1330 f = 40 : gosub 3300 : rem beep
1340 x = 1 : y = 20 : gosub 3120 : rem locateXY
1350 print "      ab.sayuti.hm.saman may 2014"
1360 print "    loosely based on a c64 program"
1370 print "           'mind boggle' in"
1380 print "    compute!s gazette disk may 1984"
1390 rem x = 8: y = 12: gosub 3140
1400 x$ = " m i n d  b o g g l e ": x = 9: y = 12: gosub 2990
1410 return
1420 rem
1430 rem -----------------------------------------------------------------------
1440 rem generate answer
1450 poke 53280,12: poke 53281,12: rem grey background/border
1460 print "{clear}{white}";
1470 x=5: y=12: gosub 3120
1480 print " i am choosing 4 colours now"
1490 gosub 3170
1500 ans(1) = int(rnd(1)*6)+1
1510 ans(2) = int(rnd(1)*6)+1
1520 if ans(2) = ans(1) then 1510
1530 ans(3) = int(rnd(1)*6)+1
1540 if ans(1)=ans(3) or ans(2)=ans(3) then 1530
1550 ans(4) = int(rnd(1)*6)+1
1560 if ans(1)=ans(4) or ans(2)=ans(4) or ans(3)=ans(4) goto 1550
1570 for t=1 to 1000: next
1580 return
1590 rem
1600 rem -----------------------------------------------------------------------
1610 rem display game screen
1620 rem poke 53280,12: poke 53281,12: rem grey background/border
1630 print "{clear}{dark gray}";
1640 print "      UCCCCCCCCCCCCCCCCC{cm r}CCCCI"
1650 for i = 1 to 9
1660     print "   ";i;"B {reverse on}   {reverse off} {reverse on}   {reverse off} {reverse on}   {reverse off} {reverse on}   {reverse off} B    B"
1670     print "      {cm q}CCCCCCCCCCCCCCCCC{sh +}CCCC{cm w}"
1680 next i
1690 print "   10 B {reverse on}   {reverse off} {reverse on}   {reverse off} {reverse on}   {reverse off} {reverse on}   {reverse off} B    B"
1700 print "      JCCCCCCCCCCCCCCCCC{cm e}CCCCK"
1710 x = 30: y = 1: gosub 3120
1720 print "{reverse on}{light green} m i n d {reverse off}"
1730 x = 30: y = 2: gosub 3120
1740 print "{reverse on}{light green} boggle  {reverse off}"
1750 rem show available colours
1760 x = 33
1770 print "{reverse on}";
1780 for i = 1 to 6
1790     y = 17 + i
1800     gosub 3120
1810     print mid$(col$,i,1);"    ";
1820 next i
1830 x = 0: y = 23: gosub 3120
1840 print "{reverse off}{white}select:";
1850 f = 100: gosub 3300
1860 return
1870 rem
1880 rem -----------------------------------------------------------------------
1890 rem Get selection II
1900 i = 1
1910 for j=1 to 4
1920     c = sel(j)
1930     x = 4+j*4: y = 23: gosub 3120
1940     print mid$(col$,c,1);"{reverse on}   {reverse off} ";
1950 next j
1960 x = 3+i*4: y = 22: gosub 3120
1970 print "{white}UCCCI";
1980 x = 3+i*4: y = 24: gosub 3120
1990 print "JCCCK";
2000 c = sel(i)
2010 x = 32: y = 17+c: gosub 3120: print "Z";
2020 x = 37: gosub 3120: print "Z";
2030 get k$: if k$="" then 2030
2040 x = 3+i*4: y = 22: gosub 3120
2050 print "     ";
2060 x = 3+i*4: y = 24: gosub 3120:
2070 print "     ";
2080 x = 32: y = 17+c: gosub 3120: print " ";
2090 x = 37: gosub 3120: print " ";
2100 if k$="{right}" then i=i+1: if i>4 then i=1
2110 if k$="{left}" then i=i-1: if i<1 then i=4
2120 if k$="{down}" then sel(i) = sel(i)+1: if sel(i)>6 then sel(i) = 1
2130 if k$="{up}" then sel(i) = sel(i)-1: if sel(i)<1 then sel(i) = 6
2140 if k$="{return}" then return
2150 goto 1910
2160 rem
2170 rem -----------------------------------------------------------------------
2180 rem sub print selection
2190 for i=1 to 4
2200     c = sel(i)
2210     f = 40+c*10: gosub 3300
2220     x = 4+i*4: y = sx*2: gosub 3120
2230     rem color 0, bckcol(x)
2240     print mid$(col$,c,1);"{reverse on}   {reverse off} ";
2250     for t=1 to 50: next
2260 next i
2270 print "{white}";
2280 return
2290 rem
2300 rem -----------------------------------------------------------------------
2310 rem sub find matches
2320 black = 0: white = 0
2330 for j=1 to 4
2340     u(j) = sel(j)
2350     a(j) = ans(j)
2360     if u(j) = a(j) then black = black+1: u(j) = 0: a(j) = 0
2370 next j
2380 for j=1 to 4
2390     if a(j)=0 then 2460
2400     match = 0
2410     for k = 1 to 4
2420         if u(k) = 0 then 2440
2430         if a(j) = u(k) then match = 1: u(k) = 0: a(j) = 0
2440     next k
2450     white = white + match
2460 next j
2470 return
2480 rem
2490 rem -----------------------------------------------------------------------
2500 rem function print matches
2510 y = sx*2: x = 25: gosub 3120
2520 if black = 0 then 2580
2530 for i=1 to black
2540     f = 120: gosub 3300
2550     print "{black}Q";
2560     for t=1 to 50: next
2570 next
2580 if white = 0 then 2640
2590 for i=1 to white
2600     f = 20: gosub 3300
2610     print "{white}Q";
2620     for t=1 to 50: next
2630 next
2640 print "{white}";
2650 return
2660 rem
2670 rem ----------------------------------------------------------------------
2680 rem function game over
2690 y = 23: x = 0: gosub 3120: print "{white}";
2700 if win = 0 then 2760
2710     if sx = 1 then print "     lucky guess!        ": goto 2870
2720     if sx < 4 then print "     expert!!!           ": goto 2870
2730     if sx < 7 then print "     pretty good!        ": goto 2870
2740     if sx < 9 then print "     so so!              ": goto 2870
2750     print "you barely got it!     ": goto 2870
2760 print "too bad you missed! 10 tries is enough."
2770 print "press [enter]";
2780 get k$: if k$ = "" then 2780
2790 y = 23: x = 0: gosub 3120
2800 print "answer:                                 ";
2810 y = 23: x = 8: gosub 3120
2820 for i=1 to 4
2830     c = ans(i)
2840     print mid$(col$,c,1);"{reverse on}   {reverse off} ";
2850     f = 100: gosub 3300
2860 next i
2870 y = 24: x = 0: gosub 3120
2880 print " press [enter]";
2890 get k$: if k$ = "" then 2890
2900 y = 23: x = 0: gosub 3120
2910 print "want to play again?                "
2920 print "  y or n?                          "
2930 get k$: if k$ <> "y" and k$ <> "n" then 2930
2940 if k$ = "y" then playagain = 1: return
2950 print "too bad...": playagain = 0: return
2960 rem
2970 rem ----------------------------------------------------------------------
2980 rem print colored text
2990 c = 1
3000 for n = 1 to 20
3010     print left$("{home}{down*25}",y);spc(x);
3020     for i=1 to len(x$)
3030         print mid$(col$,c,1);
3040         print mid$(x$,i,1);
3050         c = c+1: if c>6 then c = 1
3055         get k$ : if k$<>"" then return
3060     next i
3070 next n
3080 return
3090 rem
3100 rem ----------------------------------------------------------------------
3110 rem Locate XY
3120 print left$("{home}{down*25}",y);spc(x);
3130 return
3140 rem
3150 rem ----------------------------------------------------------------------
3160 rem Make random noise
3170 poke sid + 24, 15
3180 poke sid + 5, 16*1+1: poke sid + 6, 16*15+1
3190 for i=1 to 30
3200    f = int(rnd(1)*30) + 30
3210    poke sid + 1, f
3220    poke sid + 4, 1 + 16
3230    poke sid + 4, 16
3240    for t=1 to 60: next
3250 next
3260 return
3270 rem
3280 rem ----------------------------------------------------------------------
3290 rem Beep
3300 poke sid+24,15
3310 POKE sid+5,16*1+1: POKE sid+6,16*15+1: rem vol, AD, SR
3320 poke sid+1, f: poke sid+4,17
3330 for t=1 to 150: next
3340 poke sid+4,16
3350 return
3360 rem ======================================================================
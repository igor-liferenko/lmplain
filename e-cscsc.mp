%%%% THIS FILE BELONGS TO THE METATYPE1 PACKAGE
%%%%
%%%% TeX-oriented encoding file: Czech encoding (as used in Antykwa Torunska,
%%%% Iwona and Kurier) based on  www.tug.org/fontname/xl2.enc of 27.08.05
%%%% by Petr Olsak and Zdenek Wagner, adapted to the Computer Modern
%%%% caps and small caps encoding (used also for cmr5 but not for cmbx5)
%%%% for the Latin Modern collection of fonts, see comments below:
%%%%
%%%%   "some of our (CSTUG- czech TeX Users Group) users want to support
%%%%    8bit font coding such that:
%%%%    -- lower 7bit  is exactly OT1 (but with differences imposed
%%%%       by DEK -- e.g. layout of cmr is different from cmtt)
%%%%    -- upper part is taken from ISO-Latin 2 (iso 8859-2),
%%%%       but some of empty positions are filled with useful characters
%%%%       usually available in type-1 font (permill sign etc.)"
%%%%
%%%% With respect to the XL2.ENC, the following changes were introduced
%%%% in the basic encoding:
%%%%     32                         .notdef -> space
%%%%     92 quotedblleft (rep. in slot 255) -> backslash
%%%%    134                         .notdef -> Euro
%%%%    136                         .notdef -> trademark
%%%%    137                         .notdef -> copyright
%%%%    138                         .notdef -> registered
%%%%    142                         .notdef -> guilsinglleft
%%%%    143                         .notdef -> guilsinglright
%%%%    144                         .notdef -> pi
%%%%    145                         .notdef -> c_t
%%%%    146                         .notdef -> s_t
%%%%    147                         .notdef -> f_t
%%%%    % 149                         .notdef -> longs (no longs in csc)
%%%%    150                         .notdef -> lozenge
%%%%    151                         .notdef -> florin
%%%%    154                         .notdef -> quotesinglbase
%%%%    156                         .notdef -> hyphen.alt
%%%%    162         breve (rep. in slot 21) -> .notdef
%%%%    168     dieresis (rep. in slot 127) -> .notdef
%%%%    170                        Scedilla -> Scommaaccent
%%%%    176          ring (rep. in slot 23) -> degree
%%%%    178       cedilla (rep. in slot 24) -> .notdef
%%%%    180         acute (rep. in slot 19) -> .notdef
%%%%    183         caron (rep. in slot 20) -> .notdef
%%%%    186                        scedilla -> scommaaccent
%%%%    189 hungarumlaut (rep. in slot 125) -> tcommaaccent
%%%%    222                    Togonek (?!) -> Tcommaaccent
%%%%    223    germandbls (rep. in slot 25) -> .notdef
%%%%
%%%% In order to achieve the compatiblility with Computer Modern csc,
%%%% the following changes were introduced additionally:
%%%%     11 ff           -> arrowup       
%%%%     12 fi           -> arrowdown     
%%%%     13 fl           -> quotesingle   
%%%%     14 ffi          -> exclamdown (from 60)   
%%%%     15 ffl          -> questiondown  (from 62)
%%%%     60 exclamdown   -> less
%%%%     62 questiondown -> greater
%%%% The glyph space was left deliberately in slot 32 instead of suppress

vardef encoding_badge = "CS/XL2" enddef;
pf_info_encoding
  whatever, % for AFM
  "CS/XL2 Encoding /Czech/"; % for TFM

%%%%%   '000 = "00
encode("Gamma")(0);
encode("Delta")(1);
encode("Theta")(2);
encode("Lambda")(3);
encode("Xi")(4);
encode("Pi")(5);
encode("Sigma")(6);
encode("Upsilon")(7);
%%%%%   '010 = "08
encode("Phi")(8);
encode("Psi")(9);
encode("Omega")(10);
encode("arrowup")(11);       % replaced ff
encode("arrowdown")(12);     % replaced fi
encode("quotesingle")(13);   % replaced fl
encode("exclamdown")(14);    % replaced ffi
encode("questiondown")(15);  % replaced ffl
%%%%%   '020 = "10
encode("dotlessi")(16);
encode("dotlessj")(17);
encode("grave")(18);
encode("acute")(19);
encode("caron")(20);
encode("breve")(21);
encode("macron")(22);
encode("ring")(23);
%%%%%   '030 = "18
encode("cedilla")(24);
encode("germandbls")(25);
encode("ae")(26);
encode("oe")(27);
encode("oslash")(28);
encode("AE")(29);
encode("OE")(30);
encode("Oslash")(31);
%%%%%   '040 = "20
encode("space")(32);
encode("exclam")(33);
encode("quotedblright")(34);
encode("numbersign")(35);
encode("dollar")(36);
encode("percent")(37);
encode("ampersand")(38);
encode("quoteright")(39);
%%%%%   '050 = "28
encode("parenleft")(40);
encode("parenright")(41);
encode("asterisk")(42);
encode("plus")(43);
encode("comma")(44);
encode("hyphen")(45);
encode("period")(46);
encode("slash")(47);
%%%%%   '060 = "30
encode("zero")(48);
encode("one")(49);
encode("two")(50);
encode("three")(51);
encode("four")(52);
encode("five")(53);
encode("six")(54);
encode("seven")(55);
%%%%%   '070 = "38
encode("eight")(56);
encode("nine")(57);
encode("colon")(58);
encode("semicolon")(59);
encode("less")(60); % replaced exclamdown->14;
encode("equal")(61);
encode("greater")(62); % replaced questiondown->15;
encode("question")(63);
%%%%%   '100 = "40
encode("at")(64);
encode("A")(65);
encode("B")(66);
encode("C")(67);
encode("D")(68);
encode("E")(69);
encode("F")(70);
encode("G")(71);
%%%%%   '110 = "48
encode("H")(72);
encode("I")(73);
encode("J")(74);
encode("K")(75);
encode("L")(76);
encode("M")(77);
encode("N")(78);
encode("O")(79);
%%%%%   '120 = "50
encode("P")(80);
encode("Q")(81);
encode("R")(82);
encode("S")(83);
encode("T")(84);
encode("U")(85);
encode("V")(86);
encode("W")(87);
%%%%%   '130 = "58
encode("X")(88);
encode("Y")(89);
encode("Z")(90);
encode("bracketleft")(91);
encode("backslash")(92);
encode("bracketright")(93);
encode("circumflex")(94);
encode("dotaccent")(95);
%%%%%   '140 = "60
encode("quoteleft")(96);
encode("a")(97);
encode("b")(98);
encode("c")(99);
encode("d")(100);
encode("e")(101);
encode("f")(102);
encode("g")(103);
%%%%%   '150 = "68
encode("h")(104);
encode("i")(105);
encode("j")(106);
encode("k")(107);
encode("l")(108);
encode("m")(109);
encode("n")(110);
encode("o")(111);
%%%%%   '160 = "70
encode("p")(112);
encode("q")(113);
encode("r")(114);
encode("s")(115);
encode("t")(116);
encode("u")(117);
encode("v")(118);
encode("w")(119);
%%%%%   '170 = "78
encode("x")(120);
encode("y")(121);
encode("z")(122);
encode("endash")(123);
encode("emdash")(124);
encode("hungarumlaut")(125);
encode("tilde")(126);
encode("dieresis")(127);
%%%%%   '200 = "80
encode("ellipsis")(128);
encode("dagger")(129);
encode("daggerdbl")(130);
encode("bullet")(131);
encode("sterling")(132);
encode("paragraph")(133);
encode("Euro")(134);
% encode(".notdef")(135);
%%%%%   '210 = "88
encode("trademark")(136);
encode("copyright")(137);
encode("registered")(138);
% encode(".notdef")(139);
% encode(".notdef")(140);
encode("perthousand")(141);
encode("guilsinglleft")(142);
encode("guilsinglright")(143);
%%%%%   '220 = "90
encode("pi")(144);
encode("c_t")(145);
encode("s_t")(146);
encode("f_t")(147);
% encode("longs_t")(148);
% encode("longs")(149);
encode("lozenge")(150);
encode("florin")(151);
%%%%%   '230 = "98
encode("Agrave")(152);
% encode(".notdef")(153);
encode("quotesinglbase")(154);
% encode("quoteleft")(155);
encode("hyphen.alt")(156);
encode("ogonek")(157);
encode("guillemotleft")(158);
encode("guillemotright")(159);
%%%%%   '240 = "A0
% encode(".notdef")(160);
encode("Aogonek")(161);
% encode("breve")(162);
encode("Lslash")(163);
encode("currency")(164);
encode("Lcaron")(165);
encode("Sacute")(166);
encode("section")(167);
%%%%%   '250 = "A8
% encode("dieresis")(168);
encode("Scaron")(169);
encode("Scommaaccent")(170);
encode("Tcaron")(171);
encode("Zacute")(172);
% encode(".notdef")(173);
encode("Zcaron")(174);
encode("Zdotaccent")(175);
%%%%%   '260 = "B0
encode("degree")(176);
encode("aogonek")(177);
% encode("cedilla")(178);
encode("lslash")(179);
% encode("acute")(180);
encode("lcaron")(181);
encode("sacute")(182);
% encode("caron")(183);
%%%%%   '270 = "B8
encode("agrave")(184);
encode("scaron")(185);
encode("scommaaccent")(186);
encode("tcaron")(187);
encode("zacute")(188);
encode("tcommaaccent")(189);
encode("zcaron")(190);
encode("zdotaccent")(191);
%%%%%   '300 = "C0
encode("Racute")(192);
encode("Aacute")(193);
encode("Acircumflex")(194);
encode("Abreve")(195);
encode("Adieresis")(196);
encode("Lacute")(197);
encode("Cacute")(198);
encode("Ccedilla")(199);
%%%%%   '310 = "C8
encode("Ccaron")(200);
encode("Eacute")(201);
encode("Eogonek")(202);
encode("Edieresis")(203);
encode("Ecaron")(204);
encode("Iacute")(205);
encode("Icircumflex")(206);
encode("Dcaron")(207);
%%%%%   '320 = "D0
encode("Eth")(208);
encode("Nacute")(209);
encode("Ncaron")(210);
encode("Oacute")(211);
encode("Ocircumflex")(212);
encode("Ohungarumlaut")(213);
encode("Odieresis")(214);
encode("multiply")(215);
%%%%%   '330 = "D8
encode("Rcaron")(216);
encode("Uring")(217);
encode("Uacute")(218);
encode("Uhungarumlaut")(219);
encode("Udieresis")(220);
encode("Yacute")(221);
encode("Tcommaaccent")(222);
% encode("germandbls")(223);
%%%%%   '340 = "E0
encode("racute")(224);
encode("aacute")(225);
encode("acircumflex")(226);
encode("abreve")(227);
encode("adieresis")(228);
encode("lacute")(229);
encode("cacute")(230);
encode("ccedilla")(231);
%%%%%   '350 = "E8
encode("ccaron")(232);
encode("eacute")(233);
encode("eogonek")(234);
encode("edieresis")(235);
encode("ecaron")(236);
encode("iacute")(237);
encode("icircumflex")(238);
encode("dcaron")(239);
%%%%%   '360 = "F0
encode("eth")(240);
encode("nacute")(241);
encode("ncaron")(242);
encode("oacute")(243);
encode("ocircumflex")(244);
encode("ohungarumlaut")(245);
encode("odieresis")(246);
encode("divide")(247);
%%%%%   '370 = "F8
encode("rcaron")(248);
encode("uring")(249);
encode("uacute")(250);
encode("uhungarumlaut")(251);
encode("udieresis")(252);
encode("yacute")(253);
encode("quotedblbase")(254);
encode("quotedblleft")(255);

encoding_already_fixed:=1;

endinput


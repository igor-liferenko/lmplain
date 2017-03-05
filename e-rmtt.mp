%%%% THIS FILE BELONGS TO THE METATYPE1 PACKAGE
%%%%
%%%% TeX-oriented encoding file: RM (``Regular Math'') encoding
%%%% (for fonts to be used as text fonts in math, e.g., \fam0),
%%%% adapted to the Computer Modern typewriter encoding (see comments below):
%%%%
%%%% Slots 0--127 are occupied by exactly the same glyphs as 10-point CM
%%%% monospace fonts; slots 128--255 are taken from the EC encoding with
%%%% the following replacements (all characters in question would be
%%%% otherwise duplicated):
%%%% 
%%%%    code      GLYPH IN EC       REPLACED BY
%%%%     189      exclamdown        periodcentered
%%%%     190      questiondown      quotedbl
%%%%     198      AE                guillemotleft
%%%%     215      OE                guillemotright
%%%%     216      Oslash            perthousand
%%%%     230      ae                underscore
%%%%     247      oe                anglearc
%%%%     248      oslash            diameter
%%%%     255      germandbls        quotedblbase
%%%% 
%%%% The glyphs used for the replacement are taken from the QX encoding.
%%%% 
%%%% In order to achieve the compatiblility with Computer Modern typewriter,
%%%% the following changes were introduced in comparison with encrm.mp:
%%%%     11 ff            -> arrowup       
%%%%     12 fi            -> arrowdown     
%%%%     13 fl            -> quotesingle   
%%%%     14 ffi           -> exclamdown (from 60)   
%%%%     15 ffl           -> questiondown  (from 62)
%%%%     32 suppress      -> visiblespace
%%%%     34 quotedblright -> quotedbl
%%%%     60 exclamdown    -> less
%%%%     62 questiondown  -> greater
%%%%     95 dotaccent     -> underscore
%%%%    123 endash        -> braceleft
%%%%    124 emdash        -> bar
%%%%    125 hungarumlaut  -> braceright
%%%% These are perhaps officious:
%%%%    190 quotedbl      -> quotedblright
%%%%    230 underscore    -> hungarumlaut

vardef encoding_badge = "RMATH" enddef;
pf_info_encoding
  whatever, % for AFM
  "RMATH Encoding"; % for TFM

encode("Gamma")(0);
encode("Delta")(1);
encode("Theta")(2);
encode("Lambda")(3);
encode("Xi")(4);
encode("Pi")(5);
encode("Sigma")(6);
encode("Upsilon")(7);
encode("Phi")(8);
encode("Psi")(9);
encode("Omega")(10);
encode("arrowup")(11);       % replaced ff
encode("arrowdown")(12);     % replaced fi
encode("quotesingle")(13);   % replaced fl
encode("exclamdown")(14);    % replaced ffi
encode("questiondown")(15);  % replaced ffl
encode("dotlessi")(16);
encode("dotlessj")(17);
encode("grave")(18);
encode("acute")(19);
encode("caron")(20);
encode("breve")(21);
encode("macron")(22);
encode("ring")(23);
encode("cedilla")(24);
encode("germandbls")(25);
encode("ae")(26);
encode("oe")(27);
encode("oslash")(28);
encode("AE")(29);
encode("OE")(30);
encode("Oslash")(31);
encode("visiblespace")(32); % replaced space
encode("exclam")(33);
encode("quotedbl")(34); % replaced quotedblright
encode("numbersign")(35);
encode("dollar")(36);
encode("percent")(37);
encode("ampersand")(38);
encode("quoteright")(39);
encode("parenleft")(40);
encode("parenright")(41);
encode("asterisk")(42);
encode("plus")(43);
encode("comma")(44);
encode("hyphen")(45);
encode("period")(46);
encode("slash")(47);
encode("zero")(48);
encode("one")(49);
encode("two")(50);
encode("three")(51);
encode("four")(52);
encode("five")(53);
encode("six")(54);
encode("seven")(55);
encode("eight")(56);
encode("nine")(57);
encode("colon")(58);
encode("semicolon")(59);
encode("less")(60); % replaced exclamdown->14;
encode("equal")(61);
encode("greater")(62); % replaced questiondown->15;
encode("question")(63);
encode("at")(64);
encode("A")(65);
encode("B")(66);
encode("C")(67);
encode("D")(68);
encode("E")(69);
encode("F")(70);
encode("G")(71);
encode("H")(72);
encode("I")(73);
encode("J")(74);
encode("K")(75);
encode("L")(76);
encode("M")(77);
encode("N")(78);
encode("O")(79);
encode("P")(80);
encode("Q")(81);
encode("R")(82);
encode("S")(83);
encode("T")(84);
encode("U")(85);
encode("V")(86);
encode("W")(87);
encode("X")(88);
encode("Y")(89);
encode("Z")(90);
encode("bracketleft")(91);
encode("backslash")(92); % replaced quotedblleft
encode("bracketright")(93);
encode("circumflex")(94);
encode("underscore")(95); % replaced dotaccent
encode("quoteleft")(96);
encode("a")(97);
encode("b")(98);
encode("c")(99);
encode("d")(100);
encode("e")(101);
encode("f")(102);
encode("g")(103);
encode("h")(104);
encode("i")(105);
encode("j")(106);
encode("k")(107);
encode("l")(108);
encode("m")(109);
encode("n")(110);
encode("o")(111);
encode("p")(112);
encode("q")(113);
encode("r")(114);
encode("s")(115);
encode("t")(116);
encode("u")(117);
encode("v")(118);
encode("w")(119);
encode("x")(120);
encode("y")(121);
encode("z")(122);
encode("braceleft")(123); % replaced endash
encode("bar")(124); % replaced emdash
encode("braceright")(125); % replaced hungarumlaut
encode("tilde")(126);
encode("dieresis")(127);
encode("Abreve")(128);
encode("Aogonek")(129);
encode("Cacute")(130);
encode("Ccaron")(131);
encode("Dcaron")(132);
encode("Ecaron")(133);
encode("Eogonek")(134);
encode("Gbreve")(135);
encode("Lacute")(136);
encode("Lcaron")(137);
encode("Lslash")(138);
encode("Nacute")(139);
encode("Ncaron")(140);
encode("Eng")(141);
encode("Ohungarumlaut")(142);
encode("Racute")(143);
encode("Rcaron")(144);
encode("Sacute")(145);
encode("Scaron")(146);
encode("Scedilla")(147); % not to be confused with Scommaaccent
encode("Tcaron")(148);
encode("Tcedilla")(149); % Tcedilla is nowhere used
encode("Uhungarumlaut")(150);
encode("Uring")(151);
encode("Ydieresis")(152);
encode("Zacute")(153);
encode("Zcaron")(154);
encode("Zdotaccent")(155);
encode("IJ")(156);
encode("Idotaccent")(157);
encode("dcroat")(158);
encode("section")(159);
encode("abreve")(160);
encode("aogonek")(161);
encode("cacute")(162);
encode("ccaron")(163);
encode("dcaron")(164);
encode("ecaron")(165);
encode("eogonek")(166);
encode("gbreve")(167);
encode("lacute")(168);
encode("lcaron")(169);
encode("lslash")(170);
encode("nacute")(171);
encode("ncaron")(172);
encode("eng")(173);
encode("ohungarumlaut")(174);
encode("racute")(175);
encode("rcaron")(176);
encode("sacute")(177);
encode("scaron")(178);
encode("scedilla")(179); % not to be confused with scommaaccent
encode("tcaron")(180);
encode("tcedilla")(181); % tcedilla is nowhere used
encode("uhungarumlaut")(182);
encode("uring")(183);
encode("ydieresis")(184);
encode("zacute")(185);
encode("zcaron")(186);
encode("zdotaccent")(187);
encode("ij")(188);
encode("periodcentered")(189);
encode("quotedblright")(190);
encode("sterling")(191);
encode("Agrave")(192);
encode("Aacute")(193);
encode("Acircumflex")(194);
encode("Atilde")(195);
encode("Adieresis")(196);
encode("Aring")(197);
encode("guillemotleft")(198);
encode("Ccedilla")(199);
encode("Egrave")(200);
encode("Eacute")(201);
encode("Ecircumflex")(202);
encode("Edieresis")(203);
encode("Igrave")(204);
encode("Iacute")(205);
encode("Icircumflex")(206);
encode("Idieresis")(207);
encode("Eth")(208);
encode("Ntilde")(209);
encode("Ograve")(210);
encode("Oacute")(211);
encode("Ocircumflex")(212);
encode("Otilde")(213);
encode("Odieresis")(214);
encode("guillemotright")(215);
encode("perthousand")(216);
encode("Ugrave")(217);
encode("Uacute")(218);
encode("Ucircumflex")(219);
encode("Udieresis")(220);
encode("Yacute")(221);
encode("Thorn")(222);
encode("Germandbls")(223);
encode("agrave")(224);
encode("aacute")(225);
encode("acircumflex")(226);
encode("atilde")(227);
encode("adieresis")(228);
encode("aring")(229);
encode("hungarumlaut")(230);
encode("ccedilla")(231);
encode("egrave")(232);
encode("eacute")(233);
encode("ecircumflex")(234);
encode("edieresis")(235);
encode("igrave")(236);
encode("iacute")(237);
encode("icircumflex")(238);
encode("idieresis")(239);
encode("eth")(240);
encode("ntilde")(241);
encode("ograve")(242);
encode("oacute")(243);
encode("ocircumflex")(244);
encode("otilde")(245);
encode("odieresis")(246);
encode("anglearc")(247);
encode("diameter")(248);
encode("ugrave")(249);
encode("uacute")(250);
encode("ucircumflex")(251);
encode("udieresis")(252);
encode("yacute")(253);
encode("thorn")(254);
encode("quotedblbase")(255);

encoding_already_fixed:=1;

endinput


%%%% THIS FILE BELONGS TO THE METATYPE1 PACKAGE
%%%%
%%%% TeX-oriented encoding file: extended Lithuanian, cf.
%%%%   http://www.vtex.lt/tex/distfiles/littex-20060921.tar.gz
%%%%   http://www.vtex.lt/tex/download/texmf/doc/lt/latin7x.pdf
%%%% There are the following differences with respect to the original:
%%%%      130  quotesinglbase (rep. in slot 13) --> .notdef
%%%%      132  quotedblbase (rep. in slot 18)   --> .notdef
%%%%      139  guilsinglleft (rep. in slot 14)  --> .notdef
%%%%      141  dieresis (rep. in slot 4)        --> .notdef
%%%%      142  caron (rep. in slot 7)           --> .notdef
%%%%      143  cedilla (rep. in slot 11)        --> .notdef
%%%%      145  quoteleft (rep. in slot 96)      --> .notdef
%%%%      146  quoteright (rep. in slot 39)     --> .notdef
%%%%      147  quotedblleft (rep. in slot 16)   --> .notdef
%%%%      148  quotedblright (rep. in slot 17)  --> .notdef
%%%%      150  endash (rep. in slot 21)         --> .notdef
%%%%      151  emdash (rep. in slot 22)         --> .notdef
%%%%      155  guilsinglright (rep. in slot 15) --> .notdef
%%%%      157  macron (rep. in slot 9)          --> .notdef
%%%%      158  ogonek (rep. in slot 12)         --> .notdef
%%%%      160  space (rep. in slot 32)          --> nbspace
%%%%      161  quotedblright (rep. in slot 17)  --> .notdef
%%%%      165  quotedblbase  (rep. in slot 18)  --> .notdef
%%%%      171  guillemotleft (rep. in slot 19)  --> .notdef
%%%%      173  hyphen (rep. in slot 45)         --> hyphen.alt
%%%%      180  quotedblleft (rep. in slot 16)   --> .notdef
%%%%      187  guillemotright (rep. in slot 20) --> .notdef
%%%%      255  quoteright (rep. in slot 39)     --> .notdef

vardef encoding_badge = "L7X" enddef;
pf_info_encoding
  whatever, % for AFM
  "L7X Encoding /Lithuanian/"; % for TFM; tftopl changes braces to slashes

encode("grave")(0);
encode("acute")(1);
encode("circumflex")(2);
encode("tilde")(3);
encode("dieresis")(4);
encode("hungarumlaut")(5);
encode("ring")(6);
encode("caron")(7);
encode("breve")(8);
encode("macron")(9);
encode("dotaccent")(10);
encode("cedilla")(11);
encode("ogonek")(12);
encode("quotesinglbase")(13);
encode("guilsinglleft")(14);
encode("guilsinglright")(15);
encode("quotedblleft")(16);
encode("quotedblright")(17);
encode("quotedblbase")(18);
encode("guillemotleft")(19);
encode("guillemotright")(20);
encode("endash")(21);
encode("emdash")(22);
encode("cwm")(23);
encode("perthousandzero")(24);
encode("dotlessi")(25);
encode("dotlessj")(26);
encode("ff")(27);
encode("fi")(28);
encode("fl")(29);
encode("ffi")(30);
encode("ffl")(31);
encode("space")(32);
encode("exclam")(33);
encode("quotedbl")(34);
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
encode("less")(60);
encode("equal")(61);
encode("greater")(62);
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
encode("backslash")(92);
encode("bracketright")(93);
encode("asciicircum")(94);
encode("underscore")(95);
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
encode("braceleft")(123);
encode("bar")(124);
encode("braceright")(125);
encode("asciitilde")(126);
encode("Euro")(128);
% encode("quotesinglbase")(130);
encode("florin")(131);
% encode("quotedblbase")(132);
encode("ellipsis")(133);
encode("dagger")(134);
encode("daggerdbl")(135);
encode("perthousand")(137);
% encode("guilsinglleft")(139);
encode("OE")(140);
% encode("dieresis")(141);
% encode("caron")(142);
% encode("cedilla")(143);
% encode("quoteleft")(145);
% encode("quoteright")(146);
% encode("quotedblleft")(147);
% encode("quotedblright")(148);
encode("bullet")(149);
% encode("endash")(150);
% encode("emdash")(151);
encode("trademark")(153);
% encode("guilsinglright")(155);
encode("oe")(156);
% encode("macron")(157);
% encode("ogonek")(158);
encode("nbspace")(160);
% encode("quotedblright")(161);
encode("cent")(162);
encode("sterling")(163);
encode("currency")(164);
% encode("quotedblbase")(165);
encode("brokenbar")(166);
encode("section")(167);
encode("Oslash")(168);
encode("copyright")(169);
encode("Rcommaaccent")(170);
% encode("guillemotleft")(171);
encode("logicalnot")(172);
encode("hyphen.alt")(173);
encode("registered")(174);
encode("AE")(175);
encode("degree")(176);
encode("plusminus")(177);
encode("two.superior")(178);
encode("three.superior")(179);
% encode("quotedblleft")(180);
encode("mu")(181);
encode("paragraph")(182);
encode("periodcentered")(183);
encode("oslash")(184);
encode("one.superior")(185);
encode("rcommaaccent")(186);
% encode("guillemotright")(187);
encode("onequarter")(188);
encode("onehalf")(189);
encode("threequarters")(190);
encode("ae")(191);
encode("Aogonek")(192);
encode("Iogonek")(193);
encode("Amacron")(194);
encode("Cacute")(195);
encode("Adieresis")(196);
encode("Aring")(197);
encode("Eogonek")(198);
encode("Emacron")(199);
encode("Ccaron")(200);
encode("Eacute")(201);
encode("Zacute")(202);
encode("Edotaccent")(203);
encode("Gcommaaccent")(204);
encode("Kcommaaccent")(205);
encode("Imacron")(206);
encode("Lcommaaccent")(207);
encode("Scaron")(208);
encode("Nacute")(209);
encode("Ncommaaccent")(210);
encode("Oacute")(211);
encode("Omacron")(212);
encode("Otilde")(213);
encode("Odieresis")(214);
encode("multiply")(215);
encode("Uogonek")(216);
encode("Lslash")(217);
encode("Sacute")(218);
encode("Umacron")(219);
encode("Udieresis")(220);
encode("Zdotaccent")(221);
encode("Zcaron")(222);
encode("germandbls")(223);
encode("aogonek")(224);
encode("iogonek")(225);
encode("amacron")(226);
encode("cacute")(227);
encode("adieresis")(228);
encode("aring")(229);
encode("eogonek")(230);
encode("emacron")(231);
encode("ccaron")(232);
encode("eacute")(233);
encode("zacute")(234);
encode("edotaccent")(235);
encode("gcommaaccent")(236);
encode("kcommaaccent")(237);
encode("imacron")(238);
encode("lcommaaccent")(239);
encode("scaron")(240);
encode("nacute")(241);
encode("ncommaaccent")(242);
encode("oacute")(243);
encode("omacron")(244);
encode("otilde")(245);
encode("odieresis")(246);
encode("divide")(247);
encode("uogonek")(248);
encode("lslash")(249);
encode("sacute")(250);
encode("umacron")(251);
encode("udieresis")(252);
encode("zdotaccent")(253);
encode("zcaron")(254);
% encode("quoteright")(255);

encoding_already_fixed:=1;

endinput


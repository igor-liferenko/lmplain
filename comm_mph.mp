%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

% introduce_selected _Euro;
% introduce_selected _c, _ringhalfleft, _ringhalfright;
% introduce_selected _Euro;
% introduce_selected _p, _thorn, _Thorn, _eth, _Eth;
% input sel_orog;
% input sel_caro;
warningcheck:=-1; tracingdimens:=2; loose_fix_stem:=1; rigorous_encoding:=1;

pf_info_author
 "Copyright 2003--2009 by B. Jackowski and J.M. Nowacki" &
 " (on behalf of TeX USERS GROUPS)."
% pf_info_version "1.200"; pf_info_creationdate "22nd July 2009";
% pf_info_version "1.203"; pf_info_creationdate "26th August 2009";
% pf_info_version "2.000"; pf_info_creationdate "10th September 2009";
% pf_info_version "2.001"; pf_info_creationdate "12th September 2009";
% pf_info_version "2.002"; pf_info_creationdate "14th September 2009";
% pf_info_version "2.003"; pf_info_creationdate "16th September 2009";
pf_info_version "2.004"; pf_info_creationdate "7th October 2009";

vardef vn_compatibility = (generating=1) enddef; % used in *.mpl files

if unknown encoding_already_fixed:
 if known generating:
  if generating=1: % make TFM
   maybeinput "lm-tex.mpe"; % one of many many TFM encodings, copied locally
   if not maybeinput_ok: input e-qx; fi
   if unknown do_not_optimize_generating:
    if is_cork_encoding: input e-ec.sel; fi
    if is_czech_encoding: input e-cs.sel; fi
    if is_lithuanian_encoding: input e-l7x.sel; fi
    if is_qxtex_encoding: input e-qx.sel; fi
    if is_rmath_encoding: input e-rm.sel; fi
    if is_tsone_encoding: input e-ts1.sel; fi
    if is_vn_encoding: input e-t5.sel; fi
    if is_yandy_encoding: input e-yy.sel; fi
   fi
  else:  % make AFM
   maybeinput "lm-win.mpe"; % one of many many AFM encodings
   if not maybeinput_ok: input e-qxwin; fi
  fi
 else: % make PROOF
  input e-ase;
 fi
fi

if known generating: if generating=1: % make TeX-oriented ligatures
%
if not monospace:
 def dash_ligatures = % there must not be hyphen ligtable programs in MPL files
  LK("hyphen")
   LP("hyphen") ("endash")
   if is_cork_encoding or is_vn_encoding: LP("hyphen.alt")("hyphen.alt") fi
   if is_yandy_encoding: LP("hyphen.dup")("hyphen.dup") fi
  KL;
  LK("endash") LP("hyphen")("emdash") KL;
  LK("hyphendbl") % TS1; this ligature does not occur in monospace fonts...
   LP("hyphendbl.alt")("hyphendbl.alt")
  KL;
 enddef;
 extra_endfont:=extra_endfont & ";dash_ligatures;";
fi
%
if not monospace and not is_tsone_encoding:
 def french_ligatures = % somewhat odd, isn't it?
%|if is_czech_encoding or is_qxtex_encoding or is_rmath_encoding:
%| (code_to_name_[60]="exclamdown") and (code_to_name_[62]="questiondown")|
%|elseif is_tsone_encoding:
%| (code_to_name_[60]="angleleft") and (code_to_name_[62]="angleright")|
%|else:|
%| (code_to_name_[60]="less") and (code_to_name_[62]="greater")|
%|fi|
  LK(scantokens("_" & code_to_name_[60]))
   LP(scantokens("_" & code_to_name_[60])) ("guillemotleft")
  KL;
  LK(scantokens("_" & code_to_name_[62]))
   LP(scantokens("_" & code_to_name_[62])) ("guillemotright")
  KL;
 enddef;
 extra_endfont:=extra_endfont & ";french_ligatures;";
fi
%
if monospace and (is_cork_encoding or is_vn_encoding): % old Corkian tradition
 def mono_ligatures = 
% Spanish ligatures are defined separately, they are omnipresent
  LK("hyphen") LP("hyphen")("endash") LP("hyphen.alt")("hyphen.alt") KL;
  LK("comma") LP("comma")(quotedblbase_main) KL;
  LK("quoteleft") LP("quoteleft")(quotedblleft_main) KL;
  LK("quoteright") LP("quoteright")(quotedblright_main) KL;
  LK("greater") LP("greater")("guillemotright") KL;
  LK("less") LP("less")("guillemotleft") KL;
 enddef;
 extra_endfont:=extra_endfont & ";mono_ligatures;";
fi
%
def spanish_ligatures = % old Knuthian tradition (even in |monospace|!)
 LK("exclam")
  LP("quoteleft")("exclamdown")
  if is_yandy_encoding: LP("quoteleft.dup")("exclamdown") fi 
 KL;
 LK("question")
  LP("quoteleft")("questiondown")
  if is_yandy_encoding: LP("quoteleft.dup")("questiondown") fi
 KL;
enddef;
extra_endfont:=extra_endfont & ";spanish_ligatures;";
fi fi

% asymmetric double quotes mishmash;
% |quotedblbase_main|, |quotedblleft_main|, and |quotedblright_main|
% are employed in *.MPL files---they must be ``sparks'':
if name_to_code("quotedblbase.cm")<0: 
 def quotedblbase_main = "quotedblbase" enddef;
else: % |is_vn_encoding|
 def quotedblbase_main = "quotedblbase.cm" enddef;
fi
if name_to_code("quotedblleft.cm")<0:
 def quotedblleft_main = "quotedblleft" enddef; 
else: % |is_vn_encoding|
 def quotedblleft_main = "quotedblleft.cm" enddef;
fi
if name_to_code("quotedblright.cm")<0:
 def quotedblright_main = "quotedblright" enddef;
else: % |is_vn_encoding|
 def quotedblright_main = "quotedblright.cm" enddef;
fi

% Proofing defaults
show_fills(0);
show_strokes(1);
show_paths(1);
show_labels(1);
show_boxes(1);
show_stems(1);
show_stencils(0);

standard_introduce("space");
standard_introduce("nbspace");
standard_introduce("Gamma");
standard_introduce("Delta");
standard_introduce("Theta");
standard_introduce("Lambda");
standard_introduce("Xi");
standard_introduce("Pi");
standard_introduce("Sigma");
standard_introduce("Upsilon");
standard_introduce("Phi");
standard_introduce("Psi");
standard_introduce("Omega");
% Hans Hagen's proposal (duplicates of the relevant caps):
standard_introduce("Alpha");
standard_introduce("Beta");
standard_introduce("Chi");
standard_introduce("Epsilon");
standard_introduce("Eta");
standard_introduce("Iota");
standard_introduce("Kappa");
standard_introduce("Mu");
standard_introduce("Nu");
standard_introduce("Omicron");
standard_introduce("Rho");
standard_introduce("Tau");
standard_introduce("Zeta");
%
standard_introduce("ff");
standard_introduce("fi");
standard_introduce("fl");
standard_introduce("ffi");
standard_introduce("ffl");
standard_introduce("dotlessi");
standard_introduce("dotlessj");     % for the Adobe PUA: F6BE
standard_introduce("dotlessj.dup"); % for the "regular" unicode slot: 0237
standard_introduce("grave");
standard_introduce("Grave");
% standard_introduce("dblgrave");
% standard_introduce("dblGrave");
standard_introduce("Acute");
standard_introduce("acute");
standard_introduce("Caron");
standard_introduce("caron");
standard_introduce("Breve");
standard_introduce("breve");
standard_introduce("Breveinverted");     % for Mojca M.
standard_introduce("breveinverted");     % ditto
standard_introduce("brevebelowinverted");% ditto
standard_introduce("brevebelow");        % for completeness
standard_introduce("Ereversed");         % another Mojca's idea
standard_introduce("ereversed");         % ditto
standard_introduce("eturned");           % ditto
standard_introduce("schwa");             % ditto
standard_introduce("Macron");
standard_introduce("macron");
standard_introduce("Ring");
standard_introduce("ring");
standard_introduce("cedilla");
standard_introduce("germandbls");
standard_introduce("Germandbls");
standard_introduce("AE");
standard_introduce("ae");
standard_introduce("longs");
standard_introduce("OE");
standard_introduce("oe");
standard_introduce("Orogate");
standard_introduce("orogate");
standard_introduce("Oslash");
standard_introduce("oslash");
standard_introduce("suppress");
standard_introduce("exclam");
standard_introduce("quotedblright");
standard_introduce("numbersign");
standard_introduce("dollar");
standard_introduce("percent");
standard_introduce("ampersand");
standard_introduce("quoteright");
standard_introduce("parenleft");
standard_introduce("parenright");
standard_introduce("asterisk");
standard_introduce("plus");
standard_introduce("comma");
standard_introduce("hyphen"); % so called ``hyphen minus''
standard_introduce("period");
standard_introduce("slash");
standard_introduce("zero");
standard_introduce("one");
standard_introduce("two");
standard_introduce("three");
standard_introduce("four");
standard_introduce("five");
standard_introduce("six");
standard_introduce("seven");
standard_introduce("eight");
standard_introduce("nine");
standard_introduce("colon");
standard_introduce("semicolon");
standard_introduce("exclamdown");
standard_introduce("equal");
standard_introduce("questiondown");
standard_introduce("question");
standard_introduce("at");
standard_introduce("A");
standard_introduce("B");
standard_introduce("C");
standard_introduce("D");
standard_introduce("E");
standard_introduce("F");
standard_introduce("G");
standard_introduce("H");
standard_introduce("I");
standard_introduce("varI");
standard_introduce("J");
standard_introduce("K");
standard_introduce("L");
standard_introduce("M");
standard_introduce("N");
standard_introduce("O");
standard_introduce("P");
standard_introduce("Q");
standard_introduce("R");
standard_introduce("S");
standard_introduce("T");
standard_introduce("U");
standard_introduce("V");
standard_introduce("W");
standard_introduce("X");
standard_introduce("Y");
standard_introduce("Z");
standard_introduce("bracketleft");
standard_introduce("quotedblleft");
standard_introduce("bracketright");
standard_introduce("Circumflex");
standard_introduce("circumflex");
standard_introduce("Dotaccent");
standard_introduce("dotaccent");
standard_introduce("quoteleft");
standard_introduce("a");
standard_introduce("b");
standard_introduce("c");
standard_introduce("d");
standard_introduce("e");
standard_introduce("f");
standard_introduce("g");
standard_introduce("h");
standard_introduce("i");
% |standard_introduce("i.TRK");| % obsolete
standard_introduce("j");
standard_introduce("k");
standard_introduce("l");
standard_introduce("m");
standard_introduce("n");
standard_introduce("o");
standard_introduce("p");
standard_introduce("q");
standard_introduce("r");
standard_introduce("s");
standard_introduce("t");
standard_introduce("u");
standard_introduce("v");
standard_introduce("w");
standard_introduce("x");
standard_introduce("y");
standard_introduce("z");
standard_introduce("endash");
standard_introduce("emdash");
standard_introduce("hungarumlaut");
standard_introduce("Hungarumlaut");
standard_introduce("Tilde");
standard_introduce("tilde");
standard_introduce("Dieresis");
standard_introduce("Dieresisacute");
standard_introduce("Dieresiscaron");
standard_introduce("Dieresisgrave");
standard_introduce("dieresis");
standard_introduce("dieresisacute");
standard_introduce("dieresiscaron");
standard_introduce("dieresisgrave");
standard_introduce("Aogonek");
standard_introduce("Aogonekacute");
standard_introduce("Cacute");
standard_introduce("Eogonek");
standard_introduce("Eogonekacute");
standard_introduce("Lslash");
standard_introduce("Nacute");
standard_introduce("Sacute");
standard_introduce("Zacute");
standard_introduce("f_k");
standard_introduce("Zdotaccent");
standard_introduce("aogonek");
standard_introduce("aogonekacute");
standard_introduce("cacute");
standard_introduce("eogonek");
standard_introduce("eogonekacute");
standard_introduce("lslash");
standard_introduce("nacute");
standard_introduce("guillemotleft");
standard_introduce("guillemotright");
standard_introduce("sacute");
standard_introduce("zacute");
standard_introduce("zdotaccent");
standard_introduce("Oacute");
standard_introduce("oacute");
standard_introduce("quotedblbase");
standard_introduce("Dcroat");
standard_introduce("dcroat");
standard_introduce("Ubrevebelowinverted");   % for Mojca M.
standard_introduce("ubrevebelowinverted");   % ditto

% |standard_introduce("euro");|
standard_introduce("Euro");
standard_introduce("thorn");
standard_introduce("Thorn");
standard_introduce("eng");
standard_introduce("Eng");
standard_introduce("section");
standard_introduce("Eth");
standard_introduce("eth");
standard_introduce("Ibreve");
standard_introduce("ibreve");
standard_introduce("commaaccent");
standard_introduce("guilsinglleft");
standard_introduce("guilsinglright");
standard_introduce("sterling");
standard_introduce("quotesingle");
standard_introduce("quotedbl");
standard_introduce("ogonek");
standard_introduce("iogonek");
standard_introduce("iogonekacute");
standard_introduce("oogonek");
standard_introduce("oogonekacute");
standard_introduce("uogonek");
standard_introduce("Iogonek");
standard_introduce("Iogonekacute");
standard_introduce("Oogonek");
standard_introduce("Oogonekacute");
standard_introduce("Uogonek");
standard_introduce("underscore");
standard_introduce("Dcaron");
standard_introduce("dcaron");
standard_introduce("perthousand");
standard_introduce("anglearc"); % to slant or not to slant
standard_introduce("diameter"); % to slant or not to slant
standard_introduce("minus");
standard_introduce("multiply");
standard_introduce("divide");
standard_introduce("logicalnot");
standard_introduce("currency");
standard_introduce("copyright");
standard_introduce("registered");
standard_introduce("registered.alt");
standard_introduce("periodcentered");
standard_introduce("bullet");
standard_introduce("plusminus");
standard_introduce("ellipsis");
standard_introduce("quotesinglbase");
standard_introduce("ij");
standard_introduce("gcommaaccent");
standard_introduce("yen");
standard_introduce("cent");
standard_introduce("hbar");
standard_introduce("Hbar");
standard_introduce("dagger");
standard_introduce("daggerdbl");
standard_introduce("mu");
standard_introduce("paragraph");
standard_introduce("degree");
standard_introduce("asciicircum");
standard_introduce("asciitilde");

standard_introduce("varI");
standard_introduce("varIogonek");
standard_introduce("varIacute");
standard_introduce("varIcircumflex");
standard_introduce("varIdieresis");
standard_introduce("varIdotaccent");
standard_introduce("varIgrave");
standard_introduce("varImacron");
standard_introduce("varItilde");
standard_introduce("varIJ");
standard_introduce("vardotaccent");
standard_introduce("varregistered");
standard_introduce("varcopyright");
standard_introduce("trademark");

% borrowed
standard_introduce("less");
standard_introduce("greater");
standard_introduce("braceleft");
standard_introduce("braceright");
standard_introduce("bar");
standard_introduce("brokenbar");
standard_introduce("backslash");

standard_introduce("Aacute");
standard_introduce("Abreve");
standard_introduce("Acaron");
standard_introduce("Acircumflex");
standard_introduce("Adieresis");
standard_introduce("Agrave");
standard_introduce("Amacron");
standard_introduce("Aring");
standard_introduce("Atilde");
standard_introduce("Ccaron");
standard_introduce("Ccedilla");
standard_introduce("Ccircumflex");
standard_introduce("Cdotaccent");
standard_introduce("Eacute");
standard_introduce("Ebreve");
standard_introduce("Ecaron");
standard_introduce("Ecircumflex");
standard_introduce("Edieresis");
standard_introduce("Edotaccent");
standard_introduce("Egrave");
standard_introduce("Emacron");
standard_introduce("Gacute");
standard_introduce("Gbreve");
standard_introduce("Gcaron");
standard_introduce("Gcircumflex");
standard_introduce("Gcommaaccent");
standard_introduce("Gdotaccent");
standard_introduce("Hcircumflex");
standard_introduce("IJ");
standard_introduce("Iacute");
standard_introduce("Icaron");
standard_introduce("Icircumflex");
standard_introduce("Idieresis");
standard_introduce("Idieresisacute");
standard_introduce("Idotaccent");
standard_introduce("Igrave");
standard_introduce("Imacron");
standard_introduce("Itilde");
standard_introduce("Jacute"); % see T\~a{\'\j}a from D. E. Knuth's testfont
standard_introduce("J_caron"); % absent from the Unicode standard
standard_introduce("Jcircumflex");
standard_introduce("Kcommaaccent");
standard_introduce("Lacute");
standard_introduce("Lcaron");
standard_introduce("Lcommaaccent");
standard_introduce("Ldot");
standard_introduce("Ncaron");
standard_introduce("Ncommaaccent");
standard_introduce("Ntilde");
standard_introduce("Obreve");
standard_introduce("Ocaron");
standard_introduce("Ocircumflex");
standard_introduce("Odieresis");
standard_introduce("Ograve");
standard_introduce("Ohungarumlaut");
standard_introduce("Omacron");
standard_introduce("Otilde");
standard_introduce("Racute");
standard_introduce("Rcaron");
standard_introduce("Rcommaaccent");
standard_introduce("Rdotaccent"); % see {\L}au\.ra from D. E. Knuth's testfont
standard_introduce("Scaron");
standard_introduce("Scedilla");
standard_introduce("Scircumflex");
standard_introduce("Scommaaccent");
standard_introduce("Tcaron");
standard_introduce("Tcedilla");
standard_introduce("Tcommaaccent");
standard_introduce("Uacute");
standard_introduce("Ubreve");
standard_introduce("Ucaron");
standard_introduce("Ucircumflex");
standard_introduce("Udieresis");
standard_introduce("Udieresisacute");
standard_introduce("Udieresiscaron");
standard_introduce("Udieresisgrave");
standard_introduce("Ugrave");
standard_introduce("Uhungarumlaut");
standard_introduce("Umacron");
standard_introduce("Uring");
standard_introduce("Utilde");
standard_introduce("Wacute");
standard_introduce("Wcircumflex");
standard_introduce("Wdieresis");
standard_introduce("Wgrave");
standard_introduce("Yacute");
standard_introduce("Ycircumflex");
standard_introduce("Ydieresis");
standard_introduce("Ygrave");
standard_introduce("Zcaron");
standard_introduce("aacute");
standard_introduce("abreve");
standard_introduce("acaron");
standard_introduce("acircumflex");
standard_introduce("adieresis");
standard_introduce("agrave");
standard_introduce("amacron");
standard_introduce("aring");
standard_introduce("atilde");
standard_introduce("ccaron");
standard_introduce("ccedilla");
standard_introduce("ccircumflex");
standard_introduce("cdotaccent");
standard_introduce("eacute");
standard_introduce("ebreve");
standard_introduce("ecaron");
standard_introduce("ecircumflex");
standard_introduce("edieresis");
standard_introduce("edotaccent");
standard_introduce("egrave");
standard_introduce("emacron");
standard_introduce("gacute");
standard_introduce("gbreve");
standard_introduce("gcaron");
standard_introduce("gcircumflex");
standard_introduce("gdotaccent");
standard_introduce("hcircumflex");
standard_introduce("iacute");
standard_introduce("icaron");
standard_introduce("icircumflex");
standard_introduce("idieresis");
standard_introduce("idieresisacute");
standard_introduce("igrave");
standard_introduce("ij");
standard_introduce("imacron");
standard_introduce("itilde");
standard_introduce("jacute"); % see T\~a{\'\j}a from D. E. Knuth's testfont
standard_introduce("jcaron");
standard_introduce("jcircumflex");
standard_introduce("kcommaaccent");
standard_introduce("lacute");
standard_introduce("lcaron");
standard_introduce("lcommaaccent");
standard_introduce("ldot");
standard_introduce("ncaron");
standard_introduce("ncommaaccent");
standard_introduce("ntilde");
standard_introduce("obreve");
standard_introduce("ocaron");
standard_introduce("ocircumflex");
standard_introduce("odieresis");
standard_introduce("ograve");
standard_introduce("ohungarumlaut");
standard_introduce("omacron");
standard_introduce("otilde");
standard_introduce("racute");
standard_introduce("rcaron");
standard_introduce("rcommaaccent");
standard_introduce("rdotaccent"); % see {\L}au\.ra from D. E. Knuth's testfont
standard_introduce("scaron");
standard_introduce("scedilla");
standard_introduce("scircumflex");
standard_introduce("scommaaccent");
standard_introduce("tcaron");
standard_introduce("tcedilla");
standard_introduce("tcommaaccent");
standard_introduce("uacute");
standard_introduce("ubreve");
standard_introduce("ucaron");
standard_introduce("ucircumflex");
standard_introduce("udieresis");
standard_introduce("udieresisacute");
standard_introduce("udieresiscaron");
standard_introduce("udieresisgrave");
standard_introduce("ugrave");
standard_introduce("uhungarumlaut");
standard_introduce("umacron");
standard_introduce("uring");
standard_introduce("utilde");
standard_introduce("wacute");
standard_introduce("wcircumflex");
standard_introduce("wdieresis");
standard_introduce("wgrave");
standard_introduce("yacute");
standard_introduce("ycircumflex");
standard_introduce("ydieresis");
standard_introduce("ygrave");
standard_introduce("zcaron");

% exotic (and math, i.e., exotic):
standard_introduce("visiblespace");
  assign_name _visiblespace ("uni2423"); % Werner Lemberg's and Karl Berry's demands
standard_introduce("arrowup");
standard_introduce("arrowdown");
standard_introduce("arrowleft");
standard_introduce("arrowright");
standard_introduce("angleleft");
standard_introduce("angleright");
standard_introduce("centigrade"); % uni2103
standard_introduce("dblbracketleft"); % uni301a
standard_introduce("dblbracketright"); % uni301b
standard_introduce("infinity");
standard_introduce("quillbracketleft"); % uni2045
standard_introduce("quillbracketright"); % uni2046

% Karel P\'{\i}\v{s}ka's proposal (obsolete)
% |standard_introduce("Ring.cs");|
% |standard_introduce("ring.cs");| 
% |standard_introduce("Uring.cs");|
% |standard_introduce("uring.cs");|

% ly1 = TeX'n'ANSI
standard_introduce("acute.dup");
standard_introduce("ae.dup");
standard_introduce("AE.dup");
standard_introduce("cedilla.dup");
standard_introduce("circumflex.dup");
standard_introduce("dieresis.dup");
standard_introduce("germandbls.dup");
standard_introduce("macron.dup");
standard_introduce("oe.dup");
standard_introduce("OE.dup");
standard_introduce("oslash.dup");
standard_introduce("Oslash.dup");
standard_introduce("quoteleft.dup");
standard_introduce("quoteright.dup");
standard_introduce("tilde.dup");

% EC:
standard_introduce("cwm");
standard_introduce("perthousandzero"); % zeroinferior in VN fonts

% ts1//1 (existing)
% acute
% arrowleft
% arrowright
% breve
% brokenbar
% bullet
% caron
% cedilla
% cent
% circumflex
% comma
% copyright
% currency
% dagger
% daggerdbl
% degree
% dieresis
% divide
% dollar
% dotaccent
% Euro
% grave
% hungarumlaut
% logicalnot
% macron
% minus
% mu
% multiply
% ogonek
% paragraph
% period
% periodcentered
% perthousand
% plusminus
% registered
% ring
% section
% sterling
% tilde
% trademark
% yen

% ts1//2 (common)
standard_introduce("cwmcapital");
standard_introduce("cwmascender");
standard_introduce("fraction");
standard_introduce("fraction.alt"); % zero-width fraction
standard_introduce("one.superior");
standard_introduce("two.superior");
standard_introduce("three.superior");
standard_introduce("onequarter");
standard_introduce("onehalf");
standard_introduce("threequarters");
standard_introduce("ordfeminine");
standard_introduce("ordmasculine");

standard_introduce("centoldstyle");
standard_introduce("cent.oldstyle");
standard_introduce("dollaroldstyle");
standard_introduce("dollar.oldstyle");
standard_introduce("colonmonetary");
standard_introduce("recipe");
standard_introduce("blanksymbol"); % uni2422
standard_introduce("florin");
standard_introduce("guarani");
standard_introduce("baht"); % uni0e3f
standard_introduce("peso");
standard_introduce("dong");
standard_introduce("lira");
standard_introduce("gnaborretni");
standard_introduce("interrobang"); % uni203d
standard_introduce("naira"); % uni20a6
standard_introduce("won"); % uni20a9
standard_introduce("ohm"); % uni2126
standard_introduce("mho"); % uni2127
standard_introduce("copyleft");
standard_introduce("published"); % uni2117
standard_introduce("bigcircle");
standard_introduce("servicemark"); % uni2120
standard_introduce("openbullet");
standard_introduce("permyriad"); % uni2031
standard_introduce("tildelow");
standard_introduce("dblverticalbar"); % uni2016
standard_introduce("referencemark"); % uni203B

% ts1//3 (borrowed)
standard_introduce("acute.ts1");
standard_introduce("breve.ts1");
standard_introduce("caron.ts1");
standard_introduce("dblgrave.ts1");
standard_introduce("dieresis.ts1");
standard_introduce("grave.ts1");
standard_introduce("hungarumlaut.ts1");
standard_introduce("macron.ts1");
standard_introduce("quotesingle.ts1");
standard_introduce("quotedblbase.ts1");
standard_introduce("quotesinglbase.ts1");

% TeX ties
standard_introduce("tieaccentcapital");
standard_introduce("tieaccentcapital.new");
standard_introduce("tieaccentlowercase");
standard_introduce("tieaccentlowercase.new");

% other ties
standard_introduce("tie"); % 2040, consequence WL's proposal
% |standard_introduce("tieinverted"); % no slot in unicode, ignored|
standard_introduce("undertie"); % 203F, ``smile'', Werner Lemberg's proposal
standard_introduce("undertieinverted"); % 2054, ``frown'', consequence WL's proposal


% var figures et consortes
standard_introduce("hyphen.prop");
standard_introduce("zero.oldstyle");
standard_introduce("zero.prop");
standard_introduce("zero.taboldstyle");
standard_introduce("zerooldstyle");
standard_introduce("zero.slash");
standard_introduce("one.oldstyle");
standard_introduce("one.prop");
standard_introduce("one.taboldstyle");
standard_introduce("oneoldstyle");
standard_introduce("two.oldstyle");
standard_introduce("two.prop");
standard_introduce("two.taboldstyle");
standard_introduce("twooldstyle");
standard_introduce("three.oldstyle");
standard_introduce("three.prop");
standard_introduce("three.taboldstyle");
standard_introduce("threeoldstyle");
standard_introduce("four.oldstyle");
standard_introduce("four.prop");
standard_introduce("four.taboldstyle");
standard_introduce("fouroldstyle");
standard_introduce("five.oldstyle");
standard_introduce("five.prop");
standard_introduce("five.taboldstyle");
standard_introduce("fiveoldstyle");
standard_introduce("six.oldstyle");
standard_introduce("six.prop");
standard_introduce("six.taboldstyle");
standard_introduce("sixoldstyle");
standard_introduce("seven.oldstyle");
standard_introduce("seven.prop");
standard_introduce("seven.taboldstyle");
standard_introduce("sevenoldstyle");
standard_introduce("eight.oldstyle");
standard_introduce("eight.prop");
standard_introduce("eight.taboldstyle");
standard_introduce("eightoldstyle");
standard_introduce("nine.oldstyle");
standard_introduce("nine.prop");
standard_introduce("nine.taboldstyle");
standard_introduce("nineoldstyle");

% combining accents (34)
standard_introduce("Acutecomb");
standard_introduce("acutecomb");
standard_introduce("Brevecomb");
standard_introduce("brevecomb");
standard_introduce("brevebelowcomb");
standard_introduce("brevebelowinvertedcomb");
standard_introduce("Breveinvertedcomb");
standard_introduce("breveinvertedcomb");
standard_introduce("Caroncomb");
standard_introduce("caroncomb");
standard_introduce("Circumflexcomb");
standard_introduce("circumflexcomb");
standard_introduce("commaaccentcomb");
standard_introduce("dblGravecomb");
standard_introduce("dblgravecomb");
standard_introduce("Dieresiscomb");
standard_introduce("dieresiscomb");
standard_introduce("Dotaccentcomb");
standard_introduce("dotaccentcomb");
standard_introduce("dotbelowcomb");
standard_introduce("Gravecomb");
standard_introduce("gravecomb");
standard_introduce("Hookabovecomb");
standard_introduce("hookabovecomb");
standard_introduce("Hungarumlautcomb");
standard_introduce("hungarumlautcomb");
standard_introduce("linebelow");
standard_introduce("linebelowcomb");
standard_introduce("Macroncomb");
standard_introduce("macroncomb");
standard_introduce("macronbelowcomb");
standard_introduce("Ringcomb");
standard_introduce("ringcomb");
standard_introduce("Tildecomb");
standard_introduce("tildecomb");
standard_introduce("tildebelowcomb");

standard_introduce("asteriskmath");
standard_introduce("numero"); % afii61352
standard_introduce("estimated");
standard_introduce("discount");
standard_introduce("leaf");
standard_introduce("musicalnote");
standard_introduce("radical");

standard_introduce("paragraph.alt");

standard_introduce("born");
standard_introduce("died");
standard_introduce("married");
standard_introduce("divorced");

% additional quotes (see also ts1 quotes):
standard_introduce("quotedblbase.cm"); % actually, introduced in PL fonts
standard_introduce("quotedblleft.cm");
standard_introduce("quotedblright.cm");
standard_introduce("quotedblright.cs");
standard_introduce("quotedblbase.cs");

% additional hyphens (see comm_mpg.mp):
standard_introduce("hyphen.dup"); % ly1 = TeX'n'ANSI, CS subst.
standard_introduce("hyphen.alt"); % EC, VN
standard_introduce("hyphendbl"); standard_introduce("hyphendbl.alt"); % TS1
standard_introduce("sfthyphen"); % non-TeX
standard_introduce("uni2_0_1_0"); % hyphen with unicode point near en- and emdash
 assign_name _uni2_0_1_0("uni2010");
standard_introduce("uni2_0_1_1"); % non-breakable hyphen, duplicate of the above
 assign_name _uni2_0_1_1("uni2011");

% additional dashes
standard_introduce("threequartersemdash");
standard_introduce("twelveudash"); % ts1

% Vietnam

standard_introduce("breveacute");
standard_introduce("brevegrave");
standard_introduce("brevehookabove");
standard_introduce("brevetilde");
standard_introduce("Breveacute");
standard_introduce("Brevegrave");
standard_introduce("Brevehookabove");
standard_introduce("Brevetilde");
standard_introduce("circumflexacute");
standard_introduce("circumflexgrave");
standard_introduce("circumflexhookabove");
standard_introduce("circumflextilde");
standard_introduce("Circumflexacute");
standard_introduce("Circumflexgrave");
standard_introduce("Circumflexhookabove");
standard_introduce("Circumflextilde");
standard_introduce("dotbelow");
standard_introduce("hookabove");
standard_introduce("Hookabove");

standard_introduce("Yhookabove");            % uni1EF6
standard_introduce("yhookabove");            % uni1EF7
standard_introduce("Ydotbelow");             % uni1EF4
standard_introduce("ydotbelow");             % uni1EF5
standard_introduce("Ahookabove");            % uni1EA2
standard_introduce("ahookabove");            % uni1EA3
standard_introduce("Adotbelow");             % uni1EA0
standard_introduce("adotbelow");             % uni1EA1
standard_introduce("Acircumflexgrave");      % uni1EA6
standard_introduce("acircumflexgrave");      % uni1EA7
standard_introduce("Acircumflexacute");      % uni1EA4
standard_introduce("acircumflexacute");      % uni1EA5
standard_introduce("Acircumflextilde");      % uni1EAA
standard_introduce("acircumflextilde");      % uni1EAB
standard_introduce("Acircumflexhookabove");  % uni1EA8
standard_introduce("acircumflexhookabove");  % uni1EA9
standard_introduce("Acircumflexdotbelow");   % uni1EAC
standard_introduce("acircumflexdotbelow");   % uni1EAD
standard_introduce("Ehookabove");            % uni1EBA
standard_introduce("ehookabove");            % uni1EBB
standard_introduce("Edotbelow");             % uni1EB8
standard_introduce("edotbelow");             % uni1EB9
standard_introduce("Ecircumflexgrave");      % uni1EC0
standard_introduce("ecircumflexgrave");      % uni1EC1
standard_introduce("Ecircumflexacute");      % uni1EBE
standard_introduce("ecircumflexacute");      % uni1EBF
standard_introduce("Ecircumflextilde");      % uni1EC4
standard_introduce("ecircumflextilde");      % uni1EC5
standard_introduce("Ecircumflexhookabove");  % uni1EC2
standard_introduce("ecircumflexhookabove");  % uni1EC3
standard_introduce("Ihookabove");            % uni1EC8
standard_introduce("ihookabove");            % uni1EC9
standard_introduce("Ohookabove");            % uni1ECE
standard_introduce("ohookabove");            % uni1ECF
standard_introduce("Ocircumflexgrave");      % uni1ED2
standard_introduce("ocircumflexgrave");      % uni1ED3
standard_introduce("Ocircumflexacute");      % uni1ED0
standard_introduce("ocircumflexacute");      % uni1ED1
standard_introduce("Ocircumflextilde");      % uni1ED6
standard_introduce("ocircumflextilde");      % uni1ED7
standard_introduce("Ocircumflexhookabove");  % uni1ED4
standard_introduce("ocircumflexhookabove");  % uni1ED5
standard_introduce("Ohorn");                 %
standard_introduce("ohorn");                 %
standard_introduce("Uhorn");                 %
standard_introduce("uhorn");                 %
standard_introduce("Ohorngrave");            % uni1EDC
standard_introduce("ohorngrave");            % uni1EDD
standard_introduce("Uhorngrave");            % uni1EEA
standard_introduce("uhorngrave");            % uni1EEB
standard_introduce("Ohornacute");            % uni1EDA
standard_introduce("ohornacute");            % uni1EDB
standard_introduce("Uhornacute");            % uni1EE8
standard_introduce("uhornacute");            % uni1EE9
standard_introduce("Ohorntilde");            % uni1EE0
standard_introduce("ohorntilde");            % uni1EE1
standard_introduce("Uhorntilde");            % uni1EEE
standard_introduce("uhorntilde");            % uni1EEF
standard_introduce("Ohornhookabove");        % uni1EDE
standard_introduce("ohornhookabove");        % uni1EDF
standard_introduce("Uhornhookabove");        % uni1EEC
standard_introduce("uhornhookabove");        % uni1EED
standard_introduce("Ohorndotbelow");         % uni1EE2
standard_introduce("ohorndotbelow");         % uni1EE3
standard_introduce("Uhorndotbelow");         % uni1EF0
standard_introduce("uhorndotbelow");         % uni1EF1
standard_introduce("Udotbelow");             % uni1EE4
standard_introduce("udotbelow");             % uni1EE5
standard_introduce("Ytilde");                % uni1EF8
standard_introduce("ytilde");                % uni1EF9
standard_introduce("Etilde");                % uni1EBC
standard_introduce("etilde");                % uni1EBD
standard_introduce("Abreveacute");           % uni1EAE
standard_introduce("abreveacute");           % uni1EAF
standard_introduce("Abrevegrave");           % uni1EB0
standard_introduce("abrevegrave");           % uni1EB1
standard_introduce("Abrevetilde");           % uni1EB4
standard_introduce("abrevetilde");           % uni1EB5
standard_introduce("Abrevehookabove");       % uni1EB2
standard_introduce("abrevehookabove");       % uni1EB3
standard_introduce("Odotbelow");             % uni1ECC
standard_introduce("odotbelow");             % uni1ECD
standard_introduce("Uhookabove");            % uni1EE6
standard_introduce("uhookabove");            % uni1EE7
standard_introduce("Abrevedotbelow");        % uni1EB6
standard_introduce("abrevedotbelow");        % uni1EB7
standard_introduce("Ecircumflexdotbelow");   % uni1EC6
standard_introduce("ecircumflexdotbelow");   % uni1EC7
standard_introduce("Idotbelow");             % uni1ECA
standard_introduce("idotbelow");             % uni1ECB
standard_introduce("Ocircumflexdotbelow");   % uni1ED8
standard_introduce("ocircumflexdotbelow");   % uni1ED9

% dup 32 //uni2423 put % space

% Danish, Navajo etc.

standard_introduce("Ringacute");
standard_introduce("ringacute");
standard_introduce("Aringacute");
standard_introduce("aringacute");
standard_introduce("AEacute");
standard_introduce("aeacute");
standard_introduce("Oslashacute");
standard_introduce("oslashacute");
%
standard_introduce("dblgrave");
standard_introduce("dblGrave");
standard_introduce("Adblgrave");
standard_introduce("adblgrave");
standard_introduce("Edblgrave");
standard_introduce("edblgrave");
standard_introduce("Idblgrave");
standard_introduce("idblgrave");
standard_introduce("Odblgrave");
standard_introduce("odblgrave");
standard_introduce("Rdblgrave");
standard_introduce("rdblgrave");
standard_introduce("Udblgrave");
standard_introduce("udblgrave");

% silly duplicates (old Mac OSs do not recognize *commaaccent names,
% only *cedilla...)
standard_introduce("Gcedilla");
standard_introduce("gcedilla");
standard_introduce("Kcedilla");
standard_introduce("kcedilla");
standard_introduce("Lcedilla");
standard_introduce("lcedilla");
standard_introduce("Ncedilla");
standard_introduce("ncedilla");
standard_introduce("Rcedilla");
standard_introduce("rcedilla");
standard_introduce("Tcedilla");
standard_introduce("tcedilla");

% Sanskrit romanized transliteration, requested by R (Chandra) Chandrasekhar
standard_introduce("Ddotbelow");
standard_introduce("ddotbelow");
standard_introduce("Hdotbelow");
standard_introduce("hdotbelow");
standard_introduce("Ldotbelow");
standard_introduce("ldotbelow");
standard_introduce("Ldotbelowmacron");
standard_introduce("ldotbelowmacron");
standard_introduce("Mdotbelow");
standard_introduce("mdotbelow");
standard_introduce("Ndotaccent");
standard_introduce("ndotaccent");
standard_introduce("Ndotbelow");
standard_introduce("ndotbelow");
% |standard_introduce("Rdotaccent");| % already defined
% |standard_introduce("rdotaccent");| % ditto
standard_introduce("Rdotbelow");
standard_introduce("rdotbelow");
standard_introduce("Rdotbelowmacron");
standard_introduce("rdotbelowmacron");
standard_introduce("Tdotbelow");
standard_introduce("tdotbelow");

% Arabic romanized transliteration, requested by Idris Samawi Hamid
% |standard_introduce("brevebelow");| % already defined
standard_introduce("macronbelow");
standard_introduce("tildebelow"); % for completeness
% |standard_introduce("Ddotbelow");| % already defined
% |standard_introduce("ddotbelow");| % already defined
standard_introduce("Dlinebelow");
standard_introduce("dlinebelow");
% |standard_introduce("Hdotbelow");| % already defined
% |standard_introduce("hdotbelow");| % already defined
standard_introduce("Hbrevebelow");
standard_introduce("hbrevebelow");
standard_introduce("Hdieresis");
standard_introduce("hdieresis");
standard_introduce("Htilde");
standard_introduce("htilde");
standard_introduce("Ltilde");
standard_introduce("ltilde");
standard_introduce("Sdotbelow");
standard_introduce("sdotbelow");
% |standard_introduce("Tdotbelow");| % already defined
% |standard_introduce("tdotbelow");| % already defined
standard_introduce("Tdieresis");
standard_introduce("tdieresis");
standard_introduce("Tlinebelow");
standard_introduce("tlinebelow");
standard_introduce("Ttilde");
standard_introduce("ttilde");
standard_introduce("Zdotbelow");
standard_introduce("zdotbelow");
standard_introduce("macron.alt");
standard_introduce("imacron.alt");
standard_introduce("Macron.alt"); % for completeness
standard_introduce("Imacron.alt");% ditto

standard_introduce("ringhalfright"); % aka `hamza' actually small rev. `c'
standard_introduce("ringhalfleft");  % aka `ain' actually small `c'

endinput
%%%%EOF

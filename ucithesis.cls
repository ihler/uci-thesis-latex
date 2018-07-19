% ucithesis.cls: LaTeX2e class for writing UCI Ph.D. dessertation, based on
%   LaTeX ``report'' class, to comply with ``UCI Thesis and Dissertation Manual''
%   (http://special.lib.uci.edu/dissertations/electronic/tdmanuale.html).
%
% Disclaimer: not endorsed by UCI, provided without any guarantees.
%
% Authors: 
% Xianping Ge <xge@ics.uci.edu>
% Trevor Harmon <tharmon@uci.edu>
% Lars Otten <lotten@uci.edu>
% Tyler Sutterley <tsutterl@uci.edu>
% Alexander Ihler <ihler@ics.uci.edu>
%
% Changelog:
% Nov 17, 2015: Minor edit to Spacing in Curriculum Vitae Section.
% Aug 19, 2014: Added many (mostly optional) stylistic changes
% Oct 11, 2012: Defaulted back to standard \appendix with subsequent \chapter,
%               since custom \appendix confused figure/table counters. (Lars)
% Oct 10, 2012: Changed all margins to 1 in and removed signature page. (Lars)
% Aug 15, 2008: added "Page" as column title to Table of Contents, List of
%               Figures, and List of Tables (Trevor)
% Dec 6, 2007:  eliminated some spurious "duplicate ignored" (Trevor)
%               corrected bibliography spacing (Trevor)
% May 17, 2007: added support for the pre-published copyright page (Trevor)
%               corrected spelling (Trevor)
%               made dedication page optional (Trevor)
%               tweaked certain text and formatting to be closer to the UCI thesis manual (Trevor)
% Jan 12, 2005: beautified and trimmed fat (Trevor)
%               verified compatibility with latest LaTeX packages (Trevor)
%  Oct 3, 2002: added a \clearpage before each \addcontentsline (Xianping)
%               corrected spacing in preliminary pages. (Xianping)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucithesis}[2012/10/10 UCI Thesis class]

\def\ListAlgorithms{}                                % default: include List of Algorithms
\DeclareOption{fancy}{\def\UCIUseFancy{}}            % Use "fancy" headings and chapter appearance?
\DeclareOption{fliplr}{\def\UCIFlipLR{}}             % "Flip" notion of left & right (even/odd) pages
\DeclareOption{strict}{\def\UCIUseStrict{}}          % Enforce "strict" UCI standards
\DeclareOption{noLoF}{\def\UCINoListOfFigures{}}     % remove List of Figures? (if unused)
\DeclareOption{noLoT}{\def\UCINoListOfTables{}}      % remove List of Tables? (if unused)
\DeclareOption{noLoA}{\let\ListAlgorithms\undefined} % remove List of Algorithms? (if unused)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[12pt]{report}

\if@twoside
  \typeout{Warning: Two-side mode does not meet official UCI Dissertation requirements!}
  \raggedbottom       % match oneside's raggedbottom (twoside defaults to flushbottom)
  \def\UCIBoff{0in}   % Two-sided => could include a small binding offset in margins
  \def\UCIBrat{1:1}   %  default is 2:3 margins, but we'll force equal (change if desired)
  % (Forcing equal is useful if "twopage" conventions, like cleardoublepage, are not followed;
  %   then "fliplr" can be used to change the odd/even convention without it being too weird.)
\else
  \def\UCIBoff{0in}   % Single (electronic) => use equal 1" margins
  \def\UCIBrat{1:1}   %  default is 1:1 margins for single-page layout
\fi 

%\RequirePackage[hmargin={1in,1in},vmargin={1in,1in}]{geometry}   % Old version
\RequirePackage[ width=6.5in,top=1.1in,bottom=1.0in,bindingoffset=\UCIBoff,hmarginratio=\UCIBrat,
                headheight=15pt,headsep=18pt,footskip=.375in
               ]{geometry}
\RequirePackage{setspace}

\RequirePackage{fancyhdr}

% Added: relaxed float placement parameters for "big" figure sets
\renewcommand{\topfraction}{.9}
\renewcommand{\bottomfraction}{.9}
\renewcommand{\textfraction}{.2}
\renewcommand{\floatpagefraction}{.75}


\newcommand{\thesistitle}[1]{\newcommand\Thesistitle{#1}}
\newcommand{\degreename}[1]{\newcommand\Degreename{#1}}
\newcommand{\degreefield}[1]{\newcommand\Degreefield{#1}}
\newcommand{\authorname}[1]{\newcommand\Authorname{#1}}
\newcommand{\degreeyear}[1]{\newcommand\Degreeyear{#1}}
% Standard way to specify: Chair name, plus list of other committee members
\newcommand{\committeechair}[1]{\newcommand\Committeechair{#1}}
\newcommand{\othercommitteemembers}[1]{\newcommand\Othercommitteemembers{#1}}
% Alternate way of specifying the information (useful for co-advising)
\newcommand{\covercommittee}[1]{\newcommand\Covercommittee{#1}}
\newcommand{\abstractchair}[1]{\newcommand\Abstractchair{#1}}

\newcommand{\copyrightdeclaration}[1]{\newcommand\Copyrightdeclaration{#1}}
\newcommand{\prepublishedcopyrightdeclaration}[1]{\newcommand\Prepublishedcopyrightdeclaration{#1}}
\newcommand{\dedications}[1]{\newcommand\Dedications{#1}}
\newcommand{\acknowledgments}[1]{\newcommand\Acknowledgments{#1}}
\newcommand{\curriculumvitae}[1]{\newcommand\Curriculumvitae{#1}}
\newcommand{\thesisabstract}[1]{\newcommand\Thesisbstract{#1}}

\newcommand{\listalgorithms}{\renewcommand\ListAlgorithms{}}   % now redundant...

\newcommand{\thesistitlepage}
{
	\vspace*{0.5in}
	\thispagestyle{empty}
  \@mkboth{}{}
	\singlespacing
	\begin{center}
		UNIVERSITY OF CALIFORNIA, \\
		IRVINE \\
		\vspace{0.4in}
		\Thesistitle \\
		\vspace{0.15in}
		DISSERTATION \\
		\vspace{0.4in}
		submitted in partial satisfaction of the requirements \\
		for the degree of \\
		\vspace{0.4in}
		\MakeUppercase\Degreename \\
		\vspace{0.15in}
		in \Degreefield \\
		\vspace{0.4in}
		by \\
		\vspace{0.4in}
		\Authorname \\
	\end{center}
	\vspace{1in}
	\begin{flushright}
		Dissertation Committee: \\
    \ifx\Committeechair\undefined   
      \Covercommittee \\            % Can specify entire committee list directly
    \else
      \Committeechair, Chair \\     % Or, chair name (reused later)
		  \Othercommitteemembers \\     %   plus other members
    \fi
	\end{flushright}
	\vfill
	\begin{center}
		\Degreeyear
	\end{center}
	\clearpage
}

\newcommand{\copyrightpage}
{
	\thispagestyle{empty}
  \@mkboth{}{}
	\rule{0in}{0in}
	\protect\vfill
	\begin{center}
		\Copyrightdeclaration
	\end{center}
	\clearpage
}

\newcommand{\prepublishedcopyrightpage}
{
	\thispagestyle{empty}
  \@mkboth{}{}
	\rule{0in}{0in}
	\protect\vfill
	\begin{center}
		\Prepublishedcopyrightdeclaration
	\end{center}
	\clearpage
}

\newcommand{\signaturepage}
{
  \thispagestyle{plain}
  \@mkboth{}{}
	\vspace*{1in}
	\begin{center}
		The dissertation of \Authorname \\
		is approved and is acceptable in quality and form for \\
		publication on microfilm and in digital formats: \\
	\end{center}
	\vspace{3in}
	\begin{flushright}
	\rule{3in}{0.01in} \\
	\vspace{0.4in}
	\rule{3in}{0.01in} \\
	\vspace{0.4in}
	\rule{3in}{0.01in} \\
	Committee Chair
	\end{flushright}
	\vspace{.75in}
	\begin{center}
	University of California, Irvine \\
	\Degreeyear
	\end{center}
	\clearpage
}

\newcommand{\dedicationpage}
{
  \thispagestyle{plain}
  \@mkboth{DEDICATION}{DEDICATION}
	\begin{center}
		\textbf{\Large DEDICATION} \\
		\vspace{0.4in}
		\Dedications
	\end{center}
	\clearpage
}

\newcommand{\acknowledgmentspage}
{
  \thispagestyle{plain}
  \@mkboth{ACKNOWLEDGMENTS}{ACKNOWLEDGMENTS}
	\begin{center}
		\textbf{\Large ACKNOWLEDGMENTS}
	\end{center}
	\parskip 12pt
	\parindent 0pt
	\Acknowledgments
	\clearpage
}

\newcommand{\curriculumvitaepage}
{
  \thispagestyle{plain}
  \@mkboth{CV}{CV}
	\begin{center}
		\textbf{\Large CURRICULUM VITAE} \\
		\vspace{0.25in}
		\textbf{\large{\Authorname}}
	\end{center}
	\Curriculumvitae
	\clearpage
}

\newcommand{\abstractpage}
{
  \thispagestyle{plain}
  \@mkboth{ABSTRACT}{ABSTRACT}
	\begin{center}
		{\bf\Large ABSTRACT OF THE DISSERTATION} \\
		%\vspace{0.1in}
    \ifdefined\UCIUseFancy
      \rule{\textwidth}{2pt}\\
		  \vspace{0.15in}
    \else
      \vspace{0.2in}
    \fi
		\Thesistitle \\
		\vspace{0.2in}
		By \\
		\vspace{0.2in}
		\Authorname \\
		\vspace{0.2in}
		\Degreename\ in \Degreefield \\
		\vspace{0.2in}
		University of California, Irvine, \Degreeyear \\
		\vspace{0.2in}
    \ifx\Committeechair\undefined
      \Abstractchair \\             % Can specify chair line directly
    \else
      \Committeechair, Chair \\     % Or, chair name (reused from cover)
    \fi
    \ifdefined\UCIUseFancy
		  \vspace{0.1in}
      \rule{\textwidth}{2pt}
    \fi
	\end{center}
	\vspace{0.1in}
	\doublespacing
	\Thesisbstract
	\clearpage
}

%\renewcommand{\contentsname}{\protect\centering\protect\bfseries\Large TABLE OF CONTENTS}
%\renewcommand{\listfigurename}{\protect\centering\protect\bfseries\Large LIST OF FIGURES}
%\renewcommand{\listtablename}{\protect\centering\protect\bfseries\Large LIST OF TABLES}

% Add "Page" as column title to Table of Contents, List of Figures,
% List of Tables, and List of Algorithms
\addtocontents{toc}{\protect\raggedleft Page\\}
\addtocontents{lof}{\protect\raggedleft Page\\}
\addtocontents{lot}{\protect\raggedleft Page\\}
\addtocontents{loa}{\protect\raggedleft Page\\[1em]}  % Added extra 1em to make LoA and LoF match

\newcommand{\preliminarypages}
{
  \pagenumbering{gobble}% Remove page numbers (and reset to 1), see http://tex.stackexchange.com/questions/54333/no-page-numbering
  \clearpage
  \thispagestyle{empty} % Title page is counted but not numbered (repeated in macro)
  \thesistitlepage
  \clearpage
  \thispagestyle{empty} % Copyright page is counted but not numbered (repeated in macro)
	\ifx\Prepublishedcopyrightdeclaration\undefined
	  \copyrightpage              % if no copyright except yours
	\else
	  \prepublishedcopyrightpage  % if some parts published previously
	\fi
  \pagenumbering{roman} % From this point, roman numbering in preliminary pages
	\setcounter{page}{2}
	%\signaturepage  %% not for electronic submission
	\ifx\Dedications\undefined      %% Dedications (if supplied)
	\else
	  \dedicationpage
	\fi
	\tableofcontents
  \ifdefined\UCINoListOfFigures   %% List of Figures (if not suppressed)
  \else
	  \clearpage
	  \phantomsection
	  \addcontentsline{toc}{chapter}{LIST OF FIGURES}
	  \listoffigures
  \fi
  \ifdefined\UCINoListOfTables    %% List of Tables (if not suppressed)
  \else
	  \clearpage
	  \phantomsection
	  \addcontentsline{toc}{chapter}{LIST OF TABLES}
	  \listoftables
  \fi
	\ifx\ListAlgorithms\undefined   %% List of Algorithms (if not suppressed)
	\else
    \ifx\listofalgorithms\undefined %% also suppressed if no algorithm package
    \else
	    \clearpage
	    \phantomsection
	    \addcontentsline{toc}{chapter}{LIST OF ALGORITHMS}
	    \listofalgorithms
    \fi
	\fi
	\clearpage
	\phantomsection
	\addcontentsline{toc}{chapter}{ACKNOWLEDGMENTS}
	\acknowledgmentspage
	\clearpage
	\phantomsection
	\addcontentsline{toc}{chapter}{CURRICULUM VITAE}
	\curriculumvitaepage
	\clearpage
	\phantomsection
	\addcontentsline{toc}{chapter}{ABSTRACT OF THE DISSERTATION}
	\abstractpage
  \clearpage
  \setcounter{page}{1}
	\pagenumbering{arabic}
}

% Reverted back to standard latex appendix, since numbering of
% figures/tables was broken with custom command.
%\renewcommand{\appendix}
\newcommand{\myappendix}
{
	\par
	\setcounter{section}{0}
	\setcounter{figure}{0}
	\setcounter{table}{0}
	\setcounter{equation}{0}
	\gdef\thechapter{\@Alph\c@section}
	\gdef\thesection{\@Alph\c@section}
	\chapter*{Appendices}
	\addcontentsline{toc}{chapter}{Appendices}
}

% Redefine the bibliography to make it single-spaced.
\renewcommand{\bibliography}[1]{%
  \if@filesw
    \immediate\write\@auxout{\string\bibdata{#1}}%
  \fi
  % Make sure the table of contents has an entry for the bibliography
  \addcontentsline{toc}{chapter}{Bibliography}
  \begin{singlespacing}
  \@input@{\jobname.bbl}
  \end{singlespacing}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Additions for stylistic improvement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifdefined\UCIUseFancy

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Font additions for chapter titles, sections, etc.
% Base = 12 => (12, 14.4, 17.28, 20.74, 24.88, ...) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newfont{\sfbChapter}{cmssbx12 scaled\magstep4}    % 25pt sans serif bold
\newfont{\sfblarger}{cmssbx12 scaled\magstep1}     % 14pt sans serif bold
\newfont{\sfblarge}{cmssbx12 scaled\magstephalf}   % 13pt sans serif bold
\newfont{\sfb}{cmssbx12}                           % 12pt sans serif bold
\newfont{\sfsmall}{cmss10}                         % 10pt sans serif


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New caption appearance: "<b>Figure X.</b> Text... "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   \long\def\@makecaption#1#2{\vskip 10\p@
%   \setbox\@tempboxa\hbox{{\bf\footnotesize #1.} \footnotesize #2}% Create box for size test
%   \ifdim \wd\@tempboxa >\hsize
%       {\bf\footnotesize #1.} \footnotesize #2\par             % If wide, just do that
%   \else
%    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%   % Otherwise, put the box, centered
%%%      \hbox to\hsize{\box\@tempboxa\hfil}%    % (no centering version)
%   \fi}

% More figure / captioning definitions:
%\newlength{\captsize}         \let\captsize=\footnotesize        % caption text size = footnote
%\newlength{\captwidth}        \setlength{\captwidth}{\textwidth} % caption text width = textwidth
%\newlength{\beforetableskip}  \setlength{\beforetableskip}{.5\baselineskip} 
%\newcommand{\capt}[1]{\begin{minipage}{\captwidth}
%          \let\normalsize=\captsize
%          \caption[#1]{#1}
%          \end{minipage}\\ \vspace{\beforetableskip}}

%\newcommand{\thefigurename}{Figure}              % use "Figure X" for figures
%\def\fnum@figure{\thefigurename\ \thefigure}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use FancyHeader to install header/footer section & page numbers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\fancyfoot[C]{\fancyplain{\rm\thepage}}  % basic style? overridden by next part...

\pagestyle{fancyplain}
\fancyhf{}  % Clear header and footer fields
% Normal pages: no footer,
%   odd pages (right side of book):  (section info ... page #)
%   even pages (left side of book):  (page # ... chapter info)
%   If one-sided, all normal pages:  (chapter info ... page #)
% "Plain" pages: no header, page # center foot
\if@twoside
  \ifdefined\UCIFlipLR
  % May need to switch to this if not doing cleardoublepages (so page 1 ends up on the "left"):
    \fancyhead[RE]{\fancyplain{}{\bf\thepage}} \fancyhead[LE]{\fancyplain{}{\sfsmall\rightmark}}
    \fancyhead[LO]{\fancyplain{}{\bf\thepage}} \fancyhead[RO]{\fancyplain{}{\sfsmall\leftmark}}
  \else
  % This one is "normal" twoside (odd pages on the right of the book):
    \fancyhead[RO]{\fancyplain{}{\bf\thepage}} \fancyhead[LO]{\fancyplain{}{\sfsmall\rightmark}}
    \fancyhead[LE]{\fancyplain{}{\bf\thepage}} \fancyhead[RE]{\fancyplain{}{\sfsmall\leftmark}}
  \fi
\else
  \fancyhead[R]{\fancyplain{}{\bf\thepage}} \fancyhead[L]{\fancyplain{}{\sfsmall\leftmark}}
\fi

\fancyfoot[C]{\fancyplain{\bf\thepage}{}}

% Change the format of the section header  (lowercase OK, blank until section depth > 0)
\def\sectionmark#1{\markright{\ifnum \c@secnumdepth >\z@
  {\sfsmall Sec.\ }\thesection. \ \fi #1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chapter and section heads in bold Sans Serif
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modified from macros given in BK10.STY

%%%% Parts & Chapters 
% part unchanged
\def\@makechapterhead#1{ \vspace*{-20pt}  { \parindent 0pt \raggedright   % Standard Chapter:
 \ifnum \c@secnumdepth >\m@ne \LARGE\sf \@chapapp{} \thechapter \par      %   Big "Chapter X"
 \vskip 3pt \hrule \vskip 3pt \hrule                                      %   double-line
 \vskip 30pt \fi \raggedleft \Huge \sfbChapter #1\par                     %   then chapter name
 \nobreak \vskip 70pt } }                                                 %   and space

\def\@makeschapterhead#1{ \vspace*{4pt} { \parindent 0pt                  % Starred Chapter:
 \vskip 3pt \hrule \vskip 3pt \hrule                                      %   double-line
 \vskip 36pt \raggedleft \Huge \sfbChapter #1\par                         %   chapter name
 \nobreak \vskip 70pt } }                                                 %   and space


%%%%  Sections 
%  Notes: startsection{name}{level}{indent}{before-heading-skip}{after-heading-skip}
%    Negative spacing in before-heading => suppress paragraph indent of following text
%    Negative spacing in after-heading => horizontal skip rather than vertical
\def\section{\@startsection {section}{1}{\z@}{-3.5ex plus -1ex minus -.2ex}{1.8ex}{\large\sfblarger}}
%\def\subsection{\@startsection{subsection}{2}{\z@}{0ex plus -1ex minus -.2ex}{1pt}{\large\sfblarge}}  % !!!
\def\subsection{\@startsection{subsection}{2}{\z@}{-1ex plus -1ex minus -.2ex}{1pt}{\large\sfblarge}}  % !!!
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-2.75ex plus -1ex minus -.2ex}{1pt}{\normalsize\sfb}}

%%%% Paragraph and smaller
\def\paragraph{\@startsection{paragraph}{4}{\z@}{1.25ex plus 1ex minus .2ex}{-1em}{\normalsize\sfb}}
\def\subparagraph{\@startsection{subparagraph}{4}{\parindent}{1.25ex plus 1ex minus .2ex}{-1em}{\normalsize\sfb}}

% Uncomment to turn off leader dots in Table of Contents
%\renewcommand{\@dotsep}{500}  
\renewcommand{\contentsname}{Table of Contents}   % Make "Table of Contents" (vs "Contents")

% Optionally place a symbol to the left of section number (default: black square)
% Use "\sectionsymbol" to define symbol in document latex
%   Ex: \sectionsymbol{\protect\includegraphics[height=1.5ex]{sectionmarker}} 
\newcommand{\SectionSymbol}{$\blacksquare$}                     % initial, default section symbol
\newcommand{\sectionsymbol}[1]{\renewcommand\SectionSymbol{#1}} % define symbol-definition macro
% Now, define section count format to include symbol:
\renewcommand{\@seccntformat}[1]{{\SectionSymbol} \csname the#1\endcsname\hspace{0.5em}}
\newcommand{\SectionSymbolSpace}{\SectionSymbol\hspace{0.5em}}

\else
  \newcommand{\sectionsymbol}[1]{}   % blank def avoids errors if not fancy mode
  \newcommand{\SectionSymbolSpace}{} % use in section* definitions to make nice (automate?)
\fi


% Arguably "strict", I left these re-formatting for the non-strict version also

%%% ALT PRELIM ToC, LoF, LoT, etc.
%% !!! ALT VERSION: all caps prelim page headers, like dedication instead of chapters
%% (Note: restyles all starred chapters...)
\def\@makeschapterhead#1{ { \parindent 0pt                  % Starred Chapter:
 \protect\centering\protect\bfseries\Large #1\par                         %   chapter name
 \nobreak \vskip 70pt } }                                                 %   and space
\renewcommand{\contentsname}{TABLE OF CONTENTS}   
\renewcommand{\listfigurename}{LIST OF FIGURES}
\renewcommand{\listtablename}{LIST OF TABLES}
% \renewcommand{\listalgorithmname}{LIST OF ALGORITHMS}  % Needs to go after algorithmic package

\ifdefined\UCIUseStrict   %% begin "strict" 

%%% ALT HEADER/FOOTERS
%% !!! ALT VERSION 1:
\fancyhf{}  % Clear and set only bottom center page numbers and remove top rule
\fancyfoot[C]{\fancyplain{\bf\thepage}{\bf\thepage}}  
\renewcommand{\headrulewidth}{0pt}
%%% !!! ALT VERSION 2:
%\fancyhf{}  % Clear and set bottom + top right page #s, with top rule
%\fancyhead[R]{\fancyplain{}{\bf\thepage}} \fancyhead[L]{} 
%\fancyfoot[C]{\fancyplain{\bf\thepage}{}}  
%\renewcommand{\headrulewidth}{0.4pt}

\fi  % end strict

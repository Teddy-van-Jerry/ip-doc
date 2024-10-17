\NeedsTeXFormat {LaTeX2e}
\RequirePackage {l3keys2e}
\ProvidesExplClass {ip-doc}
  {2024/10/17} {1.0} {Class for IP core documentation}

\str_const:Nn \c__ip_doc_base_class_str { scrartcl }

\keys_define:nn { ip-doc }
  {
    , paper .tl_set:N  = \l__ip_doc_paper_paper_tl
    , paper .initial:n = { letter }
    , unknown .code:n  =
        {
          \iow_term:x
            {
              Passing~option~\CurrentOption \c_space_tl to~
              \str_use:N \c__ip_doc_base_class_str
            }
          \PassOptionsToClass { \CurrentOption } { \c__ip_doc_base_class_str }
        }
  }
\PassOptionsToClass { parskip = half-, numbers = noenddot }
  { \c__ip_doc_base_class_str }
\ProcessKeysOptions { ip-doc }
\LoadClass { \c__ip_doc_base_class_str }

%% Messages
\msg_new:nnn { ip-doc } { version-not-set }
  { \string\version\space is~not~set,~use~default~value~\@version@default. }

%% Fields
\NewDocumentCommand \version { m }
  {
    \gdef \@version { #1 }
  }
\newcommand \@version@default { 1.0 }
\bool_new:N \l__ip_doc_version_warned_bool
\bool_gset_false:N \l__ip_doc_version_warned_bool
\newcommand \@version
  {
    \bool_if:NTF \l__ip_doc_version_warned_bool
      { }
      {
        \bool_gset_true:N \l__ip_doc_version_warned_bool
        \msg_warning:nn { ip-doc } { version-not-set }
      }
    \@version@default
  }
\NewDocumentCommand \theversion { } { \@version }

%% Font Settings
\RequirePackage [ T1 ] { fontenc }
\RequirePackage { newtxtext }
\RequirePackage { newtxmath }
% Use sans-serif font.
\renewcommand \familydefault { \sfdefault }

%% Page Layout
\RequirePackage { geometry }
\geometry
  {
    , \l__ip_doc_paper_paper_tl paper
    , margin = 1in
    , left   = 1.2in
    , right  = 0.9in
    , bottom = 1.25in
  }
\newcommand* { \numberinmargin } [ 1 ]
  {
    \makebox[0pt][r]{#1\autodot\hskip\marginparsep}
  }
\renewcommand*{\sectionformat}{\numberinmargin{\thesection}}
\renewcommand*{\subsectionformat}{\numberinmargin{\thesubsection}}
\renewcommand*{\subsubsectionformat}{\numberinmargin{\thesubsubsection}}
\renewcommand*{\paragraphformat}{\numberinmargin{\theparagraph}}
\RedeclareSectionCommand
  [
    runin     = false,
    afterskip = -.5\parskip
  ] { section }
\RedeclareSectionCommand
  [
    runin     = false,
    afterskip = -.5\parskip
  ] { subsection }
\RedeclareSectionCommand
  [
    runin     = false,
    afterskip = -.5\parskip
  ] { subsubsection }

%% Math Settings
\RequirePackage { mathtools }

%% Header and Footer
\RequirePackage [ automark ] { scrlayer-scrpage }
\RequirePackage { lastpage }
\pagestyle { scrheadings }
\ihead { \textbf { \@title } \quad v \theversion }
\chead { }
\ohead { \rightmark }
\setkomafont { pageheadfoot } { \normalfont\normalcolor\upshape }
\renewcommand \pagemark
  {
    \small
    \usekomafont{pagenumber}Page~\thepage{}~of~\pageref*{LastPage}
  }


%% Table and Graphics
\RequirePackage { tabularx }
\RequirePackage { booktabs }
\RequirePackage { colortbl }
\RequirePackage { graphicx }
\RequirePackage { makecell }
\RequirePackage { wrapstuff }
% vertical center of the cell
\renewcommand \tabularxcolumn [ 1 ] { m{#1} }
% centered X
\newcolumntype { Y } { > { \raggedright\arraybackslash } X }
% new environment for a table (facts table)
\NewDocumentEnvironment { factstable } { O{} O{IP~Facts~Table} }
  {
    \begin{wrapstuff}[type=table, width=.5\linewidth, #1]
      \footnotesize
      \aboverulesep = 0mm \belowrulesep = 0mm
      {\centering\bfseries #2\par\vspace{.25\baselineskip}}
  }
  {
    \end{wrapstuff}
  }

%% Other Settings
\RequirePackage { enumitem }
\setlist { nosep, leftmargin = * }
\RequirePackage [ labelfont = bf ] { caption }

%% Utilities: Margin Notes and Device ID
\NewDocumentCommand \labeltext { s O{} m m }
  {
    \@bsphack%
    \MakeLinkTarget{}%
    \def\tst{#2}%
    \def\labelmarkup{}% How to markup the label itself
    %\def\refmarkup{\labelmarkup}% How to markup the reference
    \def\refmarkup{\color{purple}}%
    \ifx\tst\empty\def\@currentlabel{\refmarkup{#3}}{\label{#4}}%
    \else\def\@currentlabel{\refmarkup{#2}}{\label{#4}}\fi%
    \@esphack%
    \IfBooleanTF#1{}{\labelmarkup{#3}}% visible printed text.
  }

\reversemarginpar
\NewDocumentCommand \deviceID { m }
  {
    \marginline { \scriptsize #1 }
  }

%% Title Style
\NewDocumentCommand \theauthor { } { \@author }
\NewDocumentCommand \thetitle { } { \@title }
\NewDocumentCommand \thedate { } { \@date }
\RenewDocumentCommand \@maketitle { }
  {
    \noindent\rule{\textwidth}{2pt} \par
    \vspace{6pt}
    {
      \huge
      \textbf { \thetitle }
      \hfill
      \LARGE
      v \theversion \par
    }
    \vspace{2pt}
    \noindent\rule{\textwidth}{1pt} \par
    {
      \small
      \hfill\thedate\par
      \hfill\textit{\theauthor}\par
    }
  }

%% Hyperref
\RequirePackage { xurl } % break long URLs
\RequirePackage
  [
    , colorlinks
    , linkcolor = blue
    , urlcolor  = blue
    , citecolor = blue
    , pdfusetitle
  ] { hyperref }

\endinput

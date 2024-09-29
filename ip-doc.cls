\NeedsTeXFormat {LaTeX2e}
\RequirePackage {l3keys2e}
\ProvidesExplClass {ip-doc}
  {2024/09/25} {1.0} {Class for IP core documentation}

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
\PassOptionsToClass { parskip = half- } { \c__ip_doc_base_class_str }
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
\RequirePackage { scrlayer-scrpage }
\pagestyle { scrheadings }
\RequirePackage { lastpage }
\ihead { \textbf { \@title } \quad v \theversion }
\setkomafont { pageheadfoot } { \normalfont\normalcolor\upshape }
\ohead { \@currentlabel. ~ \@currentlabelname }
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

%% Hyperref
\RequirePackage
  [
    , colorlinks
    , linkcolor = blue
    , urlcolor  = blue
    , citecolor = blue
    , pdfusetitle
  ] { hyperref }

\endinput

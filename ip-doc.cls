\NeedsTeXFormat {LaTeX2e}
\RequirePackage {l3keys2e}
\ProvidesExplClass {ip-doc}
  {2024/09/25} {0.1} {Class for IP core documentation}

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
\ProcessKeysOptions { ip-doc }
\LoadClass { \c__ip_doc_base_class_str }

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
    , left = 1.25in
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

%% Math Settings
\RequirePackage { mathtools }

%% Header and Footer
\RequirePackage { lastpage }
\renewcommand \pagemark
  {
    \usekomafont{pagenumber}Page~\thepage{}~of~\pageref*{LastPage}
  }

%% Table
\RequirePackage { tabularx }
\RequirePackage { booktabs }

\RequirePackage
  [
    , hidelinks
    , pdfusetitle
  ] { hyperref }

\endinput

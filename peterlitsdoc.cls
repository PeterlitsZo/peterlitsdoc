
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{peterlitsdoc}
  [2020/05/25 0.0.1 Peterlits Document]


% it should be work under XeTeX
\RequirePackage{ifxetex}
\RequireXeTeX


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load class ctexart
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass[10pt, a4paper]{ctexart}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set the geometry
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[right=3cm, left=3cm, top=3.5cm, bottom=3.5cm]{geometry}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% useful package
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{calc}               % for math suppose
\RequirePackage{xcolor}             % for great color
\RequirePackage{mdwlist}            % for pltpara
\RequirePackage{verbatim}           % for verbatim
\RequirePackage{listings}           % for code verb
\RequirePackage{enumitem}           % for item env
\RequirePackage{graphicx}           % for picuture
\RequirePackage[bf, big]{titlesec}  % for better section
\RequirePackage{url}                % for url
\RequirePackage{tikz}               % for picuture


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plt para: make a box and a paragraph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\pltpara}[2]{
    \setlength{\topsep}{0pt}
    \setlength{\partopsep}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\itemsep}{0pt}
    \begin{basedescript} {
        \desclabelstyle{\multilinelabel}
        \desclabelwidth{\widthof{\fbox{\small #1}}+0.2em}
        }
        \setlength{\fboxsep}{0.2em}
        \item [\fbox{\small #1}] {#2}
    \end{basedescript}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plt note: note para
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\pltnte}[1]{{
    \pltred
    \pltpara{批注}{#1}
}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plt right: right para
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\pltrit}[1]{{
    \pltred
    \pltpara{改错}{#1}
}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plt box: good box
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\plt@box@width}

\newcommand{\plt@box@col}[2]{{
    \setlength{\plt@box@width}{\textwidth * #2 / #1}
    \hspace{\plt@box@width}
}}

\newenvironment{pltbox}{
    \def\col{\plt@box@col}
    \begin{tabbing}
}{
    \end{tabbing}
    \def\col\undefined
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plt endanthor: end anthor mark
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\pltendant}[4]{{
    \def\plt@endant@data{#1 - #2 - #3}
    \def\plt@endant@width{\widthof{\maxof{\plt@endant@data}{{#4}}}}

    \vspace{5em}
    \vfill
    \begin{flushright}
        \parbox[b]{\plt@endant@width}{%
            \pltgray%
            \raggedleft%
            \plt@endant@data\\{#4}%
        }
        \rule{0.2em}{\heightof{%
            \parbox[b]{\plt@endant@width}{%
                \plt@endant@data\\{#4}%
            }%
        } * 2}
    \end{flushright}
}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plt todo: todo box
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\plttodo[#1]{{%
    \nullfont
    \if\space#1\relax% if the input is a space
        \normalfont
        \hspace{0.1ex}
        \parbox[c]{2.8ex}{
            \tikz[scale=0.9]{\draw (0,0) rectangle (2ex,2ex);}
        }
	\else\if v#1\relax% if the char is 'v'
        \normalfont
        \hspace{0.1ex}
        \parbox[c]{2.8ex}{
            \tikz[scale=0.9]{
                \draw (2ex,1.5ex) -- (2ex,2ex) -- (0,2ex) -- (0,0)
                      -- (2ex,0) -- (2ex,0.5ex);
                \draw (0.75ex,1.25ex) -- (1.5ex,0.5ex) -- (3ex,2ex);
            }
        }
    \else\if x#1\relax% if the char is 'x'
        \normalfont
        \hspace{0.1ex}
        \parbox[c]{2.8ex}{
            \tikz[scale=0.9]{
                \draw (1.5ex,2ex) -- (0,2ex) -- (0,0) -- (2ex,0)
                      -- (2ex,0.5ex);
                \draw (0.75ex,1.25ex) -- (1.5ex,0.5ex) -- (3ex,2ex);
                \draw (1.75ex,1.75ex) -- (2.75ex,0.75ex);
            }
        }
    \else
        \normalfont
        \hspace{0.1ex}
        \parbox[c]{2.8ex}{
            \tikz[scale=0.9]{
                \draw (0,0) rectangle (2ex,2ex);
                \node at (1ex,1ex) {?};
            }
        }
    \fi\fi\fi
}}

\newcommand{\pltt}{\plttodo}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plt run: run latex code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% thanks source code of lshort
\newwrite\plt@run@out
\newlength\plt@run@savefboxrule
\newlength\plt@run@savefboxsep
\edef\plt@run@tempname{\jobname-example.aux}

\newenvironment{pltrun}%
{\begingroup\@bsphack
    \immediate\openout\plt@run@out=\plt@run@tempname
    \let\do\@makeother\dospecials\catcode`\^^M\active
    \def\verbatim@processline{\immediate\write\plt@run@out{\the\verbatim@line}}%
    \verbatim@start}%
{\immediate\closeout\plt@run@out\@esphack\endgroup%
    \trivlist\item\relax
    \setlength{\plt@run@savefboxrule}{\fboxrule}%
    \setlength{\plt@run@savefboxsep}{\fboxsep}%
    \setlength{\fboxsep}{0.015\textwidth}%
    \setlength{\fboxrule}{0.4pt}%
    \fcolorbox[gray]{0}{0.95}{%
        \begin{minipage}[c]{0.45\textwidth}%
            \setlength{\fboxrule}{\plt@run@savefboxrule}%
            \setlength{\fboxsep}{\plt@run@savefboxsep}%
            \small\verbatiminput{\plt@run@tempname}%
        \end{minipage}%
    }%
    \hfill%
    \fbox{%
        \begin{minipage}[c]{0.45\textwidth}%
            \setlength{\fboxrule}{\plt@run@savefboxrule}%
            \setlength{\fboxsep}{\plt@run@savefboxsep}%
            \normalsize\input{\plt@run@tempname}%
        \end{minipage}%
    }%
    \endtrivlist
}


\newenvironment{pltRun}%
{\begingroup\@bsphack
    \immediate\openout\plt@run@out=\plt@run@tempname
    \let\do\@makeother\dospecials\catcode`\^^M\active
    \def\verbatim@processline{\immediate\write\plt@run@out{\the\verbatim@line}}%
    \verbatim@start}%
{\immediate\closeout\plt@run@out\@esphack\endgroup%
    \trivlist\item\relax
    \setlength{\plt@run@savefboxrule}{\fboxrule}%
    \setlength{\plt@run@savefboxsep}{\fboxsep}%
    \setlength{\fboxsep}{0.015\textwidth}%
    \setlength{\fboxrule}{0.4pt}%
    \fcolorbox[gray]{0}{0.95}{%
        \begin{minipage}[c]{0.45\textwidth}%
            \setlength{\fboxrule}{\plt@run@savefboxrule}%
            \setlength{\fboxsep}{\plt@run@savefboxsep}%
            \small\verbatiminput{\plt@run@tempname}%
        \end{minipage}%
    }%
    \hfill%
    \fbox{%
        \begin{minipage}[c]{0.45\textwidth}%
            \setlength{\fboxrule}{\plt@run@savefboxrule}%
            \setlength{\fboxsep}{\plt@run@savefboxsep}%
            \setlength{\parskip}{1ex plus 0.4ex minus 0.2ex}%
            \normalsize\input{\plt@run@tempname}%
        \end{minipage}%
    }%
    \endtrivlist
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% verb output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\plt@verb@height}
\setlength{\plt@verb@height}{8.5pt}
\lstset{
    basicstyle=
        \ttfamily
        \fontsize{\the\plt@verb@height}{\the\plt@verb@height*0.95}
        \selectfont,
    breaklines,
    frame=tRBl,
    xleftmargin=2.5em,
}
\renewcommand{\verb}{\lstinline[basicstyle=\ttfamily]}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlist[1]{
    leftmargin = 2\parindent,
    labelsep = 0.5em,
    labelwidth = 1.5em,
    listparindent = 2em,
    align = left,
    itemsep = 0em,
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% color
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\pltrule}{\ \rule{2em}{\heightof{M}}\ }

\newcommand{\pltred}{\color{red!65!black}}
\newcommand{\pltblack}{\color{black}}
\newcommand{\pltblue}{\color{blue!80!black!80!yellow}}
\newcommand{\pltgray}{\color{white!30!black}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\pltpic}[4][0.85]{
    \begin{figure}[htbp]
        \centering
        \fbox{\includegraphics[width=#1\textwidth]{#2}}
        \caption{#3}
        \label{#4}
    \end{figure}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% section title setting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\titleformat{\section}[frame]
    {\normalfont}
    {\filright\bfseries\footnotesize\enspace SECTION \thesection\enspace}
    {4pt}
    {\LARGE\filcenter}
    [\vspace{4pt}]

\titleformat{\subsection}
    {\normalfont}
    {\underline{\bfseries\Large\thesubsection.} }
    {3pt}
    {\Large}

\titleformat{\subsubsection}
    {\normalfont}
    {\underline{\bfseries\normalsize\thesubsubsection.} }
    {2pt}
    {\normalsize}

\titlespacing{\section}{0pt}{7em}{2em}
\titlespacing{\subsection}{0pt}{3em}{1em}
\titlespacing{\subsubsection}{0pt}{1em}{0em}


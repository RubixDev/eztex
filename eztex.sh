#!/bin/bash

EXECUTABLE_NAME="eztex"
EZTEX_VERSION="0.1.4"
TEMPLATES_DIR="/usr/share/$EXECUTABLE_NAME/templates"

bold () { echo -e "\x1b[1m$1\x1b[22m"; }
echo_done () { echo -e "\x1b[1;32m...done\x1b[0m"; }

clear () {
    echo -e "\x1b[36mClearing LaTeX cache files...\x1b[0m"
    shopt -s globstar
    while read -r line; do
        comment_regex='^[ \t]*#|^[ \t]*$'
        [[ ! "$line" =~ $comment_regex  ]] || continue
        # shellcheck disable=SC2086
        rm -v -- $line 2>/dev/null
        # shellcheck disable=SC2086
        rm -v -- **/$line 2>/dev/null
    done << EOF
*.aux
*.lof
*.log
*.lot
*.fls
*.out
*.toc
*.fmt
*.fot
*.cb
*.cb2
.*.lb
*.dvi
*.xdv
*-converted-to.*
.pdf
*.bbl
*.bcf
*.blg
*-blx.aux
*-blx.bib
*.run.xml
*.fdb_latexmk
*.synctex
*.synctex(busy)
*.synctex.gz
*.synctex.gz(busy)
*.pdfsync
latex.out
*.alg
*.loa
acs-*.bib
*.thm
*.nav
*.pre
*.snm
*.vrb
*.soc
*.cut
*.cpt
*.spl
*.ent
*.lox
*.mf
*.mp
*.t[1-9]
*.t[1-9][0-9]
*.tfm
*.end
*.?end
*.[1-9]
*.[1-9][0-9]
*.[1-9][0-9][0-9]
*.[1-9]R
*.[1-9][0-9]R
*.[1-9][0-9][0-9]R
*.eledsec[1-9]
*.eledsec[1-9]R
*.eledsec[1-9][0-9]
*.eledsec[1-9][0-9]R
*.eledsec[1-9][0-9][0-9]
*.eledsec[1-9][0-9][0-9]R
*.acn
*.acr
*.glg
*.glo
*.gls
*.glsdefs
*-gnuplottex-*
*.gaux
*.gtex
*.4ct
*.4tc
*.idv
*.lg
*.trc
*.xref
*.brf
*-concordance.tex
*.tikz
*-tikzDictionary
*.lol
*.idx
*.ilg
*.ind
*.ist
*.maf
*.mlf
*.mlt
*.mtc[0-9]*
*.slf[0-9]*
*.slt[0-9]*
*.stc[0-9]*
_minted*
*.pyg
*.mw
*.nlg
*.nlo
*.nls
*.pax
*.pdfpc
*.sagetex.sage
*.sagetex.py
*.sagetex.scmd
*.wrt
*.sout
*.sympy
sympy-plots-for-*.tex
*.upa
*.upb
*.pytxcode
pythontex-files-*
*.listing
*.loe
*.dpth
*.md5
*.auxlock
*.tdo
*.lod
*.xcp
*.xmpi
*.xdy
*.xyc
*.ttt
*.fff
TSWLatexianTemp*
*.bak
*.bak[0-9]
*.sav
.texpadtmp
*.lyx~
*.backup
*~[0-9]*
#./auto/*
*.el
*-tags.tex
*.sta
__latexindent_temp.tex
EOF
    echo_done
    return 0
}

installed_templates () {
    for template in "$TEMPLATES_DIR"/*; do
        [[ -d "$template" ]] || continue
        echo "- $(basename "$template")"
    done
}

init () {
    if  [[ ! -d "$TEMPLATES_DIR" ]]; then
        echo -e "\x1b[31mThe templates directory at $(bold "$TEMPLATES_DIR") is missing. \
    Please make sure $(bold "$EXECUTABLE_NAME") is correctly installed on your system."
        return 4
    fi
    template="$1"
    [[ -n "$template" ]] || {
        echo -e "\x1b[31mPlease specify a template.\x1b[0m Available templates on your system are:"
        installed_templates
        return 1
    }
    [[ -d "$TEMPLATES_DIR/$template" ]] || {
        echo -e "\x1b[31mThe template $(bold "$template") does not exist in the templates directory.\x1b[0m Available templates on your system are:"
        installed_templates
        return 2
    }
    [[ -z "$(ls -A)" ]] || {
        echo -e "\x1b[31mDirectory is not empty.\x1b[0m"
        return 3
    }

    echo -e "\x1b[36mCopying $(bold "$template") template to $2 directory...\x1b[0m"
    cp -r "$TEMPLATES_DIR/$template"/* ./
    GLOBIGNORE=".:.."
    cp -r "$TEMPLATES_DIR/$template"/.* ./
    echo_done

    if [[ -n "$option_name" ]]; then
        echo -e "\x1b[36mReplacing name placeholder with $(bold "$option_name")...\x1b[0m"
        sed -i -E "s/Name Placeholder|Name Platzhalter/$option_name/" main.tex
        echo_done
    fi
    if [[ -n "$option_date" ]]; then
        echo -e "\x1b[36mReplacing \\\\today with $(bold "$option_date")...\x1b[0m"
        sed -i "s/\\\\today/$option_date/" main.tex
        echo_done
    fi
}

new () {
    template="$1"
    name="$2"
    [[ -n "$name" ]] || {
        echo -e "\x1b[31mNo project name specified\x1b[0m"
        exit 4
    }
    [[ ! -e "$name" ]] || {
        echo -e "\x1b[31mA file or directory with the name $(bold "$name") already exists.\x1b[0m"
        exit 5
    }
    mkdir "$name" || exit 8
    pwd="$PWD"
    cd "$name" || exit 6
    init "$template" "$(bold "$name")" || {
        code="$?"
        cd "$pwd" || exit 7
        rm -r "$name"
        exit "$code"
    }
    echo -e "\x1b[36mReplacing topic placeholder with $(bold "$name")...\x1b[0m"
    sed -i -E "s/Topic Placeholder|Thema Platzhalter/$name/" main.tex
    echo_done
}

save () {
    cp main.pdf "$(basename "$(pwd)")".pdf
}

update () {
    [[ -f /usr/share/eztex/eztex.sh ]] || {
        echo -e "\x1b[31m$(bold "$EXECUTABLE_NAME") seems to be installed from the AUR, self-updates are not supported\x1b[0m"
        exit 1
    }
    sudo bash -c "$(curl -fL 'https://raw.githubusercontent.com/RubixDev/eztex/main/install.sh')"
}

remove () {
    [[ -f /usr/share/eztex/eztex.sh ]] || {
        echo -e "\x1b[31m$(bold "$EXECUTABLE_NAME") seems to be installed from the AUR, self-removal is not supported\x1b[0m"
        exit 1
    }
    sudo bash -c "$(curl -fL 'https://raw.githubusercontent.com/RubixDev/eztex/main/uninstall.sh')"
}

help () {
    echo "$EXECUTABLE_NAME v$EZTEX_VERSION"
    echo "RubixDev"
    echo "A CLI tool for quickly starting new LaTeX projects"
    echo
    echo "USAGE:"
    echo "    $EXECUTABLE_NAME [OPTIONS] COMMAND ...ARGS"
    echo
    echo "OPTIONS:"
    printf "    %-15s%-20s%s\n" "-n | --name" "NAME" "A name used to directly replace the name placeholder on initialization of a project"
    printf "    %-15s%-20s%s\n" "-d | --date" "DATE" "A date to use instead of \\today"
    echo
    echo "COMMANDS:"
    printf "    %-15s%-20s%s\n" "i | init"   "TEMPLATE"       "Initializes a new LaTeX project based on TEMPLATE in the current directory"
    printf "    %-15s%-20s%s\n" "c | clear"  ""               "Clears the current LaTeX project of cache files"
    printf "    %-15s%-20s%s\n" "n | new"    "TEMPLATE  NAME" "Creates a new LaTeX project in a new directory called NAME based on TEMPLATE"
    printf "    %-15s%-20s%s\n" "s | save"   ""               "Copies the main.pdf to a PDF with the name of the current directory"
    printf "    %-15s%-20s%s\n" "u | update" ""               "Try to update eztex to the newest version from GitHub"
    printf "    %-15s%-20s%s\n" "r | remove" ""               "Try to remove eztex from the system"
    printf "    %-15s%-20s%s\n" "h | help"   ""               "Shows this message"
}

####################################

other_args=()
option_name=""
option_date=""
while [ $# -gt 0 ]; do
    case "$1" in
        -n | --name ) option_name="$2"; shift 2 ;;
        -d | --date ) option_date="$2"; shift 2 ;;
        * ) other_args+=("$1"); shift ;;
    esac
done

case "${other_args[0]}" in
    i | init   ) init "${other_args[1]}" current || exit "$?" ;;
    c | clear  ) clear ;;
    n | new    ) new "${other_args[1]}" "${other_args[2]}" ;;
    s | save   ) save ;;
    u | update ) update ;;
    r | remove ) remove ;;
    h | help   ) help ;;
    * ) echo -e "\x1b[31mUnknown command '$(bold "${other_args[0]}")'\x1b[0m"; help ;;
esac

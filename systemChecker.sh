#!/bin/bash

###================================###
# James R. Stoup
# systemChecker.sh
# 01 JUN 2013
###================================###






##################################################
# Color printing
##################################################
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

function red() { 
    echo -e "$RED$*$NORMAL" 
}

function green() {
    echo -e "$GREEN$*$NORMAL"
}

function yellow() {
    echo -e "$YELLOW$*$NORMAL"
}


##################################################
# Print help menu
##################################################
function printHelp() {
cat << EOF

  Usage: jsyscheck.sh [OPTION]...
  
  Checks installed software on current system to determine if it 
  is ready for JSAF development or exercise support. 
  
  Available Commands
  
      -h, --help         prints this message
      -v, --version      prints version
      -d, --dev          checks if system is properly configured for developers
      -u, --user         checks if system is properly configured for users
      -a, --add          adds aliases, symlinks and other functionality to system


EOF
}


##################################################
# Print version
##################################################
function printVersion() {
    cat << EOF
VERSION: 2.1 (Boomstick)
EOF
}



#==============================================================================#
#                              Checker Functions
#==============================================================================#

##################################################
# Check the /usr/ncte directories exist
##################################################
function checkDirs() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] && [ $1 != "user" ] ; then
	return
    fi

    NCTE_DIR0="/usr/ncte"
    NCTE_DIR1="/usr/ncte/devel"
    NCTE_DIR2="/usr/ncte/environmentals"
    NCTE_DIR3="/usr/ncte/external"
    NCTE_DIR4="/usr/ncte/releases"
    NCTE_DIR5="/usr/ncte/terrain"

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi


    XPAD="                    "
    if [ -d "$NCTE_DIR0" ]; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR0 $XPAD "
	green "[SUCCESS]"    
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR0 $XPAD "
	red "[!!! FAILURE !!!]"
    fi

    XPAD="              "
    if [ -d "$NCTE_DIR1" ]; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR1 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR1 $XPAD "
	red "[!!! FAILURE !!!]"
    fi

    XPAD="     "
    if [ -d "$NCTE_DIR2" ]; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR2 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR2 $XPAD "
	red "[!!! FAILURE !!!]"
    fi

    XPAD="           "
    if [ -d "$NCTE_DIR3" ]; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR3 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR3 $XPAD "
	red "[!!! FAILURE !!!]"
    fi

    XPAD="           "
    if [ -d "$NCTE_DIR4" ]; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR4 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR4 $XPAD "
	red "[!!! FAILURE !!!]"
    fi

    XPAD="            "
    if [ -d "$NCTE_DIR5" ]; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR5 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for $NCTE_DIR5 $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}


##################################################
# Check the terrain is installed
##################################################
function checkTerrain() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] && [ $1 != "user" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    TERRAIN_CHECK=`ls /usr/ncte/terrain/ | grep \.dir$ | wc -l`
    XPAD="                "

    if [ $TERRAIN_CHECK -ge 1 ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for valid Terrain $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for valid Terrain $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}


##################################################
# Check that the ssh keys are there
##################################################
function checkSSH() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    SSH=`ls ~/.ssh | grep id_rsa\.pub | wc -l`
    XPAD="                     "

    if [ $SSH == 1 ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for SSH Keys $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for SSH Keys $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}


##################################################
# Check that RHEL Subscriptions are enabled              !!!!!!!!  NEED SUDO   !!!!!!!!
##################################################
function checkRHN() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    REPO_STATUS=`sudo yum repolist | grep "This system is receiving updates from RHN Classic or RHN Satellite"`
#REPO_STATUS=`yum repolist | grep "This system is receiving updates from RHN Classic or RHN Satellite"`
    REPO_GOOD="This system is receiving updates from RHN Classic or RHN Satellite."
    XPAD="                  "

    if [ "$REPO_STATUS" == "$REPO_GOOD" ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for RHN Updates $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for Updates $XPAD "
	red "[!!! FAILURE !!!]  --- Not receiving RHN updates"
    fi
}


##################################################
# Check that motif 2.3.3-5 is installed
##################################################
function checkMotif() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] && [ $1 != "user" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    MOTIF_VERSION=`rpm -qa | grep motif | grep -v devel | grep -v debug`
    GOOD_VERSION="openmotif-2.3.3-5.el6_3.x86_64"
    XPAD="                "

    if [ $MOTIF_VERSION == $GOOD_VERSION ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for Motif 2.3.3-5 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for Motif 2.3.3-5 $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}


##################################################
# Check the correct version of git is installed
##################################################
function checkGit() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    GIT_VERSION=`git --version | cut -d " " -f3`
    GIT_V1=`git --version | cut -d " " -f3 | cut -d "." -f1`
    GIT_V2=`git --version | cut -d " " -f3 | cut -d "." -f2`
    XPAD="                      "

    if [ $GIT_V1 == 1 ] && [ $GIT_V2 == 8 ]; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for Git 1.8 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for Git 1.8 $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}


##################################################
# Check that Glade is installed
##################################################
function checkGlade() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    GLADE3=`glade-3 --version`
    GLADE3_GOOD="glade3 3.6.7"
    XPAD="                  "

    if [ "$GLADE3" == "$GLADE3_GOOD" ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for Glade 3.6.7 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for Glade 3.6.7 $XPAD "
	red "[!!! FAILURE !!!]  --- Wrong Version Installed"
    fi
}


##################################################
# Check that the TCI plugins have been built
##################################################
function checkPlugins() {

    # Check to see if this is needed user or dev
#    if [ $1 != "dev" ] && [ $1 != "user" ] ; then
#	return
#    fi

#this is still a work in progress

#CATALOGS=`ls -1 /usr/local/share/glade3 | grep catalogs`
#PIXMAPS=`ls -1 /usr/local/share/glade3 | grep pixmaps`
#MODULES=`ls /usr/local/lib/glade3/modules/ -1 | grep libtcicompositewidgets | head -1`

#CAT_PATH=`find / -path '*/glade3/catalogs'`
#PIX_PATH=`find / -path '*/glade3/pixmaps'`
#MOD_PATH=`find / -path '*/glade3/modules'`

#CATALOGS_GOOD="catalogs"
#PIXMAPS_GOOD="pixmaps"
#MODULES_GOOD="libtcicompositewidgets.so"

    XPAD="                  "

#if [ "$CATALOGS" == "$CATALOGS_GOOD" ] &&
#   [ "$PIXMAPS" == "$PIXMAPS_GOOD" ] &&
#   [ "$MODULES" == "$MODULES_GOOD" ] ; then
#    echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for TCI Widgets $XPAD "
#    green "[SUCCESS]"
#else
#    echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for TCI Widgets $XPAD "
#        red "[!!! FAILURE !!!]"
#fi
}


##################################################
# Check that DDD is installed
##################################################
function checkDDD() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    DDD=`ddd --version | head -1 | cut -d " " -f3`
    DDD_GOOD="3.3.11"
    XPAD="                   "

    if [ "$DDD" == $DDD_GOOD ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for DDD 3.3.11 $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for DDD 3.3.11 $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}


##################################################
# Check that GDB is installed
##################################################
function checkGDB() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] && [ $1 != "user" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    GDB=`gdb --version | head -1 | grep "(GDB)" | wc -l`
    XPAD="                          "

    if [ "$GDB" == 1 ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for GDB $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for GDB $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}


##################################################
# Check that texi2html is installed
##################################################
function checkTexi() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    TEXI2HTML=`rpm -qa | grep texi2html | cut -d "-" -f1`
    TEXI_GOOD="texi2html"
    XPAD="                    "

    if [ "$TEXI2HTML" == "$TEXI_GOOD" ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for texi2html $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for texi2html $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}


##################################################
# Check that ccache is installed
##################################################
function checkCcache() {

    # Check to see if this is needed user or dev
    if [ $1 != "dev" ] ; then
	return
    fi

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi

    TEXI2HTML=`rpm -qa | grep ccache | cut -d "-" -f1`
    TEXI_GOOD="ccache"
    XPAD="                       "
    
    if [ "$TEXI2HTML" == "$TEXI_GOOD" ] ; then
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for ccache $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Looking for ccache $XPAD "
	red "[!!! FAILURE !!!]"
    fi
}




#==============================================================================#
#                              Fixer Functions
#==============================================================================#

##################################################
# Add bash JSAF aliases
##################################################
function addAliases() {

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi
    XPAD="         "

    DoneThisBefore=`grep "# Automatically Added Statements" ~/bin/checkME | head -1`
    DTB="# Automatically Added Statements"

    if [ "$DoneThisBefore" != "$DTB" ] ; then
	TARGET_FILE="checkME"
	NAME=`whoami`

	echo "" >> ~/bin/$TARGET_FILE
	echo "# Automatically Added Statements" >> ~/bin/$TARGET_FILE
	echo "export RTI_MULTICAST_INTERFACE=lo"  >> ~/bin/$TARGET_FILE

	STR1="alias jf=\"gdb -ex run --args ./jsaf -fedex $NAME -federation ntf -nosim\""
	echo $STR1 >> ~/bin/$TARGET_FILE

	STR2="alias jb=\"gdb -ex run --args ./jsaf -fedex $NAME -federation ntf -nogui\""
	echo $STR1 >> ~/bin/$TARGET_FILE

	STR3="alias tci=\"gdb -ex run --args ./tci -fedex $NAME -federation ntf\""
	echo $STR1 >> ~/bin/$TARGET_FILE

	echo -n "$PAD1 [$[CNTR++]]$PAD2 Adding JSAF aliases to ~/.bashrc $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Adding JSAF aliases to ~/.bashrc $XPAD "
	yellow "[Not Needed]"
    fi
}


##################################################
# Add Git aliases
##################################################
function addGitAliases() {

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi
    XPAD="       "

    DoneThisBefore=`grep "# Automatically Generated Statements" ~/bin/checkME | head -1`
    DTB="# Automatically Generated Statements"

    if [ "$DoneThisBefore" != "$DTB" ] ; then
	TARGET_FILE="checkME"

	echo "" >> ~/bin/$TARGET_FILE
	echo "# Automatically Generated Statements" >> ~/bin/$TARGET_FILE
	echo "[color]" >> ~/bin/$TARGET_FILE
	echo "        ui = true"  >> ~/bin/$TARGET_FILE
	echo "[alias]" >> ~/bin/$TARGET_FILE
	echo "  ls       = log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate" >> ~/bin/$TARGET_FILE
	echo "  ll	   = log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --numstat" >> ~/bin/$TARGET_FILE
	echo "  stage    = add" >> ~/bin/$TARGET_FILE
	echo "  unstage  = reset HEAD" >> ~/bin/$TARGET_FILE

	echo -n "$PAD1 [$[CNTR++]]$PAD2 Adding Git aliases to ~/.gitconfig $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Adding Git aliases to ~/.gitconfig $XPAD "
	yellow "[Not Needed]"
    fi
}


##################################################
# Add XChat Log Link
##################################################
function addXChatLink() {

    PAD1=""
    if [ $CNTR -lt 10 ] ; then
	PAD1="    "
    else
	PAD1="   "
    fi
    XPAD="              "

    SYMLINK=~/xchatlogs

    if [ ! -h "$SYMLINK" ] ; then
	ln -s ~/.xchat2/xchatlogs ~/xchatlogs
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Creating an xchat logs link $XPAD "
	green "[SUCCESS]"
    else
	echo -n "$PAD1 [$[CNTR++]]$PAD2 Creating an xchat logs link $XPAD "
	yellow "[Not Needed]"
    fi
}




##################################################
# Start of script
##################################################
CNTR=1

# Parse command line args
if [ $# -lt 1 ] ; then
    printHelp
    exit 0
fi

devSelected=0
userSelected=0
addFunctionality=0

for i in $*
do
	case $i in
#    	-p=*|--prefix=*)
#	        PREFIX=${i#*=}
#		;;
    	-h|--help)
		printHelp
		exit 0
		;;
    	-v|--version)
		printVersion
		exit 0
		;;
    	-d|--dev)
		checkType="dev"
		devSelected=1
		;;
    	-u|--user)
		checkType="user"
		userSelected=1
		;;
    	-a|--add)
		addFunctionality=1
		;;

    	*)
                # unknown args
		echo ""
		echo "!!! ERROR: Must select valid check type !!!"
		echo ""
		printHelp
		exit 0
		;;
  	esac
done

# Sanity checks
if [ $devSelected == 1 ] && [ $userSelected == 1 ] ; then
    echo ""
    echo "!!! ERROR: Can't check for both devs and users at once !!!"
    echo ""
    printHelp
    exit 0
fi

if [ $devSelected == 0 ] && [ $userSelected == 0 ] ; then
    echo ""
    echo "!!! ERROR: Must check for either devs and users !!!"
    echo ""
    printHelp
    exit 0
fi

echo ""
echo "  ==============================="
echo "  === Starting System Checker ==="
echo "  ==============================="
echo ""
echo ""
echo "   -----------------------"
echo "   Checking System Status"
echo "   -----------------------"

# Call check functions
checkDirs    $checkType
checkTerrain $checkType
checkSSH     $checkType
checkRHN     $checkType
checkMotif   $checkType
checkGit     $checkType
checkGlade   $checkType
checkPlugins $checkType
checkDDD     $checkType
checkGDB     $checkType
checkTexi    $checkType
checkCcache  $checkType

echo ""
echo ""

if [ $checkType == "dev" ] && [ $addFunctionality == 1 ]; then
    CNTR=1
    echo "   -----------------------"
    echo "   Adding System Features"
    echo "   -----------------------"

    addAliases
    addGitAliases
    addXChatLink
    
    echo ""
fi



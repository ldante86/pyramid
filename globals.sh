#!/bin/echo This file is a part of pyramid

PROGRAM="${0##*/}"		# Program name
TPOINT=2			# Two points for two card removal
KPOINT=1			# One point for King removal
MODE_0=0			# Easy mode
MODE_1=1			# Hard mode
THIRTEEN=13			# 13!
PYRAMID_DIR=~/.pyramid		# Location for score file
SCORE_FILE=pyramid-scores	# Score file
PLAYER=$(whoami)		# Player's name
#PLAYER=$(id -un)		# Player's name
ENDING=("" lost won aborted)	# End messages
END=				# End status
BO=$(tput bold)			# Bold on
LD=$(tput sgr0)			# Bold off
declare -l X Y			# Game-plays are lower case
DRAW_STACK=()			# Draw card stack
INDEX=()			# List of playable cards
GAME_OVER=0			# 0=continue 1=lose 2=win 3=quit
SCORE=0				# Score counter

SP="   "			# 3
SP7="    "			# 4
SP6="      "			# 6
SP5="        "			# 8
SP4="          "		# 10
SP3="            "		# 12
SP2="              "		# 14
SP1="                "		# 16

PYRAMID="\
\n
${SP1}%s
${SP2}%s${SP}%s
${SP3}%s${SP}%s${SP}%s
${SP4}%s${SP}%s${SP}%s${SP}%s
${SP5}%s${SP}%s${SP}%s${SP}%s${SP}%s
${SP6}%s${SP}%s${SP}%s${SP}%s${SP}%s${SP}%s
${SP7}%s${SP}%s${SP}%s${SP}%s${SP}%s${SP}%s${SP}%s
\n\n"

# Default initialization:
SHOW_INDEX=0	# show index: on
GAME_MODE=0	# game mode: easy
MODE=easy	# name of mode
unset DEBUG	# debug: off

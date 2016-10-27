#!/bin/echo This file is a part of pyramid

_load_deck()
{
    DECK=(2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6
          7 7 7 7 8 8 8 8 9 9 9 9 T T T T
          J J J J Q Q Q Q K K K K A A A A)
}

_update_deck()
{
    while true
    do
      for ((t=0; t<${#DECK[@]}; t++))
      do
        if [ "${DECK[t]}" = "$1" ]; then
          unset DECK[t]
          break 2
        fi
      done
    done

    DECK=( "${DECK[@]}" )
}

_get_card_number()
{
    case $1 in
      [Kk])  echo $THIRTEEN ;;
      [Qq])  echo 12 ;;
      [Aa])  echo 1 ;;
      [Jj])  echo 11 ;;
      [Tt])  echo 10 ;;
      *   )  echo $1 ;;
    esac
}

_draw_card()
{
    CARD="${DECK[$((RANDOM % ${#DECK[@]}))]}"
    _update_deck $CARD
}

_reload_draw_stack()
{
    DECK=( "${DRAW_STACK[@]}" )
    DRAW_STACK=()
}

_draw_pyramid()
{
    local data=()

    for i in $a1l $b2l $b3l $c4l $c5l $c6l $d7l $d8l \
             $d9l  $d10l $e11l $e12l $e13l $e14l $e15l \
             $f16l $f17l $f18l $f19l $f20l $f21l \
             $g22l $g23l $g24l $g25l $g26l $g27l $g28l
    do
      if [[ $i != [#-] ]]; then
        data+=(${BO}${i}${LD})
      else
        data+=(${i})
      fi
    done

    printf "$PYRAMID" "${data[@]}"
}

_assemble_pyramid()
{
    _draw_card && eval a1=$CARD
    for i in {2..3}   ; do _draw_card && eval b${i}=$CARD; done
    for i in {4..6}   ; do _draw_card && eval c${i}=$CARD; done
    for i in {7..10}  ; do _draw_card && eval d${i}=$CARD; done
    for i in {11..15} ; do _draw_card && eval e${i}=$CARD; done
    for i in {16..21} ; do _draw_card && eval f${i}=$CARD; done
    for i in {22..28} ; do _draw_card && eval g${i}=$CARD; done

    a1l=#
    b2l=#  b3l=#
    c4l=#  c5l=#  c6l=#
    d7l=#  d8l=#  d9l=#  d10l=#
    e11l=# e12l=# e13l=# e14l=# e15l=#
    f16l=# f17l=# f18l=# f19l=# f20l=# f21l=#
    g22l=${g22} g23l=${g23} g24l=${g24} g25l=${g25}
    g26l=${g26} g27l=${g27} g28l=${g28}
}

_uncover_cards()
{
    if [ "$a1l" = "-" ]; then
      _draw_pyramid
      _game_over 2
    fi

    [ "$b2l" = "-" -a "$b3l" = "-" ] && a1l=$a1

    [ "$c4l" = "-" -a "$c5l" = "-" ] && b2l=$b2
    [ "$c5l" = "-" -a "$c6l" = "-" ] && b3l=$b3

    [ "$d7l" = "-" -a "$d8l" = "-" ] && c4l=$c4
    [ "$d8l" = "-" -a "$d9l" = "-" ] && c5l=$c5
    [ "$d9l" = "-" -a "$d10l" = "-" ] && c6l=$c6

    [ "$e11l" = "-" -a "$e12l" = "-" ] && d7l=$d7
    [ "$e12l" = "-" -a "$e13l" = "-" ] && d8l=$d8
    [ "$e13l" = "-" -a "$e14l" = "-" ] && d9l=$d9
    [ "$e14l" = "-" -a "$e15l" = "-" ] && d10l=$d10

    [ "$f16l" = "-" -a "$f17l" = "-"  ] && e11l=$e11
    [ "$f17l" = "-" -a "$f18l" = "-"  ] && e12l=$e12
    [ "$f18l" = "-" -a "$f19l" = "-"  ] && e13l=$e13
    [ "$f19l" = "-" -a "$f20l" = "-"  ] && e14l=$e14
    [ "$f20l" = "-" -a "$f21l" = "-"  ] && e15l=$e15

    [ "$g22l" = "-" -a "$g23l" = "-" ] && f16l=$f16
    [ "$g23l" = "-" -a "$g24l" = "-" ] && f17l=$f17
    [ "$g24l" = "-" -a "$g25l" = "-" ] && f18l=$f18
    [ "$g25l" = "-" -a "$g26l" = "-" ] && f19l=$f19
    [ "$g26l" = "-" -a "$g27l" = "-" ] && f20l=$f20
    [ "$g27l" = "-" -a "$g28l" = "-" ] && f21l=$f21
}

_load_index()
{
    local x=0
    INDEX=()

    [[ $a1l != [#-] ]] && INDEX[x++]=a1

    [[ $b2l != [#-] ]] && INDEX[x++]=b2
    [[ $b3l != [#-] ]] && INDEX[x++]=b3

    [[ $c4l != [#-] ]] && INDEX[x++]=c4
    [[ $c5l != [#-] ]] && INDEX[x++]=c5
    [[ $c6l != [#-] ]] && INDEX[x++]=c6

    [[ $d7l != [#-] ]] && INDEX[x++]=d7
    [[ $d8l != [#-] ]] && INDEX[x++]=d8
    [[ $d9l != [#-] ]] && INDEX[x++]=d9
    [[ $d10l != [#-] ]] && INDEX[x++]=d10

    [[ $e11l != [#-] ]] && INDEX[x++]=e11
    [[ $e12l != [#-] ]] && INDEX[x++]=e12
    [[ $e13l != [#-] ]] && INDEX[x++]=e13
    [[ $e14l != [#-] ]] && INDEX[x++]=e14
    [[ $e15l != [#-] ]] && INDEX[x++]=e15

    [[ $f16l != [#-] ]] && INDEX[x++]=f16
    [[ $f17l != [#-] ]] && INDEX[x++]=f17
    [[ $f18l != [#-] ]] && INDEX[x++]=f18
    [[ $f19l != [#-] ]] && INDEX[x++]=f19
    [[ $f20l != [#-] ]] && INDEX[x++]=f20
    [[ $f21l != [#-] ]] && INDEX[x++]=f21

    [[ $g22l != [#-] ]] && INDEX[x++]=g22
    [[ $g23l != [#-] ]] && INDEX[x++]=g23
    [[ $g24l != [#-] ]] && INDEX[x++]=g24
    [[ $g25l != [#-] ]] && INDEX[x++]=g25
    [[ $g26l != [#-] ]] && INDEX[x++]=g26
    [[ $g27l != [#-] ]] && INDEX[x++]=g27
    [[ $g28l != [#-] ]] && INDEX[x++]=g28
}

_record()
{
    if [ $SCORE -lt 10 ] || [ $NO_RECORD ]; then
      return
    fi
    local date=$(date)
    local data="$date | $PLAYER | $SCORE | $MODE | $END"
    if [ -d ${PYRAMID_DIR} ]; then
      echo "$data" >> ${PYRAMID_DIR}/${SCORE_FILE}
    else
      mkdir -p ${PYRAMID_DIR}
      _record
    fi
}

_debug()
{
    echo -n "    Pyramid: $a1 $b2 $b3 $c4 $c5 $c6 $d7 $d8 $d9 "
    echo -n "$d10 $e11 $e12 $e13 $e14 $e15 "
    echo -n "$f16 $f17 $f18 $f19 $f20 $f21 $g22 $g23 "
    echo "$g24 $g25 $g26 $g27 $g28"
    echo "    Draw stack: ${DRAW_STACK[@]}"
    echo "    Draw stack size: ${#DRAW_STACK[@]}"
    echo "    Index: ${INDEX[@]}"
    echo "    Deck: ${DECK[@]}"
    echo "    Deck size: ${#DECK[@]}"
    echo
}

_play_again()
{
    if [ $1 ]; then
      X=$1
    else
      printf "\n    %s" "Play again? [y/n]: " ; read -n1 X
    fi
    case $X in
      y)
        echo
        echo "    Generating new game..."
        _load_deck
        _assemble_pyramid
        unset END
        unset DRAW_STACK
        unset INDEX
        GAME_OVER=0
        SCORE=0
        clear
        return
        ;;
      n|*)
        NO_RECORD=1
        _game_over 3
        _exit 0
        ;;
    esac
}

_game_over()
{
    echo
    echo
    END="${ENDING[$1]}"
    _record
    case $1 in
      1)  echo "    ${BO}OUT OF CARDS - GAME OVER${LD}"
          _play_again
          ;;
      2)  echo "    ${BO}YOU WIN!!!${LD}"
          echo "    ${BO}SCORE: $SCORE${LD}"
          _play_again
          ;;
      3)  echo "    ${BO}GOODBYE - PLAY AGAIN SOMETIME!${LD}"
          _exit 0
          ;;
    esac
}

_help()
{
	cat <<-eof

	 PROGRAM: ${PROGRAM} - a solitaire game
	 AUTHOR: Luciano D. Cecere
	 LICENSE: GPLv2
	 DESCRIPTION: The object of the game is to remove all the
	 cards from the pyramid. Cards are removed when two selected
	 cards equal 13. K=13, Q=12, J=11, T=10, A=1.

	 USAGE: ${PROGRAM} [option]

	 OPTIONS:
	   easy		easy mode: the draw pile loops (default)
	   hard		hard mode: the draw pile passes once
	   -c		clear score file
	   -d		debug mode
	   -h		view this screen and exit
	   -n		suppress coordinate list
	   -s		view score file
	   --no-splash  Do not show spash screen

	 In-game commands:
	   ? | h	hint
	   q | ctrl-c	quit
	   n		new game
	   d		debug on
	   f		debug off
	   i		show coordinates on
	   o		show coordinates off

	 Full gameplay instructions can be found in the README
	 which should have accompanied this program.

	eof
    _exit 0
}

_exit()
{
    echo
    stty sane
    stty echo
    printf "\e[?12l\e[?25h"
    exit $1
}

_splash()
{
    clear
    printf "\e[?25l"
	cat <<-eof

	 ###############################
	 #              #              #
	 #            #   #            #
	 #          #   #   #          #
	 #        #   #   #   #        #
	 #      #   #   #   #   #      #
	 #    #   #   #   #   #   #    #
	 #  ${BO}?   ?   ?   ?   ?   ?   ?${LD}  #
	 #                             #
	 #      ${BO}PYRAMID SOLITAIRE${LD}      #
	 #                             #
	 #   A = 1       ? - hint      #
	 #   T = 10      q - quit      #
	 #   J = 11      n - new game  #
	 #   Q = 12      d - debug on  #
	 #   K = 13      f - debug off #
	 #               i - list on   #
	 #               o - list off  #
	 #                             #
	 #         MODE: ${BO}${MODE}${LD}          #
	 ###############################
	eof
    read -sn1
    printf "\e[?12l\e[?25h"
}

#!/bin/echo This file is a part of pyramid

_process_move()
{
    local XX YY C1 C2

    if [ $DEBUG ]; then
      _debug
    fi
    if [ ${#DRAW_STACK[@]} -eq 0 ]; then
      echo "    Draw: ${BO}-${LD}       Score: $SCORE"
    else
      echo "    Draw: ${BO}${DRAW_STACK[-1]}${LD}	Score: $SCORE"
    fi
    if [ $SHOW_INDEX ]; then
      _show_index()
      {
        echo
        for ((z=0; z<${#INDEX[@]}; z++))
        do
          echo -n "    ${BO}${z}${LD} = "
          eval echo "\$${INDEX[z]} '('${INDEX[z]}')'"
        done
        echo
      }
    else
      _show_index() { echo ; }
    fi
    _show_index
    printf "    %s" "Select: " ; read X Y
    if [[ $X = [0-6] ]]; then
      X="${INDEX[X]}"
    fi
    if [[ $Y = [0-6] ]]; then
      Y="${INDEX[Y]}"
    fi
    C1=$X
    C2=$Y
    X=$(eval echo \$$X)
    Y=$(eval echo \$$Y)
    if [[ $C1 = [?hH] ]] && [ -z "$C2" ]; then
      for ((b=0; b<${#INDEX[@]}; b++))
      do
        _generate_hint $b
        if [ $? -ne 0 ]; then
          break
        fi
      done
      if [ ! -z "$HINT" ]; then
        echo "    Hint: $HINT"
        unset HINT
        read -sn1
        return
      else
        echo "    Draw a card"
        read -sn1
        return
      fi
    fi
    if [ "$C1" ] && [ -z "$C2" ]; then
      case $C1 in
        [Ii])  SHOW_INDEX=1 ;;
        [Oo])  unset SHOW_INDEX ;;
        [Dd])  DEBUG=1 ;;
        [Ff])  unset DEBUG ;;
        [Qq])  _game_over 3 ;;
        [Nn])  _play_again y ;; # Force 'yes'
      esac
    fi
    if [[ $X = [Kk] ]] && [ -z "$C2" ]; then
      eval ${C1}l="-"
      eval ${C1}="-"
      ((SCORE+=KPOINT))
      return
    fi
    if [[ $C1 = [Xx] ]] && [ -z "$C2" ]; then
      X=$(_get_card_number $CARD)
      if [ $X -eq $THIRTEEN ]; then
        unset DRAW_STACK[-1]
        ((SCORE+=KPOINT))
        return
      fi
    fi
    if [ -z "$C1" ] && [ -z "$C2" ]; then
      if [ "${#DECK[@]}" -gt 0 ]; then
        _draw_card
        DRAW_STACK+=($CARD)
        return
      elif [ $GAME_MODE -eq $MODE_0 ]; then
        _reload_draw_stack
        _draw_card
         DRAW_STACK+=($CARD)
        return
      else
        _game_over 1
      fi
    fi
    if [ ! -z "$C1" ] && [ ! -z "$C2" ]; then
      for ((r=0; r<${#INDEX[@]}; r++))
      do
        if [ "${INDEX[r]}" = "$C1" ]; then
          XX=$(_get_card_number $X)
        fi
      done
      if [ $# -ne 0 ]; then
        return
      fi
      for ((r=0; r<${#INDEX[@]}; r++))
      do
        if [ "${INDEX[r]}" = "$C2" ]; then
          YY=$(_get_card_number $Y)
        fi
      done
      if [ $# -ne 0 ]; then
        return
      fi
    fi
    if [[ $C1 = [Xx] ]] && [ ! -z "$C2" ]; then
      CARD="${DRAW_STACK[-1]}"
      if [ "$CARD" = "-" ]; then
        return
      fi
      XX=$(_get_card_number $CARD)
      for ((r=0; r<${#INDEX[@]}; r++))
      do
        if [ "${INDEX[r]}" = "$C2" ]; then
          YY=$(_get_card_number $Y)
          if [ $((XX + YY)) -eq $THIRTEEN ]; then
            eval ${C2}l="-"
            eval ${C2}="-"
            unset DRAW_STACK[-1]
            ((SCORE+=TPOINT))
            return
          fi
        fi
      done
      return
    fi
    if [[ $C2 = [Xx] ]] && [ ! -z "$C1" ]; then
      CARD="${DRAW_STACK[-1]}"
      if [ "$CARD" = "-" ]; then
        return
      fi
      XX=$(_get_card_number $CARD)
      for ((r=0; r<${#INDEX[@]}; r++))
      do
        if [ "${INDEX[r]}" = "$C1" ]; then
          YY=$(_get_card_number $X)
          if [ $((XX + YY)) -eq $THIRTEEN ]; then
            eval ${C1}l="-"
            eval ${C1}="-"
            unset DRAW_STACK[-1]
            ((SCORE+=TPOINT))
            return
          fi
        fi
      done
      return
    fi
    if [ $((XX + YY)) -eq $THIRTEEN ]; then
      eval ${C1}l="-"
      eval ${C2}l="-"
      eval ${C1}="-"
      eval ${C2}="-"
      ((SCORE+=TPOINT))
      return
    fi
}

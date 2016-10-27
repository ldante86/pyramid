#!/bin/echo This file is a part of pyramid

_generate_hint()
{
    local x=$1 X XX C1 C2 Y YY y

    y=0
    for ((c=0; c<${#INDEX[@]}; c++))
    do
      X="${INDEX[x]}"
      C1=$X
      X=$(eval echo \$$X)

      if [[ $X = [Kk] ]]; then
        HINT="${C1}(${BO}${x}${LD})"
        return 1
      fi

      ((++y))
    done

    if [ ${#DRAW_STACK[@]} -eq 0 ]; then
      CARD="-"
    else
      CARD="${DRAW_STACK[-1]}"
    fi

    if [[ $CARD = [Kk] ]]; then
      HINT="${BO}x${LD}"
      return 1
    fi

    y=0
    for ((c=0; c<${#INDEX[@]}; c++))
    do
      X="${INDEX[x]}"
      C1=$X
      X=$(eval echo \$$X)
      XX=$(_get_card_number $X)
      Y="${INDEX[y]}"
      C2=$Y
      Y=$(eval echo \$$Y)
      YY=$(_get_card_number $Y)

      if [ $(( $XX + $YY )) -eq $THIRTEEN ]; then
        HINT="${C1}(${BO}${x}${LD}) ${C2}(${BO}${y}${LD})"
        return 1
      fi

      ((++y))
    done

    y=0
    for ((c=0; c<${#INDEX[@]}; c++))
    do
      if [ "$CARD" = "-" ]; then
        break
      fi

      X=$(eval echo \$$CARD)
      XX=$(_get_card_number $CARD)
      Y="${INDEX[y]}"
      C2=$Y
      Y=$(eval echo \$$Y)
      YY=$(_get_card_number $Y)

      if [ $(( $XX + $YY )) -eq $THIRTEEN ]; then
        HINT="${BO}x${LD} ${C2}(${BO}${y}${LD})"
        return 1
      fi

      ((++y))
    done
}

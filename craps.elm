import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Random

-- what started as Elm tutorial code with added reset button
-- has turned into an attempt to simulate a simple craps table
-- starting with the pass line bet and may add more later
main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


-- MODEL
-- When a new round starts, the first roll is called a come out Roll
--if 7 or 11 is rolled, you win
--if 2 3 12 is rolled, you lose
-- if 4,5,6,8,9,10 is rolled, you go to a point round
--if in point round, you have a point (the roll that got you to the round)
--in order to win, you must roll the point again before rolling a 7



type Status = Come | Point

type alias Model =
  { point : Int
  , cash : Int
  , status : Status
  , bet : Int
  }

init : Model
init =
  { point = 0
  , cash = 100
  , status = Come
  , bet = 0}


-- UPDATE

type Msg = Bet | Roll | NewFace | Reset

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Bet ->
      (model.bet + 1, Cmd.none)
      (model.cash - 1, Cmd.none)

    Roll ->
      (model, Cmd.none)

    Reset ->
      (init, Cmd.none)

makeBet : Msg -> Model -> (Model, Cmd Msg)
makeBet bet cmodel =
  cmodel.bet + 1
  cmodel.cash - 1


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Bet ] [ text "Increase Bet $1" ]
    , div [] [ text (toString model.cash) ]
    , div [] [ text (toString model.bet)  ]
    , button [ onClick Roll ] [ text "Roll Die" ]
    , button [ onClick Reset ] [ text "Reset Game"]
    ]

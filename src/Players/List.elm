module Players.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Player)
import RemoteData exposing (WebData)
import Routing exposing (playerPath)

view : WebData (List Player) -> Html Msg
view response =
  div []
      [ nav
      , maybeList response
      ]

nav : Html Msg
nav =
  div [ class "clearfix mb2 white bg-black" ]
      [ div [ class "left p2" ] [ text "Players" ]]

list : List Player -> Html Msg
list players =
  div [ class "p2" ]
      [ table []
        [ thead []
          [ tr []
            [ th [] [ text "Id" ]
            , th [] [ text "Name" ]
            , th [] [ text "Level" ]
            , th [] [ text "Actions" ]
            ]
          ]
          , tbody [] (List.map playerRow players)
        ]
      ]

playerRow : Player -> Html Msg
playerRow player =
  tr []
     [ td [] [ text (toString player.id) ]
     , td [] [ text player.name ]
     , td [] [ text (toString player.level) ]
     , td []
        [ editBtn player ]
     ]

maybeList : WebData (List Player) -> Html Msg
maybeList response =
  case response of
    RemoteData.NotAsked ->
      text ""

    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success players ->
      list players

    RemoteData.Failure error ->
      text (toString error)

editBtn : Player -> Html.Html Msg
editBtn player =
  let
    path =
      playerPath player.id
  in
    a
      [ class "btn regular"
      , href path
      ]
      [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]
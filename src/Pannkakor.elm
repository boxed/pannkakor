module Pannkakor exposing (..)

import Browser
import Html exposing (Html, div, text, button, h1)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Round


main =
    Browser.sandbox { init = 3, view = view, update = update }


type alias Ingredient =
    { quantity : Float, unit : String }


ingredients =
    [ Ingredient (2.5 / 3) "dl vetemjöl"
    , Ingredient (0.5 / 3) "tsk salt"
    , Ingredient (6 / 3) "dl mjölk"
    , Ingredient (3 / 3) "ägg"
    , Ingredient (45 / 3) "g smör"
    ]



-- Model


type alias Model =
    Float



-- Update


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- View


prettyRound : Float -> String
prettyRound f =
    let
        r =
            (Round.round 2 f)

        parts =
            (String.split "." r)
    in
        case parts of
            [ x, "00" ] ->
                x

            [ x, _ ] ->
                r

            [] ->
                r

            _ :: _ ->
                r


ingredientView : Model -> Ingredient -> Html Msg
ingredientView model ingredient =
    div []
        [ text (prettyRound (model * ingredient.quantity))
        , text " "
        , text ingredient.unit
        ]


view : Model -> Html Msg
view model =
    div [ class "top" ]
        [ h1 [] [ text (String.fromInt (round model * 2) ++ " pannkakor" )]
        , div [ class "recipe" ]
            [ div [] (List.map (ingredientView model) ingredients) ]
        , div [ class "buttons" ]
            [ button [ onClick Decrement ] [ text "mindre" ]
            , button [ onClick Increment ] [ text "MER" ]
            ]
        ]

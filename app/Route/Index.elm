module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html
import Html.Attributes as Html
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    { message : String
    }


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed Data
        |> BackendTask.andMap
            (BackendTask.succeed "Hello!")


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "GigaWork"
        , image =
            { url = [ "images", "icon-png.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Преимальный коворкинг у дома"
        , locale = Nothing
        , title = "GigaWork"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "GigaWork"
    , body =
        column [ width (fill |> maximum 700), centerX, padding 22, spacing 76 ]
            [ column []
                [ el [ unbounded, Font.color green, Font.heavy, Font.size 72 ]
                    (text "GigaWork")
                , el
                    [ paddingEach { top = 9, right = 0, left = 18, bottom = 0 }
                    , noto
                    , Font.size 18
                    , Font.extraBold
                    ]
                    (text "Премиальный коворкинг у дома")
                ]
            , callToAction
            , column [ spacing 24, width fill ]
                [ subtitle "Преимущества"
                , wrappedRow [ spacing 16, centerX, width fill ]
                    [ card
                        { title = "Удобное расположение"
                        , body = "10 минут от метро Молодежная.\nБесплатная парковка."
                        , image = mockImage
                        }
                    , card
                        { title = "Эргономичная мебель"
                        , body = "Каждое рабочее место оснащено креслом Herman Miller."
                        , image = mockImage
                        }
                    , card
                        { title = "Свежий кофе"
                        , body = "Каждую неделю заказываем для вас свежеобжаренный кофе."
                        , image = mockImage
                        }
                    , card
                        { title = "Проводной интернет"
                        , body = "Каждое рабочее место оснащено выходом USB-C с зарядкой и интернетом."
                        , image = mockImage
                        }
                    , card
                        { title = "Принтер"
                        , body = "Для вашего пользования есть лазерный принтер."
                        , image = mockImage
                        }
                    , card
                        { title = "Лаундж-зона"
                        , body = "Предусмотрена лаундж-зона для отдыха."
                        , image = mockImage
                        }
                    , card
                        { title = "Кабинки для звонков"
                        , body = "Чтобы не мешать друг другу в коворкинге стоят кабинки для звонков."
                        , image = mockImage
                        }
                    , card
                        { title = "Комфортные условия"
                        , body = "В коворкинге установлен кондиционер и очиститель воздуха."
                        , image = mockImage
                        }
                    ]
                ]
            , column [ spacing 27, width fill ]
                [ subtitle "График работы"
                , row [ width fill, spaceEvenly ]
                    [ workDayCard { title = "Пн", from = "9:00", to = "18:00" }
                    , workDayCard { title = "Вт", from = "9:00", to = "18:00" }
                    , workDayCard { title = "Ср", from = "9:00", to = "18:00" }
                    , workDayCard { title = "Чт", from = "9:00", to = "18:00" }
                    , workDayCard { title = "Пт", from = "9:00", to = "18:00" }
                    , weekendDayCard { title = "Сб" }
                    , weekendDayCard { title = "Вс" }
                    ]
                ]
            , column [ spacing 27, width fill ]
                [ subtitle "Адрес"
                , paragraph [ noto, Font.size 18, Font.extraBold ] [ text "Москва, Рублевское шоссе, 22" ]
                , el [ width fill, height (px 400) ] <|
                    html <|
                        Html.iframe
                            [ Html.src "https://yandex.ru/map-widget/v1/?um=constructor%3A6021061543ae5cffca6803ac7a0fa84e727d918c403c59250d18022f582f81d0&amp;source=constructor"
                            , Html.height 400
                            , Html.attribute "frameborder" "0"
                            ]
                            []
                ]
            , column [ spacing 27, width fill ]
                [ subtitle "Цена"
                , row [ width fill, spaceEvenly ]
                    [ priceCard { title = "1 день", price = "2 000 ₽", subtitle = "" }
                    , priceCard { title = "1 месяц", price = "25 000 ₽", subtitle = "" }
                    , priceCard { title = "3 месяца", price = "66 000 ₽", subtitle = "22 000 ₽ / месяц" }
                    , priceCard { title = "6 месяца", price = "120 000 ₽", subtitle = "20 000 ₽ / месяц" }
                    ]
                ]
            , callToAction
            ]
    }


mockImage : Element msg
mockImage =
    el
        [ Background.color (rgb 0.3 0.3 0.3)
        , width (px 1000)
        , height (px 1000)
        ]
        none


subtitle : String -> Element msg
subtitle t =
    paragraph [ Font.color green, Font.size 36, Font.heavy, unbounded ] [ text t ]


unbounded : Attribute msg
unbounded =
    Font.family [ Font.typeface "Unbounded" ]


noto : Attribute msg
noto =
    Font.family [ Font.typeface "Noto Sans" ]


green : Color
green =
    rgb255 32 195 145


background : Color
background =
    rgb255 243 243 243


button : String -> Element msg
button t =
    el
        [ Border.rounded 1000
        , Border.shadow
            { offset = ( 4, 4 )
            , size = 0
            , blur = 16
            , color = rgba255 0 0 0 0.2
            }
        , mouseOver
            [ Border.shadow
                { offset = ( 4, 4 )
                , size = 0
                , blur = 20
                , color = rgba255 0 0 0 0.2
                }
            ]
        , mouseDown
            [ Border.shadow
                { offset = ( 4, 4 )
                , size = 0
                , blur = 8
                , color = rgba255 0 0 0 0.2
                }
            ]
        , pointer
        , animate
        ]
    <|
        el
            [ Border.rounded 1000
            , Border.shadow
                { offset = ( -4, -4 )
                , size = 0
                , blur = 16
                , color = rgba 255 255 255 1
                }
            , mouseOver
                [ Border.shadow
                    { offset = ( -4, -4 )
                    , size = 0
                    , blur = 20
                    , color = rgba 255 255 255 1
                    }
                ]
            , mouseDown
                [ Border.shadow
                    { offset = ( -4, -4 )
                    , size = 0
                    , blur = 8
                    , color = rgba 255 255 255 0.8
                    }
                ]
            , animate
            ]
        <|
            el
                [ Background.color background
                , Border.rounded 1000
                , Border.innerShadow
                    { offset = ( 4, 4 )
                    , size = 0
                    , blur = 4
                    , color = rgba255 255 255 255 1
                    }
                , mouseOver
                    [ Border.innerShadow
                        { offset = ( 4, 4 )
                        , size = 0
                        , blur = 8
                        , color = rgba255 255 255 255 1
                        }
                    ]
                , mouseDown
                    [ Border.innerShadow
                        { offset = ( 4, 4 )
                        , size = 0
                        , blur = 2
                        , color = rgba255 255 255 255 1
                        }
                    ]
                , animate
                ]
            <|
                el
                    [ Border.innerShadow
                        { offset = ( -4, -4 )
                        , size = 0
                        , blur = 4
                        , color = rgba255 0 0 0 0.15
                        }
                    , mouseOver
                        [ Border.innerShadow
                            { offset = ( -4, -4 )
                            , size = 0
                            , blur = 8
                            , color = rgba255 0 0 0 0.2
                            }
                        ]
                    , mouseDown
                        [ Border.innerShadow
                            { offset = ( -4, -4 )
                            , size = 0
                            , blur = 2
                            , color = rgba255 0 0 0 0.2
                            }
                        ]
                    , padding 24
                    , Border.rounded 1000
                    , Font.extraBold
                    , Font.size 18
                    , animate
                    ]
                    (text t)


card : { title : String, body : String, image : Element msg } -> Element msg
card { title, body, image } =
    el
        [ Border.shadow
            { offset = ( -4, -4 )
            , blur = 16
            , size = 0
            , color = rgb 255 255 255
            }
        , Border.rounded 16
        , width (minimum 312 <| fill)
        , alignTop
        ]
    <|
        column
            [ Border.shadow
                { offset = ( 4, 4 )
                , blur = 16
                , size = 0
                , color = rgba 0 0 0 0.2
                }
            , Border.rounded 16
            , width fill
            ]
            [ column
                [ padding 16
                , spacing 8
                ]
                [ paragraph [ unbounded, Font.extraBold, Font.size 18, spacing 2 ] [ text title ]
                , paragraph [ noto, Font.size 14, spacing 1 ] [ text body ]
                ]
            , el
                [ height (px 156)
                , width fill
                , clip
                , centerX
                , centerY
                , Border.roundEach
                    { topLeft = 0
                    , topRight = 0
                    , bottomLeft = 16
                    , bottomRight = 16
                    }
                ]
                image
            ]


animate : Attribute msg
animate =
    htmlAttribute <| Html.class "animate"


indentedCard : { title : String, body : Element msg, color : Color, minWidth : Int } -> Element msg
indentedCard { title, body, color, minWidth } =
    el
        [ Background.color color
        , Border.shadow
            { offset = ( 4, 4 )
            , blur = 16
            , size = 0
            , color = rgba255 0 0 0 0.2
            }
        , Border.rounded 16
        ]
    <|
        el
            [ Border.shadow
                { offset = ( -4, -4 )
                , blur = 16
                , size = 0
                , color = rgb255 255 255 255
                }
            , Border.rounded 16
            ]
        <|
            column [ padding 4, width (minimum minWidth <| fill), height (px 132) ]
                [ el
                    [ height (px 38)
                    , unbounded
                    , width fill
                    , Font.heavy
                    , Font.size 14
                    , Border.innerShadow
                        { offset = ( 4, 4 )
                        , blur = 4
                        , size = 0
                        , color = rgba255 0 0 0 0.15
                        }
                    , Border.roundEach
                        { topLeft = 14
                        , topRight = 14
                        , bottomLeft = 0
                        , bottomRight = 0
                        }
                    , Background.color background
                    ]
                  <|
                    el
                        [ width fill
                        , height fill
                        , Border.innerShadow
                            { offset = ( -4, -4 )
                            , blur = 4
                            , size = 0
                            , color = rgb255 255 255 255
                            }
                        , Border.roundEach
                            { topLeft = 14
                            , topRight = 14
                            , bottomLeft = 0
                            , bottomRight = 0
                            }
                        ]
                    <|
                        el [ centerX, centerY ]
                            (text title)
                , body
                ]


workDayCard : { title : String, from : String, to : String } -> Element msg
workDayCard { title, from, to } =
    indentedCard
        { title = title
        , body =
            column [ centerX, centerY, unbounded, Font.size 14, Font.heavy, spacing 5 ] <|
                List.map (el [ centerX ])
                    [ text from, text "—", text to ]
        , color = background
        , minWidth = 65
        }


weekendDayCard : { title : String } -> Element msg
weekendDayCard { title } =
    indentedCard
        { title = title
        , body =
            el [ centerX, centerY, unbounded, Font.size 14, Font.heavy, spacing 5 ] <|
                el [ centerX ] (text "Вых.")
        , color = rgb255 246 214 214
        , minWidth = 65
        }


priceCard : { title : String, price : String, subtitle : String } -> Element msg
priceCard cfg =
    indentedCard
        { title = cfg.title
        , color = background
        , body =
            column [ centerX, centerY, spacing 5 ] <|
                [ el [ centerX, unbounded, Font.size 14, Font.heavy ] (text cfg.price)
                , el [ centerX, noto, Font.size 14, Font.regular ] (text cfg.subtitle)
                ]
        , minWidth = 148
        }


callToAction : Element msg
callToAction =
    el [ centerX ] <| link [] { url = "https://t.me/ilyakooo0", label = button "Узнать о свободных местах" }

module Inventory where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import StartApp.Simple as StartApp
import Signal exposing (Address)
import Char exposing (fromCode)
import String exposing (fromChar)
import InventoryUtils as Utils

-- Model
type alias StockItem =
  { description: String, 
    package: String,
    count: String,
    id: Int
  }

type alias Model =
  { stock: List StockItem,
    descriptionInput: String,
    packageInput: String,
    countInput: String,
    nextID: Int
  }

initialModel : Model
initialModel = 
  { stock =
    [ newStockItem "TopHat PCB" "NA" "10" 1,
      newStockItem "1k Resistor" "1208" "56" 2 
    ],
    descriptionInput = "",
    packageInput = "",
    countInput = "",
    nextID = 3
  }

newStockItem : String -> String -> String -> Int -> StockItem
newStockItem description package count id =
  StockItem description package count id

isAddInvalid : Model -> Bool
isAddInvalid model = 
  String.isEmpty model.descriptionInput || 
    String.isEmpty model.packageInput ||
    String.isEmpty model.countInput

-- Update
type Action 
  = NoOp 
  | AddItem
  | UpdateFormDescription String
  | UpdateFormPackage String
  | UpdateFormCount String

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    AddItem ->
      if isAddInvalid model then model
      else
        { model | 
          descriptionInput = "",
          packageInput = "",
          countInput = "",
          nextID = model.nextID + 1,
          stock = List.append model.stock [ 
            newStockItem model.descriptionInput 
            model.packageInput
            model.countInput
            model.nextID
          ] 
        }

    UpdateFormDescription contents ->
      { model | descriptionInput = contents }

    UpdateFormPackage contents ->
      { model | packageInput = contents }

    UpdateFormCount contents ->
      { model | countInput = contents }

-- View
header : Html
header =
  div [  ]
  [ h1 [  ] [ text "SirKits Inventory" ],
    h2 [  ] [ text "is awesome!" ]
  ]

newComponentForm : Address Action -> Model -> Html
newComponentForm address model =
  div [ id "new-component-form" ]
    [ {- div [] [ 
      span [] 
      [ 
        span [] [ 
          text model.descriptionInput  
        ],
        span [] [ 
          text model.packageInput  
        ],  
        span [] [ 
          text model.countInput  
        ]  
      ] 
    ], -}
    -- Description form field
    span [] [ 
        input [ type' "text",
          placeholder "Description",
          name "description",
          value model.descriptionInput,
          Utils.onInput address UpdateFormDescription 
          ] 
          [ ]
      ],
      -- Package form field
      span [] [
        input [ type' "text",
          placeholder "Package",
          name "package",
          value model.packageInput,
          Utils.onInput address UpdateFormPackage 
          ] 
          [ ]
      ],
      -- Count form field
      span [] [
        input [ type' "number",
          placeholder "Count",
          value model.countInput,
          name "count",
          Utils.onInput address UpdateFormCount 
        ] 
          [  ]
      ],
      -- Submit button
      button [ class "addItem",
            onClick address AddItem,
            disabled (isAddInvalid model)
          ]
          [ if isAddInvalid model 
            then text "complete form"
            else
              text "Add Item" 
          ]
    ]

stockItem : StockItem -> Html
stockItem item =
    tr [  ]
        [ td [ class "id" ]
          [ text (toString item.id) ],
          td [ class "description" ]
          [ text item.description ],
          td [ class "package" ]
          [ text item.package ],
          td [ class "count" ]
          [ text item.count ]
        ]

stockHeaders : Html
stockHeaders = 
  thead [  ] [
    th [  ] [ text "ID" ],
    th [  ] [ text "Description" ],
    th [  ] [ text "Package" ],
    th [  ] [ text "Count" ]
  ]

stockTable : List StockItem -> Html
stockTable stock =
  let
    stockItems = List.map stockItem stock 
  in
    table [] (stockHeaders :: stockItems)
    

view : Address Action -> Model -> Html
view address model =
  div [ id "container" ]
      [ header,
        newComponentForm address model,
        stockTable model.stock
      ]

-- Wiring it up
main = StartApp.start 
  { model = initialModel,
    view = view,
    update = update
  }

#let data-file = sys.inputs.at("data", default: "cover_letter_data.json")
#let data = json(data-file)
#let recipient-data = data.at("recipient", default: (:))
#let signature-file = sys.inputs.at("signature", default: "")

#let accent = rgb(data.at("accent_color", default: "#1a5fb4"))

#set page(
  paper: "a4",
  margin: (x: 2cm, top: 1.6cm, bottom: 1.7cm),
)

#set text(
  font: ("Helvetica Neue", "Arial"),
  size: 10pt,
  fill: rgb("#334155"),
  lang: data.at("language", default: "en"),
)

#set par(justify: true, leading: 0.55em)

#block(
  width: 100%,
  stroke: (bottom: 0.6pt + rgb("#dbe3ec")),
  inset: (bottom: 0.8em),
)[
  #grid(
    columns: (1fr, auto),
    gutter: 1cm,
    align: (left + horizon, right + horizon),
    [
      #text(size: 20pt, weight: "light", fill: rgb("#1e293b"))[#data.sender.name] \
      #text(size: 10.5pt, fill: accent)[#data.sender.title]
    ],
    [
      #set text(size: 8.5pt, fill: rgb("#64748b"))
      #data.sender.email \
      #data.sender.phone \
      #data.sender.location
    ],
  )
]

#v(0.8cm)

#grid(
  columns: (1fr, auto),
  align: (left, right),
  [
    #text(weight: "bold", fill: rgb("#1e293b"))[#recipient-data.company] \
    #recipient-data.department \
    #recipient-data.contact_person
  ],
  [#data.location, #data.date],
)

#v(0.75cm)
#text(size: 12pt, weight: "bold", fill: accent)[#data.subject]
#v(0.45cm)
#text(weight: "medium")[#data.salutation]
#v(0.3cm)

#for paragraph in data.at("paragraphs", default: ()) [
  #paragraph
  #v(0.45em)
]

#v(0.45cm)
#text(weight: "medium")[#data.at("closing", default: "Kind regards")],
#if signature-file != "" [
  #v(0.2cm)
  #image(signature-file, width: 4.8cm)
] else [
  #v(0.7cm)
]
#text(weight: "bold")[#data.sender.name]

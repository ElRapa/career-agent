#let data-file = sys.inputs.at("data", default: "cover_letter_data.json")
#let data = json(data-file)
#let signature-file = sys.inputs.at("signature", default: "")

#let primary = rgb("#2b4c7e")
#let body-color = rgb("#1a1a1a")
#let muted = rgb("#666666")
#let rule-color = rgb("#d0d0d0")

#set page(
  paper: "a4",
  margin: (x: 2.1cm, top: 1.7cm, bottom: 1.8cm),
)

#set text(
  font: ("Helvetica Neue", "Arial"),
  size: 10pt,
  fill: body-color,
  lang: data.at("language", default: "en"),
)

#set par(justify: true, leading: 0.55em)

#align(center)[
  #text(size: 19pt, weight: "bold", fill: primary, tracking: 1pt)[#upper(data.sender.name)]
  #v(2pt)
  #text(size: 10pt, fill: muted, style: "italic")[#data.sender.title]
  #v(5pt)
  #line(length: 100%, stroke: 0.8pt + primary)
  #v(4pt)
  #set text(size: 8.5pt, fill: muted)
  #data.sender.email
  #h(5pt)
  #text(fill: rule-color)[#sym.bar.v]
  #h(5pt)
  #data.sender.phone
  #h(5pt)
  #text(fill: rule-color)[#sym.bar.v]
  #h(5pt)
  #data.sender.location
]

#v(0.8cm)

#grid(
  columns: (1fr, auto),
  align: (left, right),
  [
    #text(weight: "bold", fill: body-color)[#data.recipient.company] \
    #data.recipient.department \
    #data.recipient.contact_person
  ],
  [#data.location, #data.date],
)

#v(0.65cm)
#text(size: 12pt, weight: "bold", fill: primary)[#data.subject]
#v(0.4cm)
#text(weight: "medium")[#data.salutation]
#v(0.3cm)

#for paragraph in data.at("paragraphs", default: ()) [
  #paragraph
  #v(0.45em)
]

#v(0.4cm)
#text(weight: "medium")[#data.at("closing", default: "Kind regards")]
#if signature-file != "" [
  #v(0.2cm)
  #image(signature-file, width: 4.8cm)
+] else [
  #v(0.7cm)
]
#text(weight: "bold")[#data.sender.name]

#import "@preview/neat-cv:1.2.0": letter

#let data-file = sys.inputs.at("data", default: "cover_letter_data.json")
#let data = json(data-file)
#let recipient-data = data.at("recipient", default: (:))

#show: letter.with(
  author: (
    firstname: data.sender.at("name", default: ""),
    lastname: "",
    email: data.sender.at("email", default: ""),
    phone: data.sender.at("phone", default: ""),
    address: data.sender.at("location", default: ""),
    position: (data.sender.at("title", default: ""),),
  ),
  accent-color: rgb(data.at("accent_color", default: "#1a5fb4")),
  heading-font: "Helvetica Neue",
  body-font: ("Helvetica Neue", "Arial"),
  recipient: [
    #recipient-data.at("contact_person", default: "")\
    #recipient-data.at("department", default: "")\
    #recipient-data.at("company", default: "")
  ],
)

#data.at("salutation", default: "")

#for paragraph in data.at("paragraphs", default: ()) [
  #paragraph
  #v(0.5em)
]

#data.at("closing", default: "Kind regards"),

#align(right)[#data.sender.at("name", default: "")]

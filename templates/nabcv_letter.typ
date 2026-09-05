#import "@preview/nabcv:0.1.0": letter

#let data-file = sys.inputs.at("data", default: "cover_letter_data.json")
#let data = json(data-file)
#let recipient-data = data.at("recipient", default: (:))
#let recipient = [
  #recipient-data.at("contact_person", default: "") \
  #recipient-data.at("department", default: "") \
  #recipient-data.at("company", default: "")
]

#letter(
  sender: data.sender,
  recipient: recipient,
  date: data.at("date", default: "auto"),
  subject: data.at("subject", default: none),
  salutation: data.at("salutation", default: none),
  closing: data.at("closing", default: [Kind regards]),
  font-family: (body: "Helvetica Neue",),
)[
  #for paragraph in data.at("paragraphs", default: ()) [
    #paragraph
    v(8pt)
  ]
]

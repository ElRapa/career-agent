#import "@preview/neat-cv:1.2.0": (
  contact-info, cv, cv-with-side, entry, item-pills, item-with-level,
  social-links,
)

#let data-file = sys.inputs.at("data", default: "cv_data.json")
#let data = json(data-file)
#let name-parts = data.personal.name.split(" ")
#let firstname = name-parts.at(0)
#let lastname = if name-parts.len() > 1 { name-parts.slice(1).join(" ") } else { "" }

#show: cv.with(
  author: (
    firstname: firstname,
    lastname: lastname,
    email: data.personal.at("email", default: ""),
    phone: data.personal.at("phone", default: ""),
    address: data.personal.at("location", default: ""),
    position: (data.personal.at("title", default: ""),),
    linkedin: data.personal.at("linkedin", default: ""),
    github: data.personal.at("github", default: ""),
  ),
  accent-color: rgb(data.at("accent_color", default: "#1a5fb4")),
  heading-font: "Helvetica Neue",
  body-font: ("Helvetica Neue", "Arial"),
)

#cv-with-side[
  = Profile
  #data.at("summary", default: "")

  = Contact
  #contact-info()

  = Skills
  #for group in data.at("skills", default: ()) [
    #text(weight: "bold")[#group.at("category", default: "")]
    #item-pills(group.at("items", default: ()))
  ]

  #if "languages" in data [
    = Languages
    #for language in data.languages [
      #item-with-level(language.language, language.at("dots", default: 0), subtitle: language.at("level", default: ""))
    ]
  ]

  #v(1fr)
  #social-links()
][
  = Experience
  #for experience in data.at("experience", default: ()) [
    #entry(
      title: experience.at("role", default: ""),
      institution: experience.at("company", default: ""),
      location: experience.at("location", default: ""),
      date: experience.at("period", default: ""),
    )[
      #for bullet in experience.at("bullets", default: ()) [
        - #bullet
      ]
    ]
  ]

  = Selected Projects
  #for project in data.at("projects", default: ()) [
    #entry(
      title: project.at("title", default: ""),
      institution: project.at("client", default: ""),
      date: project.at("period", default: ""),
    )[
      #for bullet in project.at("bullets", default: ()) [
        - #bullet
      ]
    ]
  ]

  = Education
  #for education in data.at("education", default: ()) [
    #entry(
      title: education.at("degree", default: ""),
      institution: education.at("institution", default: ""),
      location: education.at("location", default: ""),
      date: education.at("period", default: ""),
    )[
      #education.at("details", default: "")
    ]
  ]

  = Certifications
  #for certification in data.at("certifications", default: ()) [
    #entry(
      title: certification.at("name", default: ""),
      institution: certification.at("issuer", default: ""),
      date: certification.at("year", default: ""),
    )[
      #certification.at("issuer", default: "")
    ]
  ]
]

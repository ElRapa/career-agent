#import "@preview/nabcv:0.1.0": cv

#let data-file = sys.inputs.at("data", default: "cv_data.json")
#let data = json(data-file)

#let profile-username(url) = {
  if url == "" {
    ""
  } else {
    let parts = url.split("/")
    parts.at(parts.len() - 1)
  }
}

#let profiles = (
  (network: "LinkedIn", username: profile-username(data.personal.at("linkedin", default: ""))),
  (network: "GitHub", username: profile-username(data.personal.at("github", default: ""))),
)

#let experience = data.at("experience", default: ()).map(exp => (
  company: exp.at("company", default: ""),
  position: exp.at("role", default: ""),
  summary: exp.at("summary", default: ""),
  location: exp.at("location", default: ""),
  start_date: exp.at("period", default: ""),
  end_date: "",
  highlights: exp.at("bullets", default: ()),
))

#let education = data.at("education", default: ()).map(item => (
  company: item.at("degree", default: ""),
  summary: item.at("institution", default: ""),
  location: item.at("location", default: ""),
  start_date: item.at("period", default: ""),
  end_date: "",
  highlights: item.at("details", default: ""),
))

#let base-skills = data.at("skills", default: ()).map(group => (
  group: group.at("category", default: ""),
  items: group.at("items", default: ()),
))

#let language-skills = if data.at("languages", default: ()).len() > 0 {
  ((
    group: "Languages",
    items: data.languages.map(language => language.language + " (" + language.at("level", default: "") + ")"),
  ),)
} else {
  ()
}

#let skills = base-skills + language-skills

#cv(
  name: data.personal.name,
  headline: data.personal.at("title", default: none),
  location: data.personal.at("location", default: none),
  email: data.personal.at("email", default: none),
  phone: data.personal.at("phone", default: none),
  profiles: profiles,
  summary: data.at("summary", default: none),
  experience: experience,
  education: education,
  skills: skills,
  font-family: (
    header-name: "Helvetica Neue",
    header-headline: "Helvetica Neue",
    header-location: "Helvetica Neue",
    header-tags: "Helvetica Neue",
    section-title: "Helvetica Neue",
    body: "Helvetica Neue",
    entry-text: "Helvetica Neue",
    entry-highlight: "Helvetica Neue",
    summary: "Helvetica Neue",
  ),
  main-sections: ("summary", "experience", "education"),
  sidebar-sections: ("contact", "skills"),
  theme: (secondary: rgb(data.at("accent_color", default: "#1a5fb4")),),
)[]

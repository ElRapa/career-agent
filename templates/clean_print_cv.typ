#import "@preview/clean-print-cv:0.1.0": *

#let data-file = sys.inputs.at("data", default: "cv_data.json")
#let data = json(data-file)

#let experience = data.at("experience", default: ()).map(exp => (
  role: exp.at("role", default: ""),
  company: exp.at("company", default: ""),
  location: exp.at("location", default: ""),
  period: exp.at("period", default: ""),
  highlights: exp.at("bullets", default: ()),
))

#let projects = data.at("projects", default: ()).map(project => (
  name: project.at("title", default: ""),
  url: project.at("url", default: ""),
  description: project.at("bullets", default: ()).join(" "),
))

#let education = data.at("education", default: ()).map(item => (
  degree: item.at("degree", default: ""),
  institution: item.at("institution", default: ""),
  location: item.at("location", default: ""),
  period: item.at("period", default: ""),
  details: item.at("details", default: ""),
))

#let certifications = data.at("certifications", default: ()).map(item => (
  name: item.at("name", default: ""),
  issuer: item.at("issuer", default: ""),
  year: item.at("year", default: ""),
))

#show: cv-page-setup
#cv-header(data.personal)
#cv-summary(data.at("summary", default: ""))
#cv-experience(experience)
#cv-skills(data.at("skills", default: ()))
#cv-projects(projects)
#cv-certifications(certifications)
#cv-education(education)
#cv-languages(data.at("languages", default: ()))

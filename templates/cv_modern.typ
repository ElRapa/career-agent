// Modern & Visual CV Template for Typst
// Compatible with Typst 0.11+

#let data-file = sys.inputs.at("data", default: "cv_data.json")
#let data = json(data-file)

// Farbschema
#let accent-hex = data.at("accent_color", default: "#1a5fb4")
#let accent = rgb(accent-hex)
#let text-dark = rgb("#1e293b")
#let text-muted = rgb("#64748b")
#let pill-bg = rgb("#f1f5f9")
#let card-bg = rgb("#f8fafc")
#let border-light = rgb("#e2e8f0")

#set document(
  title: data.personal.name + " - Lebenslauf",
  author: data.personal.name,
)

#set page(
  paper: "a4",
  margin: (x: 1.8cm, top: 1.8cm, bottom: 2.0cm),
  footer: context {
    let current = counter(page).get().first()
    let total = counter(page).final().first()
    text(fill: text-muted, size: 8pt)[
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#data.personal.name · Lebenslauf],
        [Seite #current von #total]
      )
    ]
  }
)

#set text(
  font: ("Helvetica Neue", "Arial"),
  size: 9.5pt,
  fill: text-dark,
  lang: data.at("language", default: "de")
)

#set par(justify: true, leading: 0.58em)

// UI Components
#let pill(body) = box(
  fill: pill-bg,
  radius: 3pt,
  inset: (x: 5pt, y: 2.5pt),
  outset: 0pt,
  baseline: 0%,
  text(fill: accent, size: 7.5pt, weight: "medium", body)
)

#let section-heading(title) = {
  v(0.9em)
  block(width: 100%)[
    #text(fill: accent, weight: "bold", size: 12pt, upper(title))
    #v(-0.3em)
    #line(length: 100%, stroke: 1.2pt + accent)
  ]
  v(0.3em)
}

// =================== HEADER ===================
#block(width: 100%, stroke: (bottom: 0.5pt + border-light), inset: (bottom: 1.2em))[
  #grid(
    columns: (1fr, auto),
    gutter: 1.5cm,
    align: (left + horizon, right + horizon),
    [
      #text(size: 22pt, weight: "bold", fill: accent)[#data.personal.name] \
      #v(0.2em)
      #text(size: 12pt, weight: "medium", fill: text-dark)[#data.personal.title]
    ],
    [
      #set text(size: 8.5pt, fill: text-muted)
      #if "email" in data.personal and data.personal.email != "" [
        📧 #link("mailto:" + data.personal.email)[#data.personal.email] \
      ]
      #if "phone" in data.personal and data.personal.phone != "" [
        📱 #data.personal.phone \
      ]
      #if "location" in data.personal and data.personal.location != "" [
        📍 #data.personal.location \
      ]
      #if "linkedin" in data.personal and data.personal.linkedin != "" [
        🔗 #link(data.personal.linkedin)[LinkedIn]
      ]
      #if "github" in data.personal and data.personal.github != "" [
        #if "linkedin" in data.personal [ · ]
        💻 #link(data.personal.github)[GitHub]
      ]
    ]
  )
]

// =================== EXECUTIVE SUMMARY / PROFIL ===================
#if "summary" in data and data.summary != "" [
  #v(0.5em)
  #rect(
    width: 100%,
    fill: card-bg,
    radius: 4pt,
    stroke: (left: 3pt + accent, rest: 0.5pt + border-light),
    inset: (x: 10pt, y: 8pt)
  )[
    #text(weight: "bold", fill: accent, size: 9.5pt)[Profil & Schwerpunkt] \
    #v(0.2em)
    #text(size: 9pt, fill: text-dark)[#data.summary]
  ]
]

// =================== KERNKOMPETENZEN / SKILLS ===================
#if "skills" in data and data.skills.len() > 0 [
  #section-heading(data.at("labels", default: ()).at("skills", default: "Kernkompetenzen"))
  #grid(
    columns: (130pt, 1fr),
    row-gutter: 0.55em,
    ..data.skills.map(skill-group => (
      text(weight: "bold", fill: text-dark, size: 9pt)[#skill-group.category:],
      [
        #for item in skill-group.items [
          #pill(item)
          #h(2pt)
        ]
      ]
    )).flatten()
  )
]

// =================== AUSGEWÄHLTE PROJEKTE ===================
#if "projects" in data and data.projects.len() > 0 [
  #section-heading(data.at("labels", default: ()).at("projects", default: "Ausgewählte Projekte & Praxisbelege"))
  #for proj in data.projects [
    #block(width: 100%, breakable: false)[
      #grid(
        columns: (1fr, auto),
        [
          #text(weight: "bold", size: 10.5pt)[#proj.title]
          #if "client" in proj and proj.client != "" [
            #text(fill: text-muted)[ · #proj.client]
          ]
        ],
        [
          #text(size: 8.5pt, fill: text-muted, weight: "medium")[#proj.period]
        ]
      )
      #if "role" in proj and proj.role != "" [
        #text(size: 9pt, fill: accent, weight: "semibold")[#proj.role]
      ]
      #if "tech" in proj and proj.tech.len() > 0 [
        #v(0.15em)
        #for t in proj.tech [
          #pill(t)
          #h(2pt)
        ]
      ]
      #if "bullets" in proj and proj.bullets.len() > 0 [
        #v(0.2em)
        #list(
          tight: true,
          marker: text(fill: accent)[•],
          ..proj.bullets.map(b => text(size: 9pt)[#b])
        )
      ]
      #v(0.6em)
    ]
  ]
]

// =================== BERUFLICHER WERDEGANG ===================
#if "experience" in data and data.experience.len() > 0 [
  #section-heading(data.at("labels", default: ()).at("experience", default: "Beruflicher Werdegang"))
  #for exp in data.experience [
    #block(width: 100%, breakable: false)[
      #grid(
        columns: (1fr, auto),
        [
          #text(weight: "bold", size: 10.5pt)[#exp.role] \
          #text(weight: "medium", fill: text-muted, size: 9pt)[#exp.company]
          #if "location" in exp and exp.location != "" [
            #text(fill: text-muted, size: 8.5pt)[ · #exp.location]
          ]
        ],
        [
          #text(size: 8.5pt, fill: text-muted, weight: "medium")[#exp.period]
        ]
      )
      #if "bullets" in exp and exp.bullets.len() > 0 [
        #v(0.2em)
        #list(
          tight: true,
          marker: text(fill: accent)[•],
          ..exp.bullets.map(b => text(size: 9pt)[#b])
        )
      ]
      #v(0.6em)
    ]
  ]
]

// =================== AUSBILDUNG & ZERTIFIZIERUNGEN ===================
#let has-edu = "education" in data and data.education.len() > 0
#let has-cert = "certifications" in data and data.certifications.len() > 0

#if has-edu or has-cert [
  #grid(
    columns: if (has-edu and has-cert) { (1fr, 1fr) } else { (1fr,) },
    gutter: 1.5cm,
    if has-edu [
      #section-heading(data.at("labels", default: ()).at("education", default: "Ausbildung"))
      #for edu in data.education [
        #block(width: 100%)[
          #text(weight: "bold", size: 9.5pt)[#edu.degree] \
          #text(size: 8.5pt, fill: text-muted)[#edu.institution · #edu.period]
          #v(0.3em)
        ]
      ]
    ],
    if has-cert [
      #section-heading(data.at("labels", default: ()).at("certifications", default: "Zertifizierungen"))
      #for cert in data.certifications [
        #block(width: 100%)[
          #text(weight: "bold", size: 9.5pt)[#cert.name] \
          #text(size: 8.5pt, fill: text-muted)[#cert.issuer · #cert.year]
          #v(0.3em)
        ]
      ]
    ]
  )
]

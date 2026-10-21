// ============================================================
//  preamble.typ — общий стиль конспектов
//  Подключение:  #import "/preamble.typ": *
//                #show: conf.with(title: [...], subject: [...])
// ============================================================


// ---------- 1. Окружения (теоремы, определения, ...) ----------

// Общий счётчик. Сбрасывается на каждом заголовке 1-го уровня,
// поэтому нумерация получается вида 1.1, 1.2, 2.1, ...
#let thm-counter = counter("thm")

// Фабрика окружений: возвращает функцию (title: none, body) => ...
#let env(name, color, numbered: true) = (title: none, body) => {
  block(
    width: 100%,
    breakable: true,
    above: 1.1em,
    below: 1.1em,
    inset: (left: 10pt, y: 5pt),
    stroke: (left: 2pt + color),
  )[
    #if numbered { thm-counter.step() }
    #text(weight: "bold", fill: color, {
      name
      if numbered {
        [ ]
        context {
          let h = counter(heading).get()
          let sec = if h.len() > 0 { h.first() } else { 0 }
          [#sec.#thm-counter.get().first()]
        }
      }
      if title != none [ (#title)]
      [.]
    })
    #h(0.3em)
    #body
  ]
}

#let definition  = env("Определение", rgb("#1f6feb"))
#let theorem     = env("Теорема", rgb("#c0392b"))
#let lemma       = env("Лемма", rgb("#d35400"))
#let proposition = env("Предложение", rgb("#8e44ad"))
#let corollary   = env("Следствие", rgb("#16a085"))
#let remark      = env("Замечание", luma(110), numbered: false)
#let example     = env("Пример", rgb("#27ae60"), numbered: false)

// Доказательство: курсив в начале и квадратик в конце
#let proof(body) = block(above: 0.8em, below: 1.1em)[
  _Доказательство._ #body #h(1fr) $square$
]

// Пометка «доделать»
#let todo(body) = highlight(fill: yellow.lighten(60%))[TODO: #body]


// ---------- 2. Макросы для математики ----------
// После #let их можно использовать прямо внутри $ ... $

// Короткое имя для ε (в Typst `epsilon` — это «ε», а `epsilon.alt` — «ϵ»)
#let eps = $epsilon$

// Операторы (прямым шрифтом, с правильными отступами)
#let Ker  = math.op("Ker")
#let rk   = math.op("rk")
#let tr   = math.op("tr")
#let Span = math.op("span")
#let sgn  = math.op("sgn")

// Частые пределы
#let limn = $lim_(n -> oo)$
#let limx(a) = $lim_(x -> #a)$

// Производные: dv(f, x) -> df/dx,  pdv(f, x) -> ∂f/∂x
#let dv(f, x)  = $(dif #f) / (dif #x)$
#let pdv(f, x) = $(partial #f) / (partial #x)$


// ---------- 3. Оформление документа ----------

#let conf(
  title: none,
  subject: none,
  author: none,
  doc,
) = {
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.2cm),
    numbering: "1",
    header: if subject != none or author != none {
      text(size: 9pt, fill: luma(110))[#subject #h(1fr) #author]
    },
  )

  set text(lang: "ru", font: "New Computer Modern", size: 11pt, hyphenate: true)
  set par(justify: true, leading: 0.7em)

  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    thm-counter.update(0)
    it
  }

  // Русская типографика списков: «1)» и тире
  set enum(numbering: "1)")
  set list(marker: [–])

  // Нумерация формул включается так:
  // set math.equation(numbering: "(1)")

  if title != none {
    align(center, text(17pt, weight: "bold", title))
    v(1em)
  }

  doc
}

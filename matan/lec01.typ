#import "/preamble.typ": *
#show: conf.with(
  title: [Лекция 1. Пределы последовательностей],
  subject: [Математический анализ],
  author: [Морозов А. И.],
)

= Предел последовательности

#definition(title: [предел последовательности])[
  Число $a$ называется пределом последовательности $(x_n)$, если
  $ forall eps > 0 space exists N in NN : forall n > N quad abs(x_n - a) < eps. $
  Пишут $limn x_n = a$.
]

#theorem(title: [единственность предела])[
  Сходящаяся последовательность имеет ровно один предел.
]

#proof[
  Пусть $a != b$ — два предела. Возьмём $eps = abs(a - b) / 3$. Начиная с некоторого
  номера, одновременно $abs(x_n - a) < eps$ и $abs(x_n - b) < eps$, откуда
  $ abs(a - b) <= abs(x_n - a) + abs(x_n - b) < 2 eps = 2/3 abs(a - b), $
  противоречие.
]

#remark[Предел не обязан существовать: $x_n = (-1)^n$ расходится.]

#example[
  $limn (1 + 1/n)^n = e$, $quad limx(0) sin(x)/x = 1$.
]

= Производные

#lemma[
  Если $f$ дифференцируема в $x_0$, то $dv(f, x) (x_0) = f'(x_0)$.
]

$ pdv(F, y) = lim_(h -> 0) (F(x, y + h) - F(x, y)) / h. $

#todo[дописать про арифметику пределов]

#theorem(title: [])[

]

#proof[

]

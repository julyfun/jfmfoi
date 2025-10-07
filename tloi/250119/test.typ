
#set page(columns: 2)

#lorem(100)

// Raw placement.
#place(
  top,
  scope: "parent",
  float: true,
  lorem(100)
)

// With a figure.
#figure(
  placement: auto,
  scope: "parent",
  caption: [My caption],
  rect(width: 75%),
)

#lorem(200)

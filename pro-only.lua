

function Span(el)
  if el.classes:includes("pro-only") then
    el.content = pandoc.List()
    return el
  end
end

function Div(el)
  if el.classes:includes("pro-only") then
    return pandoc.Null()
  end
end





#import html as h
#import "@preview/based:0.2.0"
#import "@preview/typhoon:0.2.0": tailwind-css, update-elem
#let font-bytes = read("build/Paiagram-Timetable-Font.woff2", encoding: none)
#let font-base64 = "data:font/woff2;charset=utf-8;base64," + based.base64.encode(font-bytes)

#let title-text = "Paiagram-Timetable-Font"

#show h.elem: update-elem

#let paged-content = {
  set text(font: "Paiagram-Timetable-Font")
  set page(width: auto, height: auto, margin: 5pt)
  let s-fmt(s) = box(inset: (left: .15em), text(size: .7em, [#s]))
  table(
    columns: (4.5em, ) * 2,
    stroke: 1pt,
    inset: .25em,
    align: center + horizon,
    [12:34#s-fmt(55)], [12:35#s-fmt(20)],
    [12:38#s-fmt(15)], [=======],
  )
}

#let html-content = [
  #title(title-text)
  This is the preview of the font "#title-text".

  = Timetable

  #let stations = (
    "Vancouver",
    "Coquitlam",
    "Mission City",
    "North Bend",
    "Kamloops",
    "Salmon Arm",
    "Revelstoke",
    "Field",
  )
  #let current-t = datetime(hour: 12, minute: 0, second: 0)
  #h.table.with(class: "ptf w-min mx-auto")({
    h.thead(class: "font-sans", {
      h.th(class: "min-w-30")[Station]
      h.th[Arr.]
      h.th[Dept.]
    })
    h.tbody({
      let tr = h.tr.with(class: "p-0")
      let td = h.td.with(class: "py-0 text-center")
      for (i, stn) in stations.enumerate() {
        tr({
          h.th(scope: "row", class: "font-sans", stn)
          current-t += duration(minutes: 25, seconds: 37)
          let arr = current-t
          current-t += duration(minutes: 2, seconds: 4)
          let dep = current-t
          for time in (arr, dep) {
            td({
              time.display("[hour]:[minute]")
              h.small(class: "pl-[1.5pt]", {
                h.span(class: "sr-only")[:]
                time.display("[second]")
              })
            })
          }
        })
      }
      tr({
        h.th[]
        td[======]
        td[======]
      })
    })
  })

  = Glyphs

  #h.span(
    class: "ptf break-all",
    ```
     !"$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
    ```.text,
  )
]

#context if target() == "html" {
  h.html({
    h.head({
      h.meta(charset: "utf-8")
      h.meta(name: "viewport", content: "width=device-width, initial-scale=1")
      h.title(title-text)
      context h.style({
        let css-block = ```css
        @font-face {
            font-family: "Paiagram-Timetable-Font";
            src: url("__SOURCE__") format("woff2");
            font-style: normal;
            font-weight: normal;
            text-rendering: optimizeLegibility;
        }
        .ptf {
            font-family: "Paiagram-Timetable-Font";
        }
        ```
        css-block.text.replace("__SOURCE__", font-base64)
        tailwind-css()
      })
    })
    h.body(class: "bg-white dark:bg-neutral-800")[
      #h.article(class: "prose prose-neutral dark:prose-invert px-5 mx-auto my-10", html-content)
    ]
  })
} else {
  paged-content
}

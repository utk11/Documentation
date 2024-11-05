#set page("a4")
#set page(background: rect(height: 830pt , width: 560pt,stroke: black))
#set heading(numbering:"1.")
#set page(margin: 30pt , numbering:"1")


#figure(image("Pictures/Front.png"))
#text(30pt)[Direct Integration of Structural Simulation Results into Rigid Body Dynamics]\
#text(20pt)[
#align(center )[Utkarsh Kulkarni]\

\
#align(center )[Supervisors:\
Dorit Kaufmann MSc.\
Jan-Lukas Archut MSc.]]

#pagebreak()
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}
#text(16pt)[#outline(title: "Contents",depth: 3,indent: auto)]
#set math.mat(delim: "[")
#set math.vec(delim: "[")
#set math.equation(numbering: "(1)")


#pagebreak()
#set text(size:16pt)
= Introduction
#include("Introduction.typ")

#pagebreak()

= Literature Review 
#include("Literature.typ")

#pagebreak()
= Background
#include("Background.typ")
#pagebreak()

= Methodology
#include("Methodolgy.typ")
#pagebreak()

= Results and Discussion 
#include("Results.typ")
#pagebreak()

= Conclusion and Outlook
#pagebreak()




#pagebreak()

List of Tables 
#pagebreak()

List of Figures
#pagebreak()

= Appendix
#include("Appendix.typ")
#pagebreak()

#include("Bibliography.typ")
#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.5.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let pdfpc-config = pdfpc.config(
    duration-minutes: 30,
    start-time: datetime(hour: 14, minute: 10, second: 0),
    end-time: datetime(hour: 14, minute: 40, second: 0),
    last-minutes: 5,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 2,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: metropolis-theme.with(
  aspect-ratio: "4-3",
  footer: self => self.info.author + ", " + self.info.institution + " - " + self.info.date,
  config-common(
    // handout: true,
    preamble: pdfpc-config, 
  ),
  config-info(
    title: [Leveraging LLMs in Software Engineering],
    subtitle: [Current Trends and Future Directions],
    author: [Gianluca Aguzzi],
    date: datetime.today().display("[day] [month repr:long] [year]"),
    institution: [Università di Bologna],
    // logo: emoji.school,
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 18pt)
#show math.equation: set text(font: "Fira Math")

#title-slide()

== Today's Lesson: LLMs in Software Engineering

- #text(weight: "bold")[Learning Objectives:]
  - Understanding the impact of LLMs on modern software development 
  - Exploring practical applications across the development lifecycle #fa-code-branch()
  - Examining ethical considerations and limitations #fa-balance-scale()
  - Anticipating future trends and preparing for AI-augmented development #fa-chart-line()

- #text(weight: "bold")[Key Applications We'll Cover:]
  - Code generation and completion #fa-code()
  - Documentation automation #fa-file-alt()
  - Automated testing and debugging #fa-bug()
  - Code review and quality assurance #fa-check-circle()
  - Requirements analysis and specification #fa-list-alt()

- #text(weight: "bold")[Future Directions & Concerns:]
  - Multi-agent LLM systems for collaborative development #fa-users()
  - Advanced context understanding with RAG #fa-database()
  - Alignment challenges and ethical considerations #fa-exclamation-triangle()
  - Developer skill evolution in an AI-augmented world #fa-graduation-cap()

- #text(weight: "bold")[Note:] This field is evolving rapidly—concepts matter more than specific implementations #fa-lightbulb()
== Machine Learning for Software Engineering
#focus-slide()[
  #align(center)[
    #text(size: 28pt, weight: "bold")[Machine Learning for Software Engineering]
    
    #v(1em)
    
    #text(size: 20pt)[
      Application of machine learning #emph[techniques] and #emph[methodologies] to address challenges and solve problems in the field of software engineering
    ]
    
    #v(1em)
    
    #image("figures/pubblication-over-year.png", width: 70%)
  ]
]
== Machine Learning for Software Engineering

#example[
  #text(weight: "bold")[Why?]
  
  - #text(weight: "bold")[Automation:] automate repetitive tasks (e.g., code generation).
  - #text(weight: "bold")[Prediction:] predict software quality, bugs, and performance.
  - #text(weight: "bold")[Optimization:] optimize software development processes.
  - #text(weight: "bold")[Understanding:] understand software artifacts and processes.
  - #text(weight: "bold")[Personalization:] personalize software development tools.
]

#example[
  #text(weight: "bold")[When?]
  
  - #text(weight: "bold")[Requirement Engineering:] requirements elicitation and analysis.
  - #text(weight: "bold")[Design:] design patterns, architecture, and modeling.
  - #text(weight: "bold")[Implementation:] code generation, refactoring, and bug fixing.
  - #emph[#text(weight: "bold")[Testing:]] test case generation, fault prediction...
  - #text(weight: "bold")[Maintenance:] bug prediction, code review...
]

== Machine Learning for Software Engineering -- Overview

  #align(center)[
    #image("figures/distrubution.png", width: 90%)
  ]
_From: Machine Learning for Software Engineering: {A} Tertiary Study_


== Early approaches -- Supervised Learning

#example[
  #text(weight: "bold")[Code Summarization (CodeNN)#footnote("DBLP:conf/acl/IyerKCZ16")]
  
  #align(center)[
    #image("figures/codenn.png", width: 80%)
  ]
]

== Early approaches -- Supervised Learning

#example[
  #text(weight: "bold")[Malware Detection#footnote("DBLP:journals/tii/CuiXCCWC18")]
  
  #align(center)[
    #image("figures/malware-detection.png", width: 80%)
  ]
]

== Early approaches -- Supervised Learning

#example[
  #text(weight: "bold")[Code Review -- Deep Review#footnote("DBLP:conf/pakdd/LiSTHXLL19")]
  
  #align(center)[
    #image("figures/deep-review.png", width: 60%)
  ]
]

== Early approaches -- Unsupervised Learning

#example[
  #text(weight: "bold")[Code Completion (kNN)#footnote("DBLP:conf/sigsoft/BruchMM09")]
  
  #align(center)[
    #image("figures/code-completions.png", width: 80%)
  ]
]

== Early approaches -- Pitfalls
#block(
  fill: rgb("#fde8e986"),  // Light reddish background
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#d4c3c4"), thickness: 1pt),
  [
    #text(weight: "bold")[Early Approaches - Pitfalls]
    
    - #text(weight: "bold")[Data scarcity:] software engineering data is scarce and expensive to collect, posing challenges for training effective models.
    - #text(weight: "bold")[Single-task models:] many models are designed for #emph[specific] tasks, limiting their broader #emph[applicability] and #emph[reuse].
    - #text(weight: "bold")[Lack of generalization:] models often fail to #emph[generalize] across different software projects and domains.
    - #text(weight: "bold")[Human-computer interaction:] Early models did not adequately consider human factors, impacting #emph[usability] and #emph[adoption] in software development practices.
  ]
)

== Towards LLM solutions
#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Why?]
    
    - #text(weight: "bold")[Code understanding]: LLMs, correctly trained, can understand code and its context.
    - #text(weight: "bold")[Code-Language link]: LLMs can link code to natural language, improving #emph[documentation] and #emph[understanding].
    - #text(weight: "bold")[Session support]: LLMs can support developers during coding sessions, providing #emph[hints] and #emph[suggestions].
    - #text(weight: "bold")[Testing support]: LLMs can generate #emph[test cases] and #emph[fault prediction].
    - #text(weight: "bold")[One-model-for-all]: LLMs can be used for #emph[multiple] tasks, reducing the need for #emph[task-specific] models.
    - #text(weight: "bold")[Personalization]: LLMs can be personalized to the developer's #emph[style] and #emph[needs].
    - #text(weight: "bold")[Human-level performance]: LLMs can achieve human-level performance in #emph[specific] tasks.
  ]
)

== Human-level performance

== LLM in SE -- Areas of Application

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #block(
      fill: rgb("#e8f4ea"),  // Light green for requirements
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 60%,
      stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Requirement Engineering #fa-file-alt()]]
        #v(0.5em)
        - #text(weight: "bold")[Ambiguity Resolution:] clarifying vague requirements with natural language understanding
        - #text(weight: "bold")[Requirement Classification:] automatically categorizing and prioritizing requirements
        - #text(weight: "bold")[Requirements Analysis:] identifying conflicts, gaps, and relationships between requirements
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e8eaf4"),  // Light blue for development
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 60%,
      stroke: (paint: rgb("#9a9faf"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Software Development #fa-code()]]
        #v(0.5em)
        - #text(weight: "bold")[Code Generation:] translating specifications into executable code
        - #text(weight: "bold")[Code Summarization:] creating human-readable explanations of complex code
        - #text(weight: "bold")[Code Completion:] intelligently suggesting code as developers type
      ]
    )
  ]
)

== 
#v(1em)
#align(center)[#text(style: "italic")[LLMs connect each phase of development, creating a more integrated workflow #fa-arrows-alt-h()]]
#v(1em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #block(
      fill: rgb("#f4eae8"),  // Light red for quality
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 70%,
      stroke: (paint: rgb("#afa99f"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Software Quality #fa-check-circle()]]
        #v(0.5em)
        - #text(weight: "bold")[Test Generation:] creating comprehensive test suites from specifications or code
        - #text(weight: "bold")[Fault Prediction:] identifying areas of code with high risk of defects
        - #text(weight: "bold")[Bug Localization:] pinpointing exact locations of errors in large codebases
        - #text(weight: "bold")[API Documentation:] automatically generating clear and accurate documentation
      ]
    )
  ],
  [
    #block(
      fill: rgb("#f3f4e8"),  // Light yellow for maintenance
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 70%,
      stroke: (paint: rgb("#afaa9a"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Software Maintenance #fa-wrench()]]
        #v(0.5em)
        - #text(weight: "bold")[Code Review:] automating review processes to identify issues early
        - #text(weight: "bold")[Bug Prediction:] forecasting future defects based on code patterns
        - #text(weight: "bold")[Refactoring:] suggesting structural improvements while preserving behavior
        - #text(weight: "bold")[Commit Classification:] organizing version history for better project management
      ]
    )
  ]
)

== Copilot X
#align(center)[
  #image("figures/copilot-logo.png", width: 20%)
  
  #link("https://github.com/features/copilot")
]

- Solution developed by Microsoft specialized for code development
- Released in 2021, now it has more than 1 million users.
- Integrated in several IDEs
  - Visual Studio Code
  - IntelliJ

== Copilot X -- Report#footnote(link("https://github.blog/2022-09-07-research-quantifying-github-copilots-impact-on-developer-productivity-and-happiness/"))
#grid(
  columns: (35%, 55%),
  gutter: 1em,
  [#image("figures/copilot-report-1.png", width: 100%)],
  [#image("figures/copilot-report-2.png", width: 100%)]
)

== Copilot X Concerns -- Security#footnote(link("https://blog.gitguardian.com/yes-github-copilot-can-leak-secrets/"))
#align(center)[
  #image("figures/copilot-concerns.png", width: 100%)
]

== Copilot X Concerns -- Code Quality#footnote(link("https://www.gitclear.com/coding_on_copilot_data_shows_ais_downward_pressure_on_code_quality"))
#align(center)[
  #image("figures/problem-code-quality.png", width: 100%)
]

== How Copilot X Works: Understanding RAG Architecture

#block(
  fill: rgb("#e6e6e6"),
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
  [
    #text(weight: "bold")[Architectural Overview]
    
    - Built on advanced #text(weight: "bold")[Retrieval-Augmented Generation (RAG)]
    - Combines real-time code retrieval with generative AI capabilities
    - Indexes and analyzes code repositories and documentation
    - Provides context-aware suggestions based on your current project
    - Continuously improves through user feedback and interaction patterns
  ]
)

== LLMs for Software Testing

#align(center)[
  #image("figures/overview.png", width: 100%)
]

- Takeaways:
  - LLMs can be used for #emph[multiple] testing tasks.
  - Currently, LLMs are used for #emph[test case generation] and #emph[bug fix].

== LLMs for Software Testing -- Methods

#align(center)[
  #image("figures/how-llm-are-used.png", width: 100%)
]

- Takeaways:
  - Prompt Engineering is the main method used to adapt LLMs to testing tasks.
    - Why? No need to fine-tune the model.
    - Why? Can be used with any LLM.
  - #text(weight: "bold")[Zero-shot learning] is the most used method.
    - Simple and effective.
    - Concerns about its effectiveness.

== LLMs for Software Testing -- Methods

#align(center)[
  #image("figures/llm-usage.png", width: 100%)
]

- Modern solution integrate LLM in standard testing tools.
  - LLM used as an #emph[intelligent] agent in the testing process -- more example will be shown in the next slides.

== LLMs for Software Testing -- Input

#align(center)[
  #image("figures/input-llm.png", width: 50%)
]

- Takeaways:
  - Passing the code as input is the most used method.
  - Additional information seems to be useful.

== Innovative Solutions for LLMs -- LLM-Agent models

#focus-slide()[
  #align(center)[
    #text(size: 28pt, weight: "bold")[LLM-Agent-Based Architectures]
    
    #v(1em)
    
    #text(size: 20pt)[
      Complex architectures that leverage LLMs to create autonomous agents that can interact with the #emph[environment] and other LLM-agents.
    ]
  ]
]

== LLM-Agent -- Overview

#align(center)[
  #image("figures/number-of-papers.png", width: 100%)
]

== LLM-Agent -- Modules

#align(center)[
  #image("figures/overview-agents.png", width: 100%)
]

== Meta GPT

#align(center)[
  #image("figures/meta-gpt-idea.png", width: 100%)
]

== Auto GPT

#align(center)[
  #image("figures/auto-gpt-loop.png", width: 90%)
]

#align(right)[
  #link("https://github.com/Significant-Gravitas/AutoGPT")
]

== AgentVerse

#align(center)[
  #image("figures/agent-verse.png", width: 100%)
]

== Conclusion

#align(center)[
  #image("figures/king-of-all-the-king.png", width: 80%)
]
== Conclusion: The LLM Revolution in Software Engineering

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #block(
      fill: rgb("#e8f4ea"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Evolution #fa-history()]]
        
        - ML in SE has evolved from specialized models to general-purpose solutions
        - LLMs represent a #text(weight: "bold")[fundamental shift] in approach and capabilities
        - We've moved from task-specific to unified intelligence models
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e8eaf4"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#9a9faf"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Impact #fa-bolt()]]
        
        - Comprehensive application across the development lifecycle:
          - Requirements to maintenance
          - Coding to documentation
          - Testing to deployment
        - Breaking down silos between development phases
      ]
    )
  ]
)

#v(1em)

#block(
  fill: rgb("#f4eae8"),
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#afa99f"), thickness: 1pt),
  [
    #align(center)[#text(weight: "bold", size: 20pt)[New Paradigms #fa-lightbulb()]]
    
    #grid(
      columns: (1.2fr, 1fr, 1fr, 1fr),
      gutter: 0.5em,
      [#align(center)[#text(weight: "bold")[One-model-for-all] #fa-cube()]],
      [#align(center)[#text(weight: "bold")[Personalization] #fa-user-cog()]],
      [#align(center)[#text(weight: "bold")[Task adaptation] #fa-tasks()]],
      [#align(center)[#text(weight: "bold")[Agent autonomy] #fa-robot()]]
    )
    
    #align(center)[#text(style: "italic", size: 16pt)[
      "LLMs aren't just tools; they're becoming collaborative partners in software engineering"
    ]]
  ]
)

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
  - Examining (some of) ethical considerations and limitations #fa-balance-scale()
  - Anticipating future trends and preparing for AI-augmented development #fa-chart-line()

- #text(weight: "bold")[Key Applications We'll Cover:]
  - Code generation and completion #fa-code()
  - Testing and debugging implications #fa-bug()
  - Code review and quality assurance #fa-check-circle()
  - Requirements analysis and specification #fa-list-alt()

- #text(weight: "bold")[Future Directions & Concerns:]
  - Multi-agent LLM systems for collaborative development #fa-users()
  - Advanced context understanding with RAG #fa-database()
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

#block(
  fill: rgb("#e8f4ea"),  // Light green background
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Why?]
    
    - #text(weight: "bold")[Automation:] automate repetitive tasks (e.g., code generation).
    - #text(weight: "bold")[Prediction:] predict software quality, bugs, and performance.
    - #text(weight: "bold")[Optimization:] optimize software development processes.
    - #text(weight: "bold")[Understanding:] understand software artifacts and processes.
    - #text(weight: "bold")[Personalization:] personalize software development tools.
  ]
)

#block(
  fill: rgb("#e8eaf4"),  // Light blue background
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9a9faf"), thickness: 1pt),
  [
    #text(weight: "bold")[When?]
    
    - #text(weight: "bold")[Requirement Engineering:] requirements elicitation and analysis.
    - #text(weight: "bold")[Design:] design patterns, architecture, and modeling.
    - #text(weight: "bold")[Implementation:] code generation, refactoring, and bug fixing.
    - #emph[#text(weight: "bold")[Testing:]] test case generation, fault prediction...
    - #text(weight: "bold")[Maintenance:] bug prediction, code review...
  ]
)

== Machine Learning for Software Engineering -- Overview

  #align(center)[
    #image("figures/distrubution.png", width: 90%)
  ]
_From: Machine Learning for Software Engineering: A Tertiary Study_


== Early approaches -- Supervised Learning

#example[
  #text(weight: "bold")[Code Summarization (CodeNN)#footnote(link("https://github.com/sriniiyer/codenn"))]
  
  #align(center)[
    #image("figures/codenn.png", width: 80%)
  ]
]

== Early approaches -- Supervised Learning

#example[
  #text(weight: "bold")[Malware Detection#footnote("Cui, Z., Xue, F., Cai, X., Cao, Y., Wang, G., & Chen, J. (2018). Detection of Malicious Code Variants Based on Deep Learning. IEEE Trans. Ind. Informatics, 14(7), 3187–3196. doi:10.1109/TII.2018.2822680")]
  
  #align(center)[
    #image("figures/malware-detection.png", width: 80%)
  ]
]

== Early approaches -- Supervised Learning

#example[
  #text(weight: "bold")[Code Review -- Deep Review#footnote("Li, H.-Y., Shi, S.-T., Thung, F., Huo, X., Xu, B., Li, M., & Lo, D. (2019). DeepReview: Automatic Code Review Using Deep Multi-instance Learning. In Q. Yang, Z.-H. Zhou, Z. Gong, M.-L. Zhang, & S.-J. Huang (Eds.), Advances in Knowledge Discovery and Data Mining - 23rd Pacific-Asia Conference, PAKDD 2019, Macau, China, April 14-17, 2019, Proceedings, Part II (pp. 318–330). doi:10.1007/978-3-030-16145-3_25")]
  
  #align(center)[
    #image("figures/deep-review.png", width: 60%)
  ]
]

== Early approaches -- Unsupervised Learning

#example[
  #text(weight: "bold")[Code Completion (kNN)#footnote("Bruch, M., Monperrus, M., & Mezini, M. (2009). Learning from examples to improve code completion systems. In H. van Vliet & V. Issarny (Eds.), Proceedings of the 7th joint meeting of the European Software Engineering Conference and the ACM SIGSOFT International Symposium on Foundations of Software Engineering, 2009, Amsterdam, The Netherlands, August 24-28, 2009 (pp. 213–222). doi:10.1145/1595696.1595728")]
  
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
#align(center)[
  #image("figures/can-ai-code.png", width: 100%)
]
#link("https://huggingface.co/spaces/mike-ravkine/can-ai-code-results")
== LLM in SE -- Areas of Application

#v(1em)
#align(center)[#text(style: "italic")[LLMs connect each phase of development, creating a more integrated workflow and improving collaboration between developers and AI systems.]]
#v(1em)
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

== LLM in SE -- Areas of Application

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

== Copilot (Github)
#align(center)[
  #image("figures/copilot-logo.png", width: 20%)
  
  #link("https://github.com/features/copilot")
]
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #block(
      fill: rgb("#f7fafc"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 50%,
      stroke: (paint: rgb("#cbd5e0"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Overview]]
        #v(0.5em)
        - Advanced AI coding assistant by GitHub/Microsoft
        - Released 2021, #text(weight: "bold")[1M+ active developers]
        - Uses a family of specialized language models
        - Trained on billions of lines of public code
      ]
    )
  ],
  [
    #block(
      fill: rgb("#f0f9ff"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 50%,
      stroke: (paint: rgb("#bae6fd"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Key Features #fa-code()]]
        #v(0.5em)
        - Real-time code suggestions #fa-lightbulb()
        - Context-aware assistance #fa-brain()
        - Multi-language support #fa-language()
        - IDE integration (VS Code, JetBrains) #fa-plug()
      ]
    )
  ]
)

== Copilot -- Report#footnote(link("https://github.blog/2022-09-07-research-quantifying-github-copilots-impact-on-developer-productivity-and-happiness/"))
#grid(
  columns: (35%, 55%),
  gutter: 1em,
  [#image("figures/copilot-report-1.png", width: 100%)],
  [#image("figures/copilot-report-2.png", width: 100%)]
)

== A Copilot is all you need -- Code Completion
#align(center)[
  #image("figures/code-completion.png", width: 100%)
]
== A Copilot is all you need -- Code Generation
#align(center)[
  #image("figures/code-generation.png", width: 100%)
]
== A Copilot is all you need -- Test generation
#align(center)[
  #image("test-generation.png", width: 80%)
]
*Note!*: Are we sure we want test generation to be demanded to Copilot?

== A Copilot is all you need -- API Documentation
#align(center)[
  #image("documentation-generation.png", width: 100%)
]
== A Copilot is all you need -- Code Review 
#align(center)[
  #image("figures/code-review.png", width: 100%)
]
== Is it really what you need? Copilot Concerns -- Security#footnote(link("https://blog.gitguardian.com/yes-github-copilot-can-leak-secrets/"))
#align(center)[
  #image("figures/copilot-concerns.png", width: 100%)
]

== Is it really what you need?  Copilot Concerns -- Code Quality#footnote(link("https://www.gitclear.com/coding_on_copilot_data_shows_ais_downward_pressure_on_code_quality"))
#align(center)[
  #image("figures/problem-code-quality.png", width: 100%)
]


== How Copilot (Perhaps) Works: Understanding RAG Architecture

#align(center)[
  #image("figures/RAG-phases.png", width: 80%)
]
== RAG Architecture -- Data Indexing

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #block(
      fill: rgb("#f0f9ff"),
      width: 100%,
      height: 65%,
      inset: 1em,
      radius: 8pt,
      [
        #text(weight: "bold")[Data Indexing Process]
        
        - Parsing and chunking source code
        - Generating embeddings for code segments
        - Creating searchable vector database
        - Metadata extraction and annotation
        
        #v(0.5em)
        #text(style: "italic", size: 16pt)[
          "Transforms raw code repositories into structured, searchable knowledge"
        ]
      ]
    )
  ],
  [
    #block(
      fill: rgb("#f5f5f5"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 65%,
      [
        #text(weight: "bold")[Practical Considerations]
        
        - Embedding dimensions (typically 768-1536)
        - Chunking strategies (function-level, file-level)
        - Storage options (in-memory vs. persistent)
        - Indexing methods (tree-based, graph-based)
        - Handling of comments and documentation
        - Versioning and incremental updates
      ]
    )
  ]
)



#block(
  fill: rgb("#e8f4ea"),
  width: 100%,
  inset: 1em,
  radius: 8pt,
  [
    #text(weight: "bold")[Vector store:]
    
    - #text(weight: "bold")[Vector Database:] Specialized storage optimized for similarity search
    - #text(weight: "bold")[Indexing Strategies:] HNSW, IVF, etc. for efficient retrieval
    - #text(weight: "bold")[Metadata Store:] Additional context about each code fragment
    - #text(weight: "bold")[Update Mechanisms:] Keeping the index synchronized with codebase changes
  ]
)
== RAG Architecture -- Retrieval

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #block(
      fill: rgb("#f0f9ff"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      [
        #text(weight: "bold")[Retrieval Process]
        
        - Convert user query to embedding vector
        - Perform similarity search in vector space
        - Apply filters based on context/preferences
        - Rank results by relevance
        - Select top-k most relevant code examples
        
        #v(0.5em)
        #text(style: "italic", size: 16pt)[
          "Finds the most relevant code snippets based on semantic similarity"
        ]
      ]
    )
  ],
  [
    #block(
      fill: rgb("#f5f5f5"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      [
        #text(weight: "bold")[Practical Techniques]
        
        - Cosine similarity for semantic matching
        - Approximate nearest neighbor search
        - Top-k retrieval (typically k=3 to 10)
        - Re-ranking strategies for relevance
        - Hybrid retrieval (combining keyword and vector search)
        - Context window management (token limits)
        - Filtering by programming language or domain
      ]
    )
  ]
)
== RAG Architecture -- Augmentation & Generation
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #block(
      fill: rgb("#fff8e1"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      [
        #text(weight: "bold")[Context Augmentation]
        - Enrich prompts with retrieved code examples
        - Include documentation and project conventions
        - Incorporate API usage examples and test cases
        
        #text(style: "italic", size: 16pt)[
          "Enhances LLM knowledge with relevant context"
        ]
      ]
    )
  ],
  [
    #block(
      fill: rgb("#f5f5f5"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      [
        #text(weight: "bold")[Augmentation Strategies]
        - Template-based prompt construction
        - Context prioritization and structured formatting
        - Documentation and error case integration
        - Dependency analysis and style pattern extraction
      ]
    )
  ]
)

#block(
  fill: rgb("#e8eaf4"),
  width: 100%,
  inset: 1em,
  radius: 8pt,
  [
    #text(weight: "bold")[Generation Benefits:]
    
    - #text(weight: "bold")[Grounded Responses:] Code generation based on real examples
    - #text(weight: "bold")[Up-to-date Information:] Access to latest APIs and patterns
    - #text(weight: "bold")[Project Consistency:] Alignment with existing codebase styles
    - #text(weight: "bold")[Reduced Hallucination:] Minimizes fabricated or incorrect code
    - #text(weight: "bold")[Context Awareness:] Understanding of project-specific requirements
  ]
)



== LLMs for Software Testing #footnote(link("https://arxiv.org/abs/2307.07221"))
#focus-slide()[
  #align(center)[
    #text(size: 28pt, weight: "bold")[LLMs for Software Testing]
    
    #v(1em)
    
    #text(size: 20pt)[
      Leveraging Large Language Models to enhance software testing processes and improve code quality.
    ]
  ]
]
== LLMs for Software Testing -- Overview

#align(center)[
  #image("figures/overview.png", width: 100%)
]

- Takeaways:
  - LLMs can be used for #emph[multiple] testing tasks.
  - Currently, LLMs are used for #emph[test case generation] and #emph[bug fix].
  - The image shows a strong focus on #emph[unit testing] applications.
  - There's significant interest in using LLMs for #emph[test oracle creation] - determining expected outputs.
  - Most research combines LLMs with #emph[traditional testing frameworks] rather than replacing them.

== LLMs for Software Testing -- Methods

#align(center)[
  #image("figures/how-llm-are-used.png", width: 100%)
]
- #text(weight: "bold")[Key Findings:]
  - #text(weight: "bold")[Prompt Engineering dominates] as the primary adaptation method:
    - Requires no model fine-tuning → lower computational cost
    - Offers flexibility across different LLM platforms
    - Enables rapid iteration of testing approaches
  
  - #text(weight: "bold")[Learning approaches spectrum:]
    - #text(weight: "bold")[Zero-shot learning] (88%) is most prevalent
      - Advantages: Simplicity, minimal setup, immediate application
      - Limitations: Often lacks domain-specific precision, inconsistent results
    
    - #text(weight: "bold")[Few-shot learning] provides middle ground:
      - Balances implementation ease with improved performance
      - Critical for complex testing scenarios with specific patterns

== LLMs for Software Testing -- Methods

#align(center)[
  #image("figures/llm-usage.png", width: 100%)
]

- #text(weight: "bold")[Modern solutions integrate LLMs in standard testing tools:]
    - LLMs are used as #emph[intelligent agents] in the testing process.
    - Examples include:
      - #text(weight: "bold")[Statistic analysis:] leveraging statistical methods to enhance testing.
      - #text(weight: "bold")[Program analysis:] using LLMs to analyze and improve code.
      - #text(weight: "bold")[Mutation testing:] generating and evaluating mutants to improve test quality.
      - #text(weight: "bold")[Syntactic repair:] automatically fixing syntax errors.
      - #text(weight: "bold")[Differential testing:] comparing outputs of different program versions.
      - #text(weight: "bold")[Reinforcement learning:] applying RL techniques to optimize testing strategies.
      - #text(weight: "bold")[Others:] various other innovative uses of LLMs in testing.

== Mutation testing
  #align(center)[
    #text(size: 28pt, weight: "bold")[Mutation Testing with LLMs]
    
    #v(1em)
    
    #text(size: 20pt)[
      Using LLMs to intelligently generate and evaluate code mutations to assess test suite quality
    ]
  ]
  
  #v(1em)
  
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      #block(
        fill: rgb("#e8f4ea"),
        width: 100%,
        inset: 1em,
        height: 40%,
        radius: 8pt,
        [
          #text(weight: "bold")[Traditional Mutation Testing]
          - Random code alterations
          - Computationally expensive
          - Many irrelevant mutations
          - Limited mutation operators
        ]
      )
    ],
    [
      #block(
        fill: rgb("#e8eaf4"),
        width: 100%,
        inset: 1em,
        height: 40%,
        radius: 8pt,
        [
          #text(weight: "bold")[LLM-Enhanced Mutation Testing]
          - Semantically meaningful mutations
          - Context-aware code changes
          - Targeting edge cases and vulnerabilities
          - Higher-quality mutants with fewer resources
        ]
      )
    ]
  )
  
== Mutation Testing -- Example
  #v(1em)
  
    #grid(
      columns: (1fr),
      gutter: 0.5em,
      [
        #block(
          fill: rgb("#f5f5f5"),
          width: 100%,
          inset: 0.8em,
          radius: 4pt,
          [
            #text(weight: "bold")[Original code:]
            ```python
            def divide(a, b):
                return a / b
            ```
          ]
        )
      ]
    )
    
    #text(weight: "bold")[LLM-generated intelligent mutations:]
    
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        #block(
          fill: rgb("#fff8e1"),
          width: 100%,
          inset: 0.8em,
          radius: 4pt,
          [
            #text(weight: "bold")[Boundary case mutation]
            ```python
            def divide(a, b):
                return a / (b + 0.0001)  # Avoid exact zero
            ```
          ]
        )
      ],
      [
        #block(
          fill: rgb("#e3f2fd"),
          width: 100%,
          inset: 0.8em,
          radius: 4pt,
          [
            #text(weight: "bold")[Error handling mutation]
            ```python
            def divide(a, b):
                if b == 0: return float('inf')
                return a / b
            ```
          ]
        )
      ]
    )
    
    #grid(
      columns: (1fr),
      gutter: 0.5em,
      [
        #block(
          fill: rgb("#e8f5e9"),
          width: 100%,
          inset: 0.8em,
          radius: 4pt,
          [
            #text(weight: "bold")[Logic inversion mutation]
            ```python
            def divide(a, b):
                return b / a  # Swap arguments
            ```
          ]
        )
      ]
    )
  

== LLMs for Software Testing -- Input

#align(center)[
  #image("figures/input-llm.png", width: 50%)
]

- Takeaways:
  - #text(weight: "bold")[Code (68%)]: Majority of inputs are code snippets - core focus on code-related tasks
  - #text(weight: "bold")[Bug descriptions (10%)]: Essential for understanding and fixing issues
  - #text(weight: "bold")[Error information (6%)]: Critical for debugging and issue resolution
  - #text(weight: "bold")[UI hierarchy files (5%)]: Useful for testing user interfaces and interactions


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

== LLM-Agent -- Why?
#block(
  fill: rgb("#e8f4ea"),
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Evolving Beyond Single LLMs]
    
    - #text(weight: "bold")[Complex Problem Solving:] Break down software engineering tasks into manageable sub-tasks
    - #text(weight: "bold")[Specialized Expertise:] Different agents can be optimized for specific development phases
    - #text(weight: "bold")[Tool Integration:] Agents can leverage external tools (debuggers, profilers, version control)
    - #text(weight: "bold")[Autonomous Operation:] Reduced human intervention for repetitive or complex tasks
    - #text(weight: "bold")[Collaborative Development:] Multiple agents working together mimic team dynamics
  ]
)


#block(
  fill: rgb("#e8eaf4"),
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9a9faf"), thickness: 1pt),
  [
    #text(weight: "bold")[Benefits for Modern Software Engineering]
    
    - #text(weight: "bold")[End-to-End Solutions:] Complete software development lifecycle coverage
    - #text(weight: "bold")[Reasoning & Planning:] Strategic approaches rather than just tactical responses
    - #text(weight: "bold")[Self-Improvement:] Agents can learn from feedback and outcomes
    - #text(weight: "bold")[System Integration:] Seamless connection with existing development workflows
    - #text(weight: "bold")[Scalability:] Handles growing complexity of modern software projects
  ]
)
== LLM-Agent -- Modules

#align(center)[
  #image("figures/overview-agents.png", width: 100%)
]


== AIder -- The AI Developer#footnote(link("https://aider.chat/"))
#align(center)[
  #image("figures/aider.png", width: 80%)
]

== Auto GPT

#align(center)[
  #image("figures/auto-gpt-loop.png", width: 90%)
]


== Meta GPT

#align(center)[
  #image("figures/meta-gpt-idea.png", width: 100%)
]


#align(right)[
  #link("https://github.com/Significant-Gravitas/AutoGPT")
]

== AgentVerse

#align(center)[
  #image("figures/agent-verse.png", width: 100%)
]

== ... And Many Others :)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  [
    #align(center)[
      #image("figures/all-hands.png",  height: 50%)
      #text(weight: "bold")[All Hands]
    ]
    ],
    [
    #align(center)[
      #image("figures/lang-graph.png", height: 50%)
      #text(weight: "bold")[Lang Graph]
    ]
    ],
    [
    #align(center)[
      #image("figures/crewai.png", height: 50%)
      #text(weight: "bold")[Crew AI]
    ]
    ],
)
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

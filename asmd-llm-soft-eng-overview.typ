#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.1.0": *
#import "@preview/ctheorems:1.1.2": *
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
    subtitle: [LLM Primer and Overview],
    author: [Gianluca Aguzzi],
    date: datetime.today().display("[day] [month repr:long] [year]"),
    institution: [Università di Bologna],
    // logo: emoji.school,
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 18pt)
#show math.equation: set text(font: "Fira Math")

#title-slide()

= Introduction 

== Today Lesson in a Nutshell
#align(center)[
    #image("figures/meme.jpg", width: 60%)
  ]


== Today Lesson (Seriously)
- #text(weight: "bold")[Goal:] Understand the fundamentals of Natural Language Processing (NLP) and Language Models (LM).

  - From a "practical" perspective.
  - Understanding the basic concepts and the common tasks.
  - How to use them from API and libraries.
  - How to "tune" them for specific (soft. eng.) tasks.
- #text(weight: "bold")[Note:]
  - We will not dive too much into the details of the algorithms and the mathematics behind them.
  - For this, please refer to the resources provided and the course on NLP.
- #text(weight: "bold")[Next:]
  - Vertical focus on the use of LLM in Software Engineering.
  - Research oriented directions.

== NLP & Soft. Eng. -- Why BTW?
#align(center)[
  #image("figures/copilot.png", width: 80%)

]
== NLP & Soft. Eng. -- Why BTW?
#align(center)[
  #image("figures/copilot copy.png", width: 100%)
]

== NLP & Soft. Eng. -- Why BTW?
#align(center)[
  #image("figures/soft-eng-improvements.png", width: 50%)
]
== NLP & Soft. Eng. -- Why Should We Care?
- The Software Engineering landscape is *rapidly evolving*: #fa-rocket()
  - AI pair programmers (like Copilot) are becoming ubiquitous tools #fa-robot()
  - LLMs can now handle tasks previously requiring human expertise: #fa-brain()
    - Intelligent code completion #fa-code()
    - Automated documentation generation #fa-file-alt()
    - Assisted refactoring and optimization #fa-wrench()
    - Test case generation #fa-vial()
  - Key questions for modern developers: #fa-question-circle()
    - What will be our role in this AI-augmented future? #fa-user-cog()
    - How can we best leverage NLP to enhance our productivity? #fa-chart-line()
    - Which skills remain uniquely human in software development? #fa-fingerprint()
  - Understanding this technology isn't optional—it's essential for staying relevant #fa-lightbulb() #fa-exclamation()

= Natural Language Processing and (Large) Language Models
#focus-slide()[
#align(center)[
  #text(size: 28pt, weight: "bold")[Natural Language Processing (NLP)]
  
  #v(1em)
  
  #text(size: 20pt)[
    A subfield of artificial intelligence that focuses #emph[understanding], #emph[interpreting], and #emph[generating] human language.
  ]
  #v(1em)
]
#align(left)[
  #text(size: 18pt, weight: "bold")[Resources]
  #set list(indent: 1em)
  #set text(font: "Fira Sans", weight: "light", size: 18pt)
  - #link("https://github.com/keon/awesome-nlp?tab=readme-ov-file")
  - #link("https://github.com/brianspiering/awesome-dl4nlp")
  - #link("https://nlpprogress.com/")
  - #link("https://www.youtube.com/watch?v=LPZh9BOjkQs")
  ]
]


== Natural Language Processing

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Goal]
    
    Identify the structure and meaning of #emph[words], #emph[phases], and #emph[sentences] in order to enable computers to understand and generate human language.
  ]
)

#block(
  fill: rgb("#e6e6e6"),  // Light gray
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
  [
    #text(weight: "bold")[Why?]
    
    Improve #emph[human-computer] interaction, closing the gap between #emph[human communication] and #emph[computer understanding].
  ]
)

#block(
  fill: rgb("#e6e6e6"),  // Light gray
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
  [
    #text(weight: "bold")[Applications #text(weight: "bold")[(all around us)]]
    
    #grid(
      columns: 3,
      gutter: 1em,
      [
        - #emph[Chatbots]
        - #emph[Machine Translation]
        - #emph[Speech Recognition]
      ],
      [
        - #emph[Sentiment Analysis]
        - #emph[Question Answering]
        - #emph[Code Generation]
      ],

      [
        - #emph[Image Captioning]
        - #emph[Summarization]
        - #emph[Text Classification]
      ]
    )
  ]
)


== Natural Language Processing

#block(
fill: rgb("#fde8e986"),  // Light gray
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#d4c3c4"), thickness: 1pt),
  [
    #text(weight: "bold")[Challenges]
    
    - #text(weight: "bold")[Ambiguity:] Multiple meanings for words/phrases.
    - #text(weight: "bold")[Context:] Meaning shifts with context (linguistic, cultural).
    - #text(weight: "bold")[Syntax:] Sentence structure affects meaning.
    - #text(weight: "bold")[Sarcasm/Idioms:] Non-literal language interpretation.
  ]
)

#block(
  fill: rgb("#e6e6e6"),  // Light gray
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
  [
    #text(weight: "bold")[Approaches]
    
    - #text(weight: "bold")[Rule-Based:] Hand-crafted linguistic rules (e.g., #link("https://en.wikipedia.org/wiki/Georgetown-IBM_experiment")[Georgetown–IBM]).
    - #text(weight: "bold")[Statistical:] Probabilistic language modelling (e.g., hidden Markov model)#footnote("Mérialdo, B. (1994). Tagging English Text with a Probabilistic Model. Comput. Linguistics, 20(2), 155–171.")
    - #text(weight: "bold")[ML/Deep Learning:] Algorithms learn from data; neural networks model complex patterns (RNN#footnote("Yin, W., Kann, K., Yu, M., & Schütze, H. (2017). Comparative Study of CNN and RNN for Natural Language Processing. CoRR, abs/1702.01923. Retrieved from http://arxiv.org/abs/1702.01923"), LSTM#footnote("Hochreiter, S., & Schmidhuber, J. (1997). Long Short-Term Memory. Neural Comput., 9(8), 1735–1780. doi:10.1162/NECO.1997.9.8.1735"), GRU#footnote("Dey, R., & Salem, F. M. (2017). Gate-variants of Gated Recurrent Unit (GRU) neural networks. IEEE 60th International Midwest Symposium on Circuits and Systems, MWSCAS 2017, Boston, MA, USA")) 
    - _Goal_: Find a *Language Model* that understands and generates human language.
  ]
)
#focus-slide()[
  #align(center)[
  #text(size: 28pt, weight: "bold")[What is a #text(weight: "bold")[Language Model]?]
  
  #v(1em)
  
  #text(size: 20pt)[
    A #emph[machine learning] model that aims to predict and generate *plausible* text.
  ]


  #align(
    center,
    block[
      #image("figures/llm-nutshell.png", width: 80%)
    ]
  )
  ]
]
== Language Models
#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[ Fundamental Idea]
    
    Text is a sequence of words, and language models learn the *probability distribution* of a word given the previous words in context.
  ]
)

#block(
  fill: rgb("#e6e6e6"),  // Light gray
  width: 100%,
  inset: 1.2em,
  radius: 8pt,
  stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
  [
    #text(weight: "bold")[ Simple Examples]
    
    - #emph[The customer was very happy with the <\*>]
    - #emph[The customer was very happy with the #text(weight: "bold", fill: rgb("#555555"))[service].]
    - #emph[The customer was very happy with the #text(weight: "bold", fill: rgb("#555555"))[product].]
  ]
)

#block(
  fill: rgb("#e6e6e6"),  // Light gray
  width: 100%,
  inset: 1.2em,
  radius: 8pt,
  stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
  [
    #text(weight: "bold")[Common Tasks]
    
    - #emph[Text Generation:] Complete or continue text based on a prompt
    -  #emph[Classification:] Categorize text (sentiment, topic, intent)
    - #emph[Question Answering:] Find answers within a context
    - #emph[Summarization:] Condense longer texts into summaries
    -  #emph[Translation:] Convert text between languages
  ]
)
== Language Models -- Phases


*1. Tokenization:* split text into words, phrases, symbols, etc.
- _Example:_ "Hello, world!" #fa-arrow-right() ["Hello", ",", "world", "!"]

*2. Embedding:* convert words into numerical vectors.
- _Example:_ "Hello" #fa-arrow-right() [0.25, -0.75, 0.5, 1.0]
- It is possible to use pretrained embeddings (e.g., Word2Vec, BERT).

*3. Modelling:* learn the probability of a word given the previous words.
- _Example:_ P("world" | "Hello,") #fa-arrow-right() 0.8

*4. Generation/Classification:* use the model to generate text or classify it.
- _Example for Generation:_ Input: "The weather is" #fa-arrow-right() Output: "sunny."
- _Example for Classification:_ Input: "This is a spam email." #fa-arrow-right() Output: Spam

#v(0.5em)

#text(weight: "bold")[Note:] each NLP solution can use different techniques for each phase.

== Tokenization
#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Tokenization: Breaking Text into Pieces]
    
    Splitting text into discrete units (tokens) for the model to process.
    #link("https://platform.openai.com/tokenizer")
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 65%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Example]
        
        "I heard a dog bark loudly at a cat"
        
        #text(size: 16pt)[
          Tokenized as: {1, 2, 3, 4, 5, 6, 7, 3, 8}
          
          Where:
          - I (1)
          - heard (2)
          - a (3)
          - dog (4)
          - bark (5)
          - loudly (6)
          - at (7)
          - cat (8)
        ]
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 65%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[In Practice]
        
        - Tokens can be words, subwords, or characters
        - Modern models use subword tokenization
        - Vocabulary size: typically 30k-100k tokens
        - Out-of-vocabulary words get split into known tokens
        - Special tokens: [START], [END], [PAD], [MASK]
      ]
    )
  ]
)

== Embedding
#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Embedding: Converting Words to Numbers]
    
    Translating tokens into numerical vectors that capture *semantic meaning*.
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 65%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Example]
        
        "dog" might be represented as:
        
        #text(size: 16pt)[
          [0.2, -0.4, 0.7, 0.1, ...]
          
          Properties:
          - Similar words have similar vectors
          - "dog" is closer to "puppy" than to "table"
          - Vector dimensions capture semantic features
          - Enables mathematical operations on words
        ]
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 65%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[In Practice]
        
        - Vectors typically have 100-1000 dimensions
        - Word2Vec, GloVe: Static embeddings
        - BERT, GPT: Contextual embeddings
        - Enables semantic operations:
          "king" - "man" + "woman" ≈ "queen"
        - Forms foundation for downstream tasks
      ]
    )
  ]
)


== Embedding -- Visual Example
#align(
  center,
  block[
    #image("figures/embedding-meaning.png", width: 100%)
  ]
)

== Modelling -- How?
#align(
  center,
  block[
    #image("figures/text-generation.png", width: 100%)
  ]
)


== Modelling -- How?
#align(
  center,
  block[
    #image("figures/cnn-text.png", width: 100%)
  ]
)

== Modelling -- CNN and RNN Limitations
#text(weight: "bold")[Limitations of Traditional Approaches]

- #text(weight: "bold")[RNN:] Long-term dependencies are hard to capture
- #text(weight: "bold")[RNN:]  Slow to train; not suitable for large-scale data
- #text(weight: "bold")[CNN:] Fixed-size input window; not suitable for variable-length text
- #text(weight: "bold")[Both:] Struggle with large-scale parallelization
- #text(weight: "bold")[Solution:] #fa-lightbulb() #emph[Multi-head self-attention] — the core of #emph[transformers]

Transformers overcome these limitations by: #fa-rocket()
- Processing entire sequences in parallel #fa-bolt()
- Using attention to weigh token importance #fa-balance-scale()
- Capturing relationships across arbitrary distances #fa-project-diagram()
- Enabling efficient training on massive datasets #fa-database()

== Transformers -- Visual
#align(
  center,
  block[
    #image("figures/TransformerBasedTranslator.png", width: 100%)
  ]
)
== Transformers Architecture
#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Transformers: State-of-the-Art for Language Models]
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 70%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Architecture Types]
        
        - #text(weight: "bold")[Encoder-only:]
          - Creates embeddings from input text
          - Use: Classification, token prediction
          - Examples: BERT, RoBERTa
          
        - #text(weight: "bold")[Decoder-only:]
          - Generates new text based on context
          - Use: Continuations, chat responses
          - Examples: *GPT family, LLaMA*
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 70%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Full Transformers]
        
        - Contains both encoder and decoder
        - #text(weight: "bold")[Encoder:] Processes input into intermediate representation
        - #text(weight: "bold")[Decoder:] Converts representation into output text
        - Example use case: Translation
          - English → Intermediate representation → French
        - Examples: *T5, BART, Marian MT*
      ]
    )
  ]
)

== Transformers -- Self-attention

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Self-attention:] The Key to Context Understanding -- #link("https://bbycroft.net/llm")
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 60%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[The Core Question]
        
        For each token, self-attention asks:

        "How much does each other token affect the interpretation of this token?"
        
        - Attention weights determine token relationships
        - "Self" means within the same input sequence
        - Enables context-aware understanding
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 60%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Example]
        
        "The animal didn't cross the street because it was too tired."
        
        - Each word pays attention to all others
        - Pronoun "it" is *ambiguous*
        - Self-attention reveals: "it" refers to "animal"
        - Resolves dependencies across *arbitrary distances*
      ]
    )
  ]
)

== Self-attention -- Visual

#align(
  center,
  block[
    #image("figures/self-attention.png", width: 50%)
  ]  
)
- Self-attention calculates *weighted relationships* between every token #fa-arrows-alt()
- These relationships reveal which parts of text should *influence* each token #fa-lightbulb()
- Attention weights are *learned parameters* during model training #fa-cogs()
- Multi-head attention allows model to focus on *different relationship types* simultaneously #fa-layer-group()
- This mechanism captures both *local and long-range dependencies* #fa-project-diagram()

== Text Generation: From Probabilities to Text 

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Text Generation]: Turning Model Output into Human-Readable Text
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 73%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[The Generation Process]
        
        1.  Model receives a prompt or seed text (e.g., "The cat sat on the...")
        2.  Model predicts probabilities for the *next* token based self-attention encoding
        3.  A token is selected from this distribution based
        4.  Selected token is added to the sequence
        5.  Process repeats until stopping criterion is met
        
        #text(weight: "bold")[Key Idea:] Building a sequence one token at a time
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 73%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Decoding Strategies]
        
        - #text(weight: "bold")[Greedy:] Always choose the highest probability token
        - #text(weight: "bold")[Random:] Sample from the probability distribution
        - #text(weight: "bold")[Top-k:] Sample from k most likely tokens
        - #text(weight: "bold")[Top-p/Nucleus:] Sample from the smallest set with probability > p
        - #text(weight: "bold")[Beam Search:] Track multiple candidate sequences
      ]
    )
  ]
)

== Text Generation: Temperature

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Temperature]: Controlling Randomness
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 70%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[How Temperature Works]
        
        - Modifies probability distribution before sampling
        - Applied by dividing logits by temperature value
        - Softmax function then applied to get new probabilities
        
        #text(weight: "bold")[Formula (Simplified):]
        
        `probabilities = softmax(logits / temperature)`
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 70%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[The Effect of Temperature]
        
        - #text(weight: "bold")[High (≥ 1.0):] Flatter distribution, more random and creative
        - #text(weight: "bold")[Low (≈ 0.2):] Sharper distribution, more coherent but repetitive
        - #text(weight: "bold")[Zero:] Equivalent to greedy decoding
        
        #text(weight: "bold")[Analogy:] Temperature controls the "spice level" of the text
      ]
    )
  ]
)

== Text Generation: Example

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Example:] Generating Text with Different Temperatures
  ]
)

#block(
  fill: rgb("#e6e6e6"),
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
  [
    #text(weight: "bold")[Prompt:] The quick brown fox...
    
    #text(weight: "bold")[Temperature = 0.2:] The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox... (Repetitive)
    
    #text(weight: "bold")[Temperature = 0.7:] The quick brown fox jumps over the lazy dog. It was a sunny day, and the fox was happy.
    
    #text(weight: "bold")[Temperature = 1.2:] The quick brown fox dances with a sparkly unicorn under a rainbow made of cheese, giggling!
    
    #text(size: 10pt, style: "italic")[Note: These examples are illustrative. The actual output depends on the specific model.]
  ]
)


== Large Language Model (LLM)
#focus-slide()[
  #align(center)[
    #text(size: 28pt, weight: "bold")[Large Language Model (LLM)]
    
    #v(1em)
    
    #text(size: 20pt)[
      A #emph[language model] with a #emph[large] number of parameters, trained on a #emph[large] corpus of text.
    ]
  ]
]
== LLM -- Implementation Strategies

- #text(weight: "bold")[Transformers] as the foundational architecture, characterized by:
  - Long-range context (#emph[Attention])
  - Efficient large-scale training (#emph[Parallelization])
  - Model growth (#emph[Scalability])
- #text(weight: "bold")[Pretraining:] Involves training the model on a vast corpus of text to learn a wide range of language patterns and structures.
- #text(weight: "bold")[Fine-tuning:] Refines the pretrained model for specific tasks, enhancing its applicability and performance on targeted applications.

== LLM -- Self-Supervised Phase
#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Self-Supervised Learning]: Learning directly from data without human annotations
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 65%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[What Makes It Self-Supervised?]
        
        - Data creates its *own supervision signal*
        - No human annotations or labels needed
        - Model learns to predict parts of its input
        - Example: "The \_\_ of sleepy town weren't \_\_" #fa-arrow-right() "people, happy"
        - Leverages *natural structure* in language itself
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 65%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Advantages]
        
        - Uses *unlimited* text data from the internet
        - Scales efficiently with more data and compute
        - Creates rich representations of language
        - Learns grammar, facts, reasoning, and more
        - Forms foundation for downstream adaptation
      ]
    )
  ]
)

== LLM -- Training Paradigms
#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[The Learning Cake:] An analogy to describe the layered approach in training methodologies.
  ]
)

#block(
  fill: rgb("#e6e6e6"),
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
  [
    - #text(weight: "bold")[Self-supervised Learning:] Models learn patterns from unlabelled data, reducing the need for expensive annotations. Ideal for initial #emph[understanding] of language structures.
    
    - #text(weight: "bold")[Supervised Learning:] Enhances accuracy with labeled data, crucial for tasks requiring specific outcomes like #emph[classification] and #emph[translation].
    
    - #text(weight: "bold")[Reinforcement Learning:] Adapts through trial and error using rewards, fine-tuning decision-making skills in scenarios like #emph[dialogue generation] (chatbots).
  ]
)

== LLM -- Paradigm Shift
#align(center)[
  #image("figures/llm-idea.jpg", width: 80%)
]
- LLMs are foundational for Modern NLP #fa-lightbulb() !!

== LLM -- Foundational Models (GenAI)
- A *Foundational Model* is a large model that serves as the basis for a wide range of downstream applications.
- It is related to several generative AI models (diffusion, transformers, etc.).
#align(center)[
  #image("figures/foundation.jpg", width: 60%)
]

== Difference with Traditional Models
#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Traditional ML Pipeline vs. Foundation Model Approach]
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Traditional ML]
        
        - Task-specific datasets
        - Models built for single purposes
        - Linear development pipeline
        - Requires retraining for new tasks
        - Limited transfer of knowledge
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Foundation Model Approach]
        
        - General knowledge acquisition first
        - Adaptation to downstream tasks
        - Efficient knowledge transfer
        - Zero/few-shot capabilities
        - Single model, multiple applications
      ]
    )
  ]
)

- Adaptation is a kind of "transfer learning" to other tasks
- With foundational LLMs, this adaptation may not require additional learning:
  - LLMs function as zero-shot or few-shot learners (more details later)
  - With just the right instructions (prompts), they can perform a wide range of tasks
- This represents a fundamental paradigm shift in AI and NLP development

== LLM -- Scalability
#align(center)[
  #image("figures/over-year.jpg", width: 100%)
]

== LLM -- Scalability
#align(center)[
  #image("figures/image-size.png", width: 100%)
]

== LLM -- Emergent Properties#footnote("Wei, J., Tay, Y., Bommasani, R., Raffel, C., Zoph, B., Borgeaud, S., ... & Zhou, D. (2022). Emergent abilities of large language models. arXiv preprint arXiv:2206.07682.")
#align(center)[
  #grid(
    columns: 2,
    gutter: 1em,
    [#image("figures/small.jpg", width: 70%)],
    [#image("figures/medium.jpg", width: 100%)]
  )
  
  #v(1em)
  #image("figures/big.jpg", width: 80%)
]

== LLM -- State-of-the-art foundational models

- "Open" #fa-unlock() vs "Closed" #fa-lock() #h(0.4em) models
  - Open #fa-arrow-right() #h(0.4em) are available for public use and research (you have access to the model and its parameters).
  - Closed #fa-arrow-right() #h(0.4em) are proprietary and not available for public use or research (you can just use the API).
- #text(weight: "bold")[GPT-\*] #fa-lock(): generative Pre-trained Transformer (OpenAI)
  - State-of-the-art in #emph[language generation] and #emph[translation].
  - GPT > 4 is multi-modal, capable of processing text, images, and audio.

- #text(weight: "bold")[Gemini] #fa-lock(): most capable multi-modal model from Google.

- #text(weight: "bold")[Llama \*] #fa-unlock(): Large Language Model Meta AI (Meta) 
  - One of the first open source LLMs with a relevant number of parameters.

- #text(weight: "bold")[DeepSeek] #fa-unlock(): a large-scale, open-source LLM with very low cost for training.
- #text(weight: "bold")[Mistral#footnote("jiang2023mistral")/Mixtral#footnote(link("https://huggingface.co/docs/transformers/model_doc/mixtral"))/Falcon#footnote("almazrouei2023falcon")] #fa-unlock(): several completely open and transparent models from several companies.

#align(center)[
  More at: #link("https://lifearchitect.ai/models-table/")
]

== LLM Applications: Chatbots #footnote[#link("https://openai.com/blog/chatgpt")]
#align(center)[
  #image("figures/image.svg", width: 100%)
]

== LLM Applications: Medical Diagnosis #footnote[#link("https://sites.research.google/med-palm/")]
#align(center)[
  #image("figures/palm-med.png", width: 100%)
]

== Robotics #footnote[#link("https://deepmind.google/discover/blog/a-generalist-agent/")]
#align(center)[
  #image("figures/generalistic-agent.jpeg", width: 90%)
]

== LLM Concerns -- Training Cost
#align(center)[
  #image("figures/training-cost.jpg", width: 80%)
]

== LLM Concerns -- Privacy
#align(center)[
  #image("figures/italy-privacy-concern.png", width: 100%)
]

== LLM Concerns -- Hallucination
#emph[Hallucination] is the generation of text that is not grounded in reality.
#align(center)[
  #image("figures/hallucinations.png", width: 100%)
]

= LLM in Practice -- API and Prompt Engineering

== Interact with LLMs


- Via direct API: using the weights of the model.
  - #fa-thumbs-up() #h(0.4em) Full access to the model, it can be also fine-tuned
  - #fa-thumbs-down() #h(0.4em)  Sometimes you do not have access to model weights (e.g., GPT-3)
  - #fa-thumbs-down() #h(0.4em)  Sometimes even if the model is open, it is too #emph[big] to be used in a local environment (e.g., Falcon 180b)

- Via HTTP API: using a #emph[web service] that wraps the model.
  - OpenAI as reference#footnote(link("https://platform.openai.com/"))
  - #fa-thumbs-up() #h(0.4em) Easy to use
  - #fa-thumbs-up() #h(0.4em) Can be used in #emph[any] environment
  - #fa-thumbs-up() #h(0.4em) Can also be used with #emph[local] models (e.g., ollama)
  - #fa-thumbs-up() #h(0.4em) it supports both synchronous and asynchronous requests

== Ollama
#align(center)[
  #image("figures/ollama.png", width: 30%)
  
  #link("https://ollama.com/")
]

- A platform that wraps LLMs in a web service.
  - More than 60 models available.
  - Allow customizing the model.
  - Native performance for LLMs.
  - Support both embedding and generation tasks.
  - It is possible to set several parameters (e.g., temperature, top-k, etc.)

- How to use?
  - Pull a model: `ollama pul llama3.2`
  - Use the model: `ollama run llama3.2`
  - Start a web service: `ollama serve`


== LangChain
#align(center)[
  #image("figures/logo.png", width: 50%)
  
  #link("https://github.com/langchain-ai/langchain")
]

- A framework for developing applications powered by language models.
- Features:  
  - Support several API providers (e.g., OpenAI, Ollama, etc.)
  - Support the combination of several processing steps (e.g., prompting, chaining, etc.)
  - Support the context retrivial (e.g., RAG)
- In this course we will use the Java version of the framework.
  - #link("https://github.com/langchain4j/langchain4j")
#focus-slide()[
  == Demo
  #link("https://github.com/cric96/asmd-llm-code")
]

== LLM in Practice -- Prompt Engineering

- #text(weight: "bold")[Prompt Engineering] is the art of crafting the right instructions for the model to perform a specific task.

- #text(weight: "bold")[Prompts] are the input text that guides the model's behavior.
  - They can be as simple as a few words or as complex as a full paragraph.
  - They can be used to steer the model towards a specific task or style of output.
  - They can be used to provide context or constraints for the model's output.

- For an overview of the best practices in prompt engineering, see the #link("https://www.promptingguide.ai/")[Prompt Engineering Handbook].

== Prompt Engineering -- Zero Shot

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Zero-shot Learning] allows a model to perform a task without any training examples.
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 55%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Key Concepts]
        
        - Model is given a prompt describing the task
        - Uses pre-existing knowledge from training
        - No examples or fine-tuning required
        - Works for tasks never explicitly taught
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 55%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Example]
        
        #text(weight: "bold")[Intent:] Sentiment classification
        
        #text(weight: "bold")[Prompt:] 
        
        ``` Classify the sentiment of this review as positive, negative, or neutral: 'This restaurant had amazing food but terrible service.```
        
        #text(weight: "bold")[Output:] 
        ```
        Negative/Mixed
        ```
      ]
    )
  ]
)

== Prompt Engineering -- Few Shot

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Few-shot Learning]
    perform a task with just a few examples provided directly in the prompt.
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 75%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Key Concepts]
        
        - Model is given a prompt with a few labeled examples
        - Examples demonstrate the desired pattern or format
        - Examples act as implicit instructions for the task
        - Model learns to mimic the pattern in new cases
        - Significantly improves performance over zero-shot
        - Bridges general knowledge and specific task requirements
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 75%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Example]
      
        #text(weight: "bold")[Intent:] Classifying emails
        
        #text(weight: "bold")[Prompt:] 
        ```
        Classify the following emails as SPAM or NOT SPAM:
        Email: "Congratulations! You've won $1,000,000 in our lottery!" -> SPAM
        Email: "Meeting scheduled for tomorrow at 2pm in the conference room." -> NOT SPAM
        Email: "Your account has been compromised."
        Classification: 
        ```
        
        #text(weight: "bold")[Output:] "SPAM" (model learns the pattern from examples)
      ]
    )
  ]
)

== Prompt Engineering -- Chain of Thought

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Chain of Thought] is a technique that involves chaining multiple prompts together to guide the model's output.
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 80%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Key Concepts]
        
        - Encourages model to show step-by-step reasoning
        - Explicitly asks model to "think aloud" before answering
        - Breaks complex problems into manageable steps
        - Dramatically improves accuracy for reasoning tasks
        - Reduces logical errors by exposing intermediate thinking
        - Particularly effective for math, logic, and multi-step problems
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 80%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Example]
      
        #text(weight: "bold")[Intent:] Math word problem solving
        
        #text(weight: "bold")[Prompt:] 
        ```
        Solve this step-by-step:
        
        If John has 5 apples and gives 2 to Mary, then buys 3 more, 
        how many apples does John have now?
        ```
        
        #text(weight: "bold")[Output:] 
        ```
        Let me solve this step-by-step:
        1. John starts with 5 apples
        2. John gives 2 apples to Mary: 5 - 2 = 3 apples
        3. John buys 3 more apples: 3 + 3 = 6 apples
        John now has 6 apples.
        ```
      ]
    )
  ]
)

== Prompt Engineering -- Self-Consistency

#block(
  fill: rgb("#c5e0d880"), 
  width: 100%,
  inset: 1em,
  radius: 8pt,
  stroke: (paint: rgb("#9aafa9"), thickness: 1pt),
  [
    #text(weight: "bold")[Self-Consistency] is a technique that involves asking the model to generate multiple outputs and ensure they are consistent with each other.
  ]
)

#grid(
  columns: 2,
  gutter: 1em,
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 80%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Key Concepts]
        
        - Generates multiple independent solutions to a problem
        - Cross-checks these outputs for logical consistency
        - Reduces contradictions and reasoning errors
        - Valuable for complex reasoning and math problems
        - Improves reliability through logical coherence
        - Often implemented via majority voting among solutions
      ]
    )
  ],
  [
    #block(
      fill: rgb("#e6e6e6"),
      width: 100%,
      height: 80%,
      inset: 1em,
      radius: 8pt,
      stroke: (paint: rgb("#c7c5c5"), thickness: 1pt),
      [
        #text(weight: "bold")[Example]
      
        #text(weight: "bold")[Intent:] Reasoning with multiple paths
        
        #text(weight: "bold")[Prompt:] 
        ```
        Q: Today I have 6 apples. Tomorrow I buy 3 more.
        How many apples do I have?
        A: 9
        Q: Today I have 6 apples. Yesterday I ate 6 apples, How many apples
        do I have?
        A: 6
        Q: Today I have 6 apples. Tomorrow I buy 3 more. Yesterday I ate 6
        apples, How many apples do I have?
        ```
        #text(weight: "bold")[Output:] 
        ```
        Answers: 6, 6, 9 => 6
        ```
      ]
    )
  ]
)

== Prompt Engineering -- Advanced Techniques

- #text(weight: "bold")[Retrivial Augmented Generation (RAG):] Allow to enrich the prompt with additional information from a knowledge base.
  - Used to provide context or constraints for the model's output.
  - It reduces `hallucination` and improves the quality of the generated text.
- #text(weight: "bold")[ReAct]: To generate both reasoning traces and task-specific actions in an interleaved manner. 
  - It is used to improve the reasoning capabilities of the model.
  - It is particularly effective for math, logic, and multi-step problems.
    - It use function calls to guide the model in the reasoning process.

- Some of these techniques are implemented in the LangChain framework.
- We will see more about these techniques in the next sessions #fa-smile()

== Conclusion
- LLMs are #text(weight: "bold")[revolutionizing] the field of NLP and AI #fa-rocket()
- This has also a significant #text(weight: "bold")[impact on Software Engineering] #fa-code()
- Today: we have seen the #text(weight: "bold")[basics of LLMs] and how to interact with them #fa-check-circle()
  - We have seen the importance of #text(weight: "bold")[prompt engineering] #fa-magic()
  - We have seen how to #text(weight: "bold")[interact with them] through APIs #fa-plug()
- Next Lesson: #fa-forward()
  - Focus on the #text(weight: "bold")[use of LLMs in Software Engineering] #fa-tools()
  - Divide by specific #text(weight: "bold")[tasks and applications] #fa-tasks()
- *Lab*:
  - #text(weight: "bold")[Hands-on] with LLMs #fa-keyboard()
  - Use of #text(weight: "bold")[LangChain and Ollama]
  - #text(weight: "bold")[Prompt Engineering] practice
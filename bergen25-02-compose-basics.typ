#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.5.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly

#let fancy-code = (content) => {
  block(
    inset: (x: 16pt, y: 12pt),
    fill: rgb("#f0f0f0"),
    stroke: (paint: rgb("#d0d0d0"), thickness: 1pt),
    radius: 8pt,
    shadow: (color: rgb(0, 0, 0).with(alpha: 0.2), offset: (x: 2pt, y: 2pt), blur: 4pt),
    [
      #text(content, font: "Fira Code", size: 14pt, color: rgb("#657b83"))
    ]
  )
}

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
  aspect-ratio: "16-9",
  footer: self => self.info.author + ", " + self.info.institution + " - " + self.info.date,
  config-common(
    // handout: true,
    preamble: pdfpc-config, 
  ),
  config-info(
    title: [Jetpack Compose],
    subtitle: [An UI framework to rule them all],
    author: [Gianluca Aguzzi],
    date: datetime.today().display("[day] [month repr:long] [year]"),
    institution: [Università di Bologna],
    // logo: emoji.school,
  ),
)


#let styled-block(
  title, 
  content, 
  icon: "", 
  fill-color: rgb("#23373b").lighten(90%),
  stroke-color: rgb("#23373b").lighten(50%),
  title-color: rgb("#000000"),
  title-size: 20pt
) = {
  block(
    width: 100%,
    inset: (x: 24pt, y: 18pt),
    fill: fill-color,
    radius: 8pt,
    stroke: (
      paint: stroke-color, 
      thickness: 1pt,
      dash: "solid"
    ),
    [
      #text(weight: "bold", size: title-size, fill: title-color)[#icon #title]
      #v(-12pt)
      #line(length: 100%, stroke: (paint: stroke-color, thickness: 1.5pt))
      #v(-10pt)
      #content
    ]
  )
}

#let compact-styled-block(
  content, 
  icon: "", 
  fill-color: rgb("#23373b").lighten(90%),
  stroke-color: rgb("#23373b").lighten(50%)
) = {
  block(
    width: 100%,
    inset: (x: 24pt, y: 18pt),
    fill: fill-color,
    radius: 8pt,
    stroke: (
      paint: stroke-color, 
      thickness: 1pt,
      dash: "solid"
    ),
    [
      #text(weight: "bold", size: 20pt, fill: rgb("#000000"))[#icon] #h(0.4em) #content
    ]
  )
}
// Now define specialized blocks using the base block
#let feature-block(title, content, icon: "") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#23373b").lighten(90%),
    stroke-color: rgb("#23373b").lighten(50%),
    title-size: 22pt
  )
}

#let note-block(title, content, icon: fa-info-circle() + " ") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#fffde7"),
    stroke-color: rgb("#ffecb3"),
  )
}

#let warning-block(title, content, icon: fa-exclamation-triangle() + " ") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#fff3e0"),
    stroke-color: rgb("#ffcc80"),
    title-color: rgb("#e65100"),
  )
}

// Now define compact versions of the specialized blocks
#let compact-feature-block(content, icon: "") = {
  compact-styled-block(
    content, 
    icon: icon,
    fill-color: rgb("#23373b").lighten(90%),
    stroke-color: rgb("#23373b").lighten(50%)
  )
}

#let compact-note-block(content, icon: fa-info-circle() + " ") = {
  compact-styled-block(
    content, 
    icon: icon,
    fill-color: rgb("#fffde7"),
    stroke-color: rgb("#ffecb3")
  )
}

#let compact-warning-block(content, icon: fa-exclamation-triangle() + " ") = {
  compact-styled-block(
    content, 
    icon: icon,
    fill-color: rgb("#fff3e0"),
    stroke-color: rgb("#ffcc80")
  )
}

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")

#title-slide()

== Today's Lesson: Compose Basics

- *Learning Objectives:*
  - Understand the basics of Compose and its architecture #fa-cogs()
    - Introduce the concept of `Composable` functions #fa-code()
    - Explain the Compose runtime and its phases #fa-cogs()

  - Explore the Compose UI toolkit and its components #fa-th-large()
  - *Focus* jetpack Compose (Android), therefore we just mention the other platforms
- *Resources*
  - This presentation is based on the official #link("https://developer.android.com/jetpack/compose/documentation")[Compose documentation]
  - _Official resources_:
    #text(size: 16pt)[
      #link("https://developer.android.com/develop")[Android portal] • 
      #link("https://developer.android.com/develop/ui/compose/kotlin")[Compose with Kotlin] • 
      #link("https://developer.android.com/develop/ui/compose/testing")[Testing] • 
      #link("https://developer.android.com/codelabs/jetpack-compose-basics")[Compose codelab] • 
      #link("https://developer.android.com/develop/ui/compose/mental-model")[Mental model] • 
      #link("https://kmp.jetbrains.com/#newProject")[KMP starter] • 
      #link("https://www.jetbrains.com/lp/compose-multiplatform/")[Compose Multiplatform]
    ]
= Introduction
#focus-slide()[
  #text(style: "italic")[Construct UIs by descring *what*, not *how*]
  #align(center)[
    #image("figures/compose-logo.png", width: 30%)
  ]
  #text(weight: "bold")[Jetpack Compose]
]
== What is Compose?

#grid(
  columns: (auto, auto),
  gutter: 1em,
  [
    - A modern *toolkit* for building *native* Android UI
    - Simplifies and accelerates UI development with:
      - Less code
      - Powerful tools
      - Intuitive Kotlin DSL
    - Originally for Android (Jetpack Compose), now multi-platform!!
      - Desktop, Web, iOS, and more
    - It is data driven, reactive, and declarative
    
  ],
  align(center)[
    #image("figures/compose-logo.png", width: 40%)
  ]
)

== Why Compose?

#align(center)[
  #image("figures/state-driven-UI.png", width: 50%)
]

- Focus on *what* the UI should be, not *how* to build it
- Declarative UI approach
- No XML layouts needed
- UI as pure functions of data
- Simple state management
- Intuitive component reuse

== The Power of Compose

// Two vertically stacked boxes
#feature-block("Three core pillars:", [
  - #text(weight: "medium")[Declarative programming model] #fa-arrow-right() #h(0.4em) #text(style: "italic")[thanks to Kotlin DSL]
  - #text(weight: "medium")[Reactive state management] #fa-arrow-right() #h(0.4em) #text(style: "italic")[automatic UI updates]
  - #text(weight: "medium")[Composition-based architecture] #fa-arrow-right() #h(0.4em) #text(style: "italic")[build complex UIs from simple ones]
], icon: fa-layer-group() + " ")

#v(4pt)

#feature-block("Advantages:", [
  - #text(weight: "medium")[Faster development] with `@Preview` #fa-arrow-right() #h(0.4em) #text(style: "italic")[see changes instantly]
  - #text(weight: "medium")[Better type safety] #fa-arrow-right() #h(0.4em) #text(style: "italic")[compile-time checks]
  - #text(weight: "medium")[Simplified animation] #fa-arrow-right() #h(0.4em) #text(style: "italic")[built-in support]
  - #text(weight: "medium")[Material Design] support out of the box
  - #text(weight: "medium")[Easier testing] and debugging #fa-arrow-right() #h(0.4em) #text(style: "italic")[test UI components in isolation]
], icon: fa-rocket() + " ")


== Compose vs Traditional Views

#align(center)[
  #table(
    columns: (auto, auto),
    inset: 12pt,
    align: center,
    stroke: 1pt,
    fill: (_, row) => if row == 0 { rgb("#23373b").lighten(90%) } 
               else if calc.odd(row) { rgb("#f5f5f5") } 
               else { white },
    [#text(weight: "bold")[Traditional Views]], [#image("figures/compose-logo.png", width: 30pt)],
    [Imperative approach], [Declarative approach],
    [XML layouts + Java/Kotlin code], [Pure Kotlin code],
    [Explicit view mutations], [Immutable UI descriptions],
    [findViewById() operations], [Direct function calls],
    [Manual state synchronization], [Automatic UI updates from state],
    [Complex view hierarchies], [Composition-based structure]
  )
]

== Technical Requirements

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  text(size: 16pt)[
    #text(weight: "bold")[Development Environment]
    - Android Studio: Giraffe (2022.3.1) or later
    - Gradle: 8.0+
    - Kotlin: 1.8.0+
    
    #text(weight: "bold")[API Levels]
    - Minimum SDK: API 21 (Lollipop)
    - Recommended: API 23+ for better performance
    - Target SDK: API 34+ (Android 14)
  ],
  text(size: 16pt)[
    #text(weight: "bold")[Additional Requirements]
    - Java 17 or later
    - Supports Gradle with Kotlin DSL
    - Works on physical devices and emulators (API 21+)
  ]
)
#text(weight: "bold", size: 16pt)[Dependencies]
#text(size: 14pt)[
```kotlin
dependencies {
    implementation("androidx.compose.ui:ui:1.6.0")
    implementation("androidx.compose.material3:material3:1.2.0")
    implementation("androidx.compose.ui:ui-tooling-preview:1.6.0")
}
```]

*Code Repository*: https://github.com/cric96/bergen25-02-compose-code
= Compose Core Concepts

#focus-slide[
  #text(size: 30pt)[All you need are *Composable Functions* #fa-exclamation()]
  #v(0.4em)
    #text(size: 25pt)[Focus on the UI (*what the user sees*) not on How to do it (*how to build the UI*)]

]
== Composable Functions

#grid(
  columns: (1fr),
  [
    - *Building blocks* of UI in Jetpack Compose
    - Annotated with `@Composable` annotation
    - Tells the compiler this function creates UI elements
    - Example:
      ```kotlin
      @Composable
      fun Greeting(name: String) {
          Text("Hello $name!")
      }
      ```
    - Composable functions can call other composable functions
    - They transform data into UI elements
  ]
)

== Composable Functions
#note-block("Name styling")[
  Composable function names should:
  - Start with a capital letter
  - Use PascalCase (camel case with initial capital)
  - Describe what the component is, not what it does
  - Be nouns or noun phrases, not verbs
  
  Good examples: `Greeting`, `GreetingCard`, `UserProfile`, `MessageList`, `NavigationBar`

  Avoid: `renderGreeting` ❌, `showUserInfo` ❌
]

== Composable Functions -- How to compose?

- Build UI by calling other composable functions #fa-puzzle-piece()
- Compose nested hierarchies for complex layouts #fa-layer-group()
- Pass composable functions as parameters (higher-order functions) #fa-code-branch()


#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    *Traditional View Approach*
    
    #text(size: 8pt)[
    ```xml
    <!-- greeting_card.xml -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical">
        
        <TextView
            android:id="@+id/title"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Greeting Card" />
            
        <TextView
            android:id="@+id/greeting"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content" />
    </LinearLayout>
    ```
    
    ```kotlin
    // In Activity or Fragment
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.greeting_card)
        
        findViewById<TextView>(R.id.greeting).text = "Hello $name!"
    }
    ```
    ]
  ],
  [
    *Compose Approach*
    
    #text(size: 18pt)[
    ```kotlin
    @Composable
    fun Greeting(name: String) {
        Text("Hello $name!")
    }
    @Composable
    fun GreetingCard(name: String) {
        Column {
            Text("Greeting Card")
            Greeting(name)
        }
    }
    ```
    ]
  ]
)

== Composable Functions -- Side-effects frequently
- Composable functions should ideally be *pure* (no side-effects)
- We will see later how to handle side-effects (e.g., state management)
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #text(size: 16pt)[
    ```kotlin
    @Composable
    fun SideEffectCounter() {
      var counter = 0 // NO!! This breaks purity
      Button(onClick = { counter++ }) {
        Text("Counter: $counter")
      }
    }
    ```
    ]
  ],
  [
    #text(size: 16pt)[
    ```kotlin
    @Composable
    fun PureCpunter(value: Int) {
      // Pure composable: no side effects whatsoever
      Text(text = "Hello, $value!")
    }
    ```
    ]
  ]
)
#warning-block(
  "Key Term",
  "An effect is a composable function that doesn't emit UI and causes side effects to run when a composition completes."
)


== Why Composition Matters

#grid(
  columns: (1fr),
  [
    - Composition allows building complex UIs from smaller, self-contained functions
    - Benefits:
      - *Reusability*: Build components once, use them everywhere
      - *Maintainability*: Easy to understand and modify isolated components
      - *Scalability*: Complex UIs emerge from simple building blocks
      - *Testability*: Test components in isolation
    - Functional programming approach applied to UI development
    - Clean separation of concerns through component boundaries
  ]
)


#focus-slide[
  #text(size: 30pt, weight: "bold")[Composable Functions Can Run in Any Order]
  #v(1em)
  #text(style: "italic", size: 20pt)[Don't rely on execution order between independent composables]
]

== Composable Functions -- Evaluation Order
```kotlin
@Composable
fun OrderExample() {
  Column {
    Text("Composable functions might run in any order!")
    // These independent composables could run in any order
    FirstComponent()
    SecondComponent()
    ThirdComponent()  
    Text(message)
  }
}
```

#focus-slide[
  #text(size: 30pt, weight: "bold")[Composable Functions Can Run in Parallel]
  #v(1em)
  #text(style: "italic", size: 20pt)[Compose can optimize UI building by executing composables concurrently]
]

== Composable Functions -- Parallel Execution
```kotlin
@Composable
fun ParallelExample() {
  // These independent composables could run in parallel
  Box() {
    // These might run concurrently for performance optimization
    UserProfile()
    MessageList()
    NotificationBadge()
  }
  
  // Don't assume sequential execution!
  var sharedCounter = 0  // BAD: Shared mutable variable
  
  // Each might increment at the same time, leading to race conditions
  ComponentOne { sharedCounter++ }  // BAD
  ComponentTwo { sharedCounter++ }  // BAD
}
```

== Composable Function: Side

#focus-slide()[
  == Compose Main Steps
  #align(center)[
    #box(fill: rgb("#eef8ff"), radius: 6pt, inset: 10pt)[
      #text(size: 20pt, fill: rgb("#0055aa"), weight: "medium")[Data]
    ]
    #h(2pt) #text(fill: white, size: 40pt)[#fa-long-arrow-right()] #h(15pt)
    #box(fill: rgb("#e6f3e6"), radius: 6pt, inset: 10pt)[
      #text(size: 20pt, fill: rgb("#005500"), weight: "medium")[Composition]
    ]
    #h(2pt) #text(fill: white, size: 40pt)[#fa-long-arrow-right()] #h(15pt)
    #box(fill: rgb("#fff0e6"), radius: 6pt, inset: 10pt)[
      #text(size: 20pt, fill: rgb("#883300"), weight: "medium")[Layout]
    ]
    #h(2pt) #text(fill: white, size: 40pt)[#fa-long-arrow-right()] #h(15pt)
    #box(fill: rgb("#f0e6f5"), radius: 6pt, inset: 10pt)[
      #text(size: 20pt, fill: rgb("#660066"), weight: "medium")[Draw]
    ]
    #h(2pt) #text(fill: white, size: 40pt)[#fa-long-arrow-right()] #h(15pt)
    #box(stroke: 4pt, fill: rgb("#fff8e1"), radius: 6pt, inset: 10pt)[
      #text(size: 20pt, fill: rgb("#886600"), weight: "medium")[Display]
    ]
  ]
]

== Composition Phase
- In the composition phase, the Compose runtime executes composable functions.
- It produces a UI tree of layout nodes.
- The tree contains all necessary information for the subsequent phases.

#align(center)[
  #image("figures/composition.png", width: 60%)
]

== Layout Phase
#compact-note-block[
  Compose computes the size and position of each layout node during the layout phase.
]

#align(center)[
  #image("figures/layout.png", width: 60%)
]

- During the layout phase, the composition tree is processed using a three-step algorithm:
  - #text(weight: "bold")[Measure Children]: The parent node measures its children, if any exist.
  - #text(weight: "bold")[Decide Own Size]: Based on the children's measurements, the node determines its own size.
  - #text(weight: "bold")[Place Children]: Each child node is positioned relative to its parent node.

#compact-warning-block[
  At the end of the layout phase, each node has:
  - A defined width and height.
  - A specific position within its parent layout (x, y coordinates).
]

== Draw Phase
  #text(
    weight: "bold",
  )[ UI tree rendered top-to-bottom, ensuring proper order.
  ]
  #v(10pt)
  #align(center)[
    #image("figures/drawing.png", width: 60%)
  ]
  Ok, but this seems to be an immutable process, what about the *state*?
  - When it comes to state, Compose has a special mechanism: *Recomposition*.
== State -- Memory in a Composable functions

#grid(
  columns: (2fr, 1fr),
  gutter: 12pt,
  [
    #feature-block("Compose State Management:", [
      - Composable functions transform data into UI
      - The *Composition* is the UI tree built when composables execute
      - When state changes, Compose performs *recomposition*:
        - Only re-executes affected composables 
        - Efficiently updates just the parts of UI that need to change
        - Creates a responsive, performance-optimized UI
      - BTW what is a *State*?
    ], icon: fa-sync() + " ")
  ],
  [
    #align(center)[
      #image("figures/unidirect.png", width: 80%)
    ]
  ]
)

#focus-slide[
  State *is*, Events _happens_
  #align(center)[
    #image("figures/evolution-loop.png", width: 60%)
  ]
]

== Event vs State
- Event - An event is generated by the user or another part of the program.
  ```kotlin
  Button(onClick = { /* Event: Button clicked */ }) {
      Text("Click me")
  }
  ```
- Update State - An event handler changes the state that is used by the UI.
  ```kotlin
  var counter by remember { mutableStateOf(0) }
  Button(onClick = { counter++ }) {
      Text("Counter: $counter")
  }
  ```
- Display State - The UI is updated to display the new state.
  ```kotlin
  @Composable
  fun CounterDisplay(counter: Int) {
      Text("Counter: $counter")
  }
  ```

== MutableState\<T>
#compact-feature-block[ Compose tracks state changes and schedules recompositions for affected composables.
  - Use `remember` to store objects in memory during composition.
  - `remember` retains values across recompositions.
  - `mutableStateOf` creates an observable state integrated with the compose runtime.
]

#compact-note-block[ Any changes to value schedules recomposition of any composable functions that read value.
  ```kotlin
  interface MutableState<T> : State<T> { override var value:  }
  ```
]

#compact-feature-block[
  There are three ways to declare a MutableState object in a composable:
  ```kotlin
  val mutableState = remember { mutableStateOf(default) }
  var value by remember { mutableStateOf(default) }
  val (value, setValue) = remember { mutableStateOf(default) }
  ```
  These declarations are equivalent, and are provided as syntax sugar for different uses of state.
]
#compact-note-block[
   `remember` stores objects in the Composition, and forgets the object when the composable that called `remember` is removed from the Composition (e.g., when the screen is closed).
]

== Save UI state
#note-block("Save UI State", [
  - #text(weight: "medium")[rememberSaveable] persists UI state through config changes
  - Important to save: user input, navigation state, in-progress interactions
  
 
], icon: fa-save() + " ")
 #compact-warning-block[
    Without proper state saving, configuration changes (rotation) 
    or system-initiated process death will reset your UI!
  ]
  
  #compact-note-block[ Using rememberSaveable instead of remember
    ```kotlin
    var name by rememberSaveable { mutableStateOf("") }
    ```
  ]
== Recomposition
#compact-note-block[
  Recomposition is the process of calling composable functions again when *inputs change*
]
#align(center)[
  #image("figures/recomposition-happen.png", width: 60%)
]
#grid(
  columns: (1fr),
  gutter: 0pt,
  [
    #text(size: 14pt)[
    ```kotlin
    @Composable fun LoginScreen(showError: Boolean) {
      if (showError) {
          LoginError()
      }
      LoginInput()
    }
    @Composable fun LoginInput() { /* ... */ }
    @Composable fun LoginError() { /* ... */ }
    ```
    ]
  ]
)


== 
#focus-slide[
  == Recomposition is Optimistic
  #v(1em)
  #text(size: 22pt)[Compose skips composables that don't need to be updated]
]

== Optimistic Recomposition
- Compose is smart and only recomposes composables that need to be updated.
- It skips those that are not affected by the state change.
- This makes the UI responsive and efficient.

#align(center)[
  #image("figures/optmistic.png", width: 80%)
]

== State Hoisting in Compose

#focus-slide[
  #text(size: 30pt, weight: "bold")[State Hoisting]
  #v(1em)
  #text(style: "italic", size: 20pt)[The secret to reusable and testable Compose UIs]
]

== What is State Hoisting?

#feature-block("State Hoisting Definition:", [
  - A design pattern where state is moved *up* to the caller
  - Makes composables *stateless* by extracting internal state
  - Creates a *single source of truth* for application state
], icon: fa-arrow-up() + " ")

#note-block("Key Pattern", [
  Replace internal state variables with two parameters:
  #text(size: 13pt)[
  ```kotlin
  // Instead of internal state:
  @Composable fun StetefulComponent() { var text by remember { mutableStateOf("") } }
  // Use this pattern:
  @Composable fun StatelessComponent(
      value: T,                  // ← State flows down
      onValueChange: (T) -> Unit // ← Events flow up
  )
  ```
  ]
])

== Why Hoist State?

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #feature-block("Benefits:", [
      - *Single source of truth*:
        #text(style: "italic", size: 16pt)[Avoid duplicated state and bugs]
      - *Shareable state*: 
        #text(style: "italic", size: 16pt)[Makes state available to multiple components]
      - *Interceptable events*:
        #text(style: "italic", size: 16pt)[Process events before updating state]
      - *Decoupled components*: 
        #text(style: "italic", size: 16pt)[State can be stored anywhere]
    ], icon: fa-check-circle() + " ")
  ],
  [
    #align(center)[
      #image("figures/state-hoisting-lca.png", width: 90%)
      #text(style: "italic", size: 16pt)[Host state at the lowest common ancestor]
    ]
  ]
)

== Where to Hoist State?

#feature-block("Three Rules for State Hoisting:", [
  1. Hoist state to at least the *lowest common parent* of all composables that read it
  2. Hoist state to at least the *highest level* it may be changed (written)
  3. If two states change in response to the *same events*, they should be hoisted to the *same level*
], icon: fa-360-degrees() + " ")

#compact-warning-block[
  Not hoisting state high enough makes it difficult to follow unidirectional data flow.
]

== Stateful vs. Stateless Composables

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #feature-block("Stateful Composable", [
      - *Owns* and manages its own state
      - Less *reusable* across different contexts
      - Harder to *test* in isolation
      - Makes sense for *simple* UI elements
      
      #text(size: 13pt)[
      ```kotlin
      @Composable
      fun StatefulCounter() {
        var count by remember { 
          mutableStateOf(0) 
        }
        Button(onClick = { count++ }) {
          Text("Count: $count")
        }
      }
      ```
      ]
    ], icon: fa-box() + " ")
  ],
  [
    #feature-block("Stateless Composable", [
      - Receives state as *parameters*
      - More *reusable* across different contexts
      - Easier to *test* in isolation
      - Preferred for *complex* components

      #text(size: 16pt)[
      ```kotlin
      @Composable
      fun StatelessCounter(
        count: Int,
        onIncrement: () -> Unit
      ) {
        Button(onClick = onIncrement) {
          Text("Count: $count")
        }
      }
      ```
      ]
    ], icon: fa-box-open() + " ")
  ]
)

== Practical Example: Chat Bubble

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #feature-block("Without Hoisting (OK for simple cases)", [
      #text(size: 13pt)[
      ```kotlin
      @Composable
      fun ChatBubble(message: Message) {
        // Internal state - not hoisted
        var showDetails by rememberSaveable { 
          mutableStateOf(false) 
        }
        ClickableText(
          text = AnnotatedString(message.content),
          onClick = { 
            showDetails = !showDetails 
          }
        )
        if (showDetails) { Text(message.timestamp) }
      }
      ```
      ]
    ], icon: fa-comment() + " ")
  ],
  [
    #note-block("When to keep state internal:", [
      - When state is *simple*
      - When state is only *used locally*
      - When state doesn't need to be *shared*
      - When state is purely *UI-related*
      - Common examples:
        - Animation states
        - Toggle/expansion states
        - Local input validation
    ])
  ]
)

== State Hoisting Best Practices

#feature-block("Do's and Don'ts", [
  #grid(
    columns: (1fr, 1fr),
    gutter: 12pt,
    [
      #text(weight: "bold", fill: rgb("#4caf50"))[Do #fa-check()]
      - Hoist state to the lowest common parent
      - Use default parameter values for flexibility
      - Pass only what's needed to each composable
      - Keep UI logic and UI state together
      - Separate business logic from UI logic
    ],
    [
      #text(weight: "bold", fill: rgb("#f44336"))[Don't #fa-times()]
      - Hoist state unnecessarily (when it's purely local)
      - Pass ViewModels down the component tree
      - Create "god objects" that hold all state
      - Mix business logic with UI components
      - Create deeply nested state objects
    ]
  )
], icon: fa-clipboard-check() + " ")


== Event Handling in Compose
  #feature-block("Event Representation:", [
    - Every input to your app should be represented as an *event*: _Taps_, _Text changes_, _Timers_ or other _updates_
  ], icon: fa-bolt() + " ")
  
  
  #note-block("Best Practices:", [
    - Prefer passing *immutable values* for state and event handler *lambdas*
    - Benefits:
      - Improved reusability
      - Ensures UI doesn't change state directly
      - Avoids concurrency issues
      - Reduces code complexity
  ], icon: fa-check-circle() + " ")
  
  #feature-block("Example")[
    ```kotlin
    @Composable
    fun MyAppTopAppBar(text: String, onBackClick: () -> Unit) {
        TopAppBar(
            title = { Text(text) },
            navigationIcon = {
                IconButton(onClick = onBackClick) {
                    Icon(Icons.Filled.ArrowBack, contentDescription = null)
                }
            }
        )
    }
    ```
  ]


= Compose Hands On -- Let's Code!


== Modifiers
Type Safety

= Advanced Compose

= Canvas Drawing

== Animation

== Debugging

== Testing

== Multi-Platform Compose
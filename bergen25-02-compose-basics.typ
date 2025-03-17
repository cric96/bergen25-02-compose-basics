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
    ```kotlin
    dependencies {
        implementation("androidx.compose.ui:ui:1.6.0")
        implementation("androidx.compose.material3:material3:1.2.0")
        implementation("androidx.compose.ui:ui-tooling-preview:1.6.0")
    }
    ```

= Compose Core Concepts

#focus-slide[
  #text(size: 30pt)[All you need are *Composable Functions*!!]
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
#note-block("Layout Phase")[
  Compose computes the size and position of each layout node during the layout phase.
]

#align(center)[
  #image("figures/layout.png", width: 60%)
]

- During the layout phase, the composition tree is processed using a three-step algorithm:
  - #text(weight: "bold")[Measure Children]: The parent node measures its children, if any exist.
  - #text(weight: "bold")[Decide Own Size]: Based on the children's measurements, the node determines its own size.
  - #text(weight: "bold")[Place Children]: Each child node is positioned relative to its parent node.

#warning-block("Attention")[
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

== Recomposition

- Recomposition is the process of calling composable functions again when *inputs change*
#grid(
  columns: (1fr),
  gutter: 0pt,
  [
    ```kotlin
@Composable
fun LoginScreen(showError: Boolean) {
  if (showError) {
      LoginError()
  }
  LoginInput()
}
@Composable fun LoginInput() { /* ... */ }
@Composable fun LoginError() { /* ... */ }```
  ]
)
#align(center)[
  #image("figures/recomposition-happen.png", width: 60%)
]

== 
#focus-slide[
  == Recomposition is Optimistic
  #v(1em)
  #text(size: 22pt)[Compose skips composables that don't need to be updated]
]

== State -- Memory in a Composable functions

#feature-block("Compose State Management:", [
  - Composable functions transform data into UI
  - The *Composition* is the UI tree built when composables execute
  - When state changes, Compose performs *recomposition*:
    - Only re-executes affected composables 
    - Efficiently updates just the parts of UI that need to change
    - Creates a responsive, performance-optimized UI
  - BTW what is a *State*?
], icon: fa-sync() + " ")

#focus-slide[
  State *is*, Events _happens_
  #align(center)[
    #image("figures/evolution-loop.png", width: 60%)
  ]
]
/**
== Event vs State
- Event - An event is generated by the user or another part of the program.
- Update State - An event handler changes the state that is used by the UI.
- Display State - The UI is updated to display the new state.

== Recomposition

== State -- Memory in a Composable functions
Compose apps transform data into UI by calling composable functions. We refer to the Composition as the description of the UI built by Compose when it executes composables. If a state change happens, Compose re-executes the affected composable functions with the new state, creating an updated UI—this is called recomposition. Compose also looks at what data an individual composable needs, so that it only recomposes components whose data has changed and skips those that are not affected.

The Composition: a description of the UI built by Jetpack Compose when it executes composables.

Initial composition: creation of a Composition by running composables the first time.

Recomposition: re-running composables to update the Composition when data changes.

== State -- MutableState
Compose has a special state tracking system in place that schedules recompositions for any composables that read a particular state. This lets Compose be granular and just recompose those composable functions that need to change, not the whole UI. This is done by tracking not only "writes" (that is, state changes), but also "reads" to the state.

Use Compose's State and MutableState types to make state observable by Compose.

Compose keeps track of each composable that reads State value properties and triggers a recomposition when its value changes. You can use the mutableStateOf function to create an observable MutableState. It receives an initial value as a parameter that is wrapped in a State object, which then makes its value observable.

Warning: You might get a compilation warning by Android Studio: Creating a state object during composition without using remember. This is a valid warning that will be explained and fixed shortly. You can ignore it for now.

You can think of using remember as a mechanism to store a single object in the Composition, in the same way a private val property does in an object.

Note: You might already be using other observable types like LiveData, StateFlow, Flow, and RxJava's Observable to store state in an app. To allow Compose to use this state and automatically recompose when the state changes you need to map them to a State<T>.

#focus-slide[
  == State-Driven UI
  #align(center)[
    #image("figures/state-driven-UI.png", width: 60%)
  ]
]

== State-Driven UI
This approach avoids the complexity of manually updating views as you would with the View system. It's also less error-prone, as you can't forget to update a view based on a new state, because it happens automatically.

If a composable function is called during the initial composition or in recompositions, we say it is present in the Composition. A composable function that is not called—for example, because the function is called inside an if statement and the condition is not met—-is absent from the Composition.

You can learn more about the lifecycle of composables in the documentation.

Key idea: If the UI is what the user sees, the UI state is what the app says they should see. Like two sides of the same coin, the UI is the visual representation of the UI state. Any changes to the UI state are immediately reflected in the UI.

== Restore State -- SavableRemember
Run the app, add some glasses of water to the counter, and then rotate your device. Make sure you have the device's Auto-rotate setting on.

Because Activity is recreated after a configuration change (in this case, orientation), the state that was saved is forgotten: the counter disappears as it goes back to 0.

The same happens if you change language, switch between dark and light mode, or any other configuration change that makes Android recreate the running Activity.

While remember helps you retain state across recompositions, it's not retained across configuration changes. For this, you must use rememberSaveable instead of remember.

rememberSaveable automatically saves any value that can be saved in a Bundle. For other values, you can pass in a custom saver object. For more information on Restoring state in Compose, check out the documentation.

In WaterCounter, replace remember with rememberSaveable:

== State Hoisting

A composable that uses remember to store an object contains internal state, which makes the composable stateful. This is useful in situations where a caller doesn't need to control the state and can use it without having to manage the state themselves. However, composables with internal state tend to be less reusable and harder to test.

Composables that don't hold any state are called stateless composables. An easy way to create a stateless composable is by using state hoisting.

State hoisting in Compose is a pattern of moving state to a composable's caller to make a composable stateless. The general pattern for state hoisting in Jetpack Compose is to replace the state variable with two parameters:

value: T - the current value to display
onValueChange: (T) -> Unit - an event that requests the value to change with a new value T
where this value represents any state that could be modified.

The pattern where the state goes down, and events go up is called Unidirectional Data Flow (UDF), and state hoisting is how we implement this architecture in Compose. You can learn more about this in the Compose Architecture documentation.

== State Hoisting
State that is hoisted this way has some important properties:

Single source of truth: By moving state instead of duplicating it, we're ensuring there's only one source of truth. This helps avoid bugs.
Shareable: Hoisted state can be shared with multiple composables.
Interceptable: Callers to the stateless composables can decide to ignore or modify events before changing the state.
Decoupled: The state for a stateless composable function can be stored anywhere. For example, in a ViewModel.

== Stefull vs Stateless
When all state can be extracted from a composable function the resulting composable function is called stateless.

A stateless composable is a composable that doesn't own any state, meaning it doesn't hold or define or modify new state.

A stateful composable is a composable that owns a piece of state that can change over time.

In real apps, having a 100% stateless composable can be difficult to achieve depending on the composable's responsibilities. You should design your composables in a way that they will own as little state as possible and allow the state to be hoisted, when it makes sense, by exposing it in the composable's API.

== Hoisting -- Key Points

Key Point: When hoisting state, there are three rules to help you figure out where state should go:

State should be hoisted to at least the lowest common parent of all composables that use the state (read).
State should be hoisted to at least the highest level it may be changed (write).
If two states change in response to the same events they should be hoisted to the same level.
You can hoist the state higher than these rules require, but if you don't hoist the state high enough, it might be difficult or impossible to follow unidirectional data flow.

Key Point: A best practice for the design of Composables is to pass them only the parameters they need.

== State in ViewModel
The screen, or UI state, indicates what should display on the screen (for example, the list of tasks). This state is usually connected with other layers of the hierarchy because it contains application data.

While the UI state describes what to show on the screen, the logic of an app describes how the app behaves and should react to state changes. There are two types of logic: the UI behavior or UI logic, and the business logic.

The UI logic relates to how to display state changes on the screen (for example, the navigation logic or showing snackbars).
The business logic is what to do with state changes (for example making a payment or storing user preferences). This logic is usually placed in the business or data layers, never in the UI layer.
ViewModels provide the UI state and access to the business logic located in other layers of the app. Additionally, ViewModels survive configuration changes, so they have a longer lifetime than the Composition. They can follow the lifecycle of the host of Compose content—that is, activities, fragments, or the destination of a Navigation graph if you're using Compose Navigation.


== Layouts
Composable Functional => What to show

Layouts => How to arrange the UI

Composable functions are the basic building block of Compose. A composable function is a function emitting Unit that describes some part of your UI. The function takes some input and generates what's shown on the screen. For more information about composables, take a look at the Compose mental model documentation.

A composable function might emit several UI elements. However, if you don't provide guidance on how they should be arranged, Compose might arrange the elements in a way you don't like. For example, this code generates two text elements:



In the layout model, the UI tree is laid out in a single pass. Each node is first asked to measure itself, then measure any children recursively, passing size constraints down the tree to children. Then, leaf nodes are sized and placed, with the resolved sizes and placement instructions passed back up the tree.

Briefly, parents measure before their children, but are sized and placed after their children

== Modifiers
Type Safety

= Advanced Compose

= Canvas Drawing

== Animation

== Debugging

== Testing

== Multi-Platform Compose
**/

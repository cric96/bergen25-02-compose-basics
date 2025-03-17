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
  aspect-ratio: "16-9",
  footer: self => self.info.author + ", " + self.info.institution + " - " + self.info.date,
  config-common(
    // handout: true,
    preamble: pdfpc-config, 
  ),
  config-info(
    title: [Compose Multi-Platform],
    subtitle: [An UI framework to rule them all],
    author: [Gianluca Aguzzi],
    date: datetime.today().display("[day] [month repr:long] [year]"),
    institution: [Università di Bologna],
    // logo: emoji.school,
  ),
)

#let feature-block(title, content, icon: "") = {
  block(
    width: 100%,
    inset: (x: 24pt, y: 18pt),
    fill: gradient.linear(
      rgb("#23373b").lighten(80%),
      rgb("#23373b").lighten(90%),
      angle: 45deg
    ),
    radius: 8pt,
    stroke: (
      paint: rgb("#23373b").lighten(50%), 
      thickness: 1pt,
      dash: "solid"
    ),
    [
      #text(weight: "bold", size: 22pt)[#icon #title]
      #v(2pt)
      #content
    ]
  )
}

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")

#title-slide()

== Today's Lesson: Compose Basics

- *Learning Objectives:*
  - Understand the basics of Compose and its architecture #fa-cogs()
    - Introduce the concept of `Composable` functions #fa-code()
    - Explain the role of `State` and `Events` #fa-bell()

  - Explore the Compose UI toolkit and its components #fa-th-large()
  - Learn about the Compose runtime and its features #fa-cogs()
  - *Focus* jetpack Compose (Android), therefore we just mention the other platforms
- *Resources*
  - This presentation is based on the official #link("https://developer.android.com/jetpack/compose/documentation")[Compose documentation]
  - _Official resources_:
    #link("https://developer.android.com/develop")[Android development portal], #link("https://developer.android.com/develop/ui/compose/kotlin")[Compose with Kotlin], #link("https://developer.android.com/develop/ui/compose/testing")[Testing in Compose], #link("https://developer.android.com/codelabs/jetpack-compose-basics")[Compose basics codelab], #link("https://developer.android.com/develop/ui/compose/mental-model")[Compose mental model], #link("https://kmp.jetbrains.com/#newProject")[KMP project starter], #link("https://www.jetbrains.com/lp/compose-multiplatform/")[Compose Multiplatform]
= Introduction

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
    - Originally for Android (Jetpack Compose), now multi-platform
  ],
  align(center)[
    #image("figures/compose-logo.png", width: 80%)
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
= Compose Core Concepts

#focus-slide[
  #text(size: 40pt)[All you need are *Composable Functions*!!]
  #v(0.4em)
    Focus on the UI (*what the user sees*) not on How to do it (*how to build the UI*)

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

== Composable Functions -- How to ``compose''?

- Simply by calling other composable functions #fa-arrow-up-small-big()
- Composable functions can be nested
- Composable functions can be passed as parameters to other composable functions

=== Example:
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
  State *is*, Events _happens_
  #align(center)[
    #image("figures/evolution-loop.png", width: 60%)
  ]
]

== Event vs State
- Event - An event is generated by the user or another part of the program.
- Update State - An event handler changes the state that is used by the UI.
- Display State - The UI is updated to display the new state.

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


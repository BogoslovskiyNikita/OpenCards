# OpenCards

#### About this project

OpenCards is an open source mobile app to learn natural languages, using [flashcards system](https://en.wikipedia.org/wiki/Flashcard).\
Project is created with [Godot Engine](https://godotengine.org/) [v 3.5.2]
\
\
I originally created this project to help myself with learning English. I haven't been fully satisfied with any of the existing apps, so i decided to create my own :)\
\
Feel free to contribute to this project or make your own fork!

#### Plugins / another projects used

* [godot-sqlite](https://github.com/2shady4u/godot-sqlite)
* [Omnibus sans serif font](https://fontlibrary.org/en/font/omnibus-sans-serif)
* [LibreTranslate](https://github.com/LibreTranslate/LibreTranslate) ([mirror](https://translate.terraprint.co/) by https://github.com/K-Francis-H])
* [Godot-SimpleHTTPClient](https://github.com/Abdera7mane/Godot-SimpleHTTPClient)

# Roadmap

:x: MVP\
:x: Release on Play Market\
:x: Add "Buy me a coffe" button\
:x: ~~Chill on islands~~

# Features checklist

### Library screen

#### Categories

:white_check_mark: Creating categories\
:white_check_mark: Deleting categories\
:x: Editing categories

#### Words

:white_check_mark: Creating words (word itself, translation, description)\
:white_check_mark: Deleting words\
:white_check_mark: Autotranslate words\
:x: Add word description automatically (can be implemented with https://dictionaryapi.dev/)\
:x: Adding picture to word\
:x: Editing words

### Learning screen

:white_check_mark: Generating X words on initializing screen\
:white_check_mark: Learnings card flow. If users guessed the card, write this fact to DB\
:white_check_mark: Show stats on leaning process

### Settings screen
:x: Selecting language of app interface\
:x: Selecting languages user wants to learn (for autotranslation)

### General features

:x: "About" screen\
:x: Notifications (can be implemented with [this](https://github.com/DrMoriarty/godot-local-notification) plugin)\
:x: Default categories and words


### UX/UI and visuals

:white_check_mark: Add cyrillic font\
:x: Screen transition animations\
:x: Tinder-like UI on learning screens\
:x: Move from Godot default theme\
:x: Theme selection

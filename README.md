# Ruby Hangman
A ruby game of hangman played from the terminal, an assignment for The Odin Project Ruby curriculum. The game generates a random word between 5 and 12 characters from a 10 000 word dictionary. You can then guess the letters by typing them into the terminal with 10 incorrect guesses allowed.
The game can also be saved by typing "save". The save can then be loaded at the star of a new game.

## Thoughts
The game was fun to implement, although I did struggle with the saving/loading part. It uses YAML serialization, which I could not get to work initially. I took some inspiration from @andrewjh271 and his implementation.
Looking back, this project gave me a good head start to serialization, file and directory manipulation and more practice with working with documentations.

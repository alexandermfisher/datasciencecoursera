####  Developing Data Products Quiz 2:
*Author: Alexander M Fisher*

**********

##### Question 1:

What is rmarkdown? (Check all that apply.)


- A format that can be interpreted into markdown (which is a simplified markup language).
- A simplified XML format that can be interpreted into R.
- A form of LaTeX typesetting.
- A simplified format that, when interpreted, incorporates your R analysis into your document.

###### Answer:

A format that can be interpreted into markdown (which is a simplified markup language).
A simplified format that, when interpreted, incorporates your R analysis into your document.

**********

##### Question 2:

In rmarkdown presentations, in the options for code chunks, what command prevents the code from being repeated before results in the final interpreted document?

- eval = FALSE
- echo = FALSE
- cache = FALSE
- comment = FALSE

###### Answer:

echo = FALSE

**********

##### Question 3:

In rmarkdown presentations, in the options for code chunks, what prevents the code from being interpreted?

- eval = FALSE
- run = FALSE
- cache = FALSE
- eval = NULL

###### Answer:

eval = FALSE

**********

##### Question 4:

What is leaflet? (Check all that apply.)

- An R package for creating 3D rendered isomaps
- A tool for reproducible documents
- An R package interface to the javascript library of the same name
- A javascript library for creating interactive maps

###### Answer:

An R package interface to the javascript library of the same name
A javascript library for creating interactive maps

**********

##### Question 5:

The R command `df %>% leaflet() %>% addTiles()` is equivalent to what? (Check all that apply)

###### Answer:

`addTiles(leaflet(df))`
`leaflet(df) %>% addTiles()`

**********

##### Question 6:

If I want to add popup icons to my leaflet map in R, I should use.

- addMarkers
- addTiles
- leaflet
- dplyr

###### Answer:

addMarkers

**********

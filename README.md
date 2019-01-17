# Flix
Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

## Flix Part 2
The second part to the unit will be placed here next week.

---

## Flix Part 1

### User Stories

#### REQUIRED (10pts)
- [x] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [x] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [x] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [x] (2pt) User can view the app on various device sizes and orientations.
- [ ] (1pt) Run your app on a real device.

### App Walkthough GIF
<img src="https://github.com/willtyler98/Flix/blob/develop/Flix.gif?raw=true" width=250><br>

### Notes
I did not use Storyboard files, and used the programmatic approach instead. I used Auto Layout for all views. I used the Decodable protocol to decode JSON. I used the network activity indicator when requesting the movie information. I changed the background colors to support dark mode. I overwrote scroll functions in order to hide the status bar while scrolling down.

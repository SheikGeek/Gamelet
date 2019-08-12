# Gamelet
> Many games enter, only one will be the victor! . . .unless I feel like playing multiple games
> <br/>\- Me

This app contains a mashup of my board games and Steam games. I have a lot of trouble picking something to play most of the time, so now there is DEFINITELY another app for that. I can now easily scroll through all the games I own and randomly pick one to play when I'm feeling indecisive

## Technologies and Languages Used
- Swift 5
- Xcode 10.3
- SublimeText 3
- [Color Calculator](https://www.sessions.edu/color-calculator/)

## APIs Used
[BoardGameGeek API Docs](https://bgg-json.azurewebsites.net/ "BoardGameGeek JSON API Docs")
[BoardGameGeek](https://boardgamegeek.com) helps gamers manage board games they own, board games they want, and any other board game management a user could desire.

[Steam API Docs](https://developer.valvesoftware.com/wiki/Steam_Web_API "Steam Web API Docs")
[Steam](https://store.steampowered.com/) is a gaming community for puchasing and playing games on your own or with friends. I also found [this documentation](https://steamwebapi.azurewebsites.net/) helpful in navigating Steam's api.

## Future Enhancements
The following is a list of features and tech debt I would like to implement/clean up in the future:
### Tech Debt
- UI Tests
- Unit Tests
- Lots of comments needed throughout for clarity
- Use Steam's api instead of a static file of output from one of their endpoints
  - I was being rate limited too much while testing, so I decided to just store the data locally
  - The data was also formatted in a way that I didn't want to do extra parsing for, so I modified it a little

### New/Improved Features
- Better list formatting
  - Right now the list is Alphabetical, with every letter resetting the column spacing. Some Headers would be useful for fast scrolling
- Add more info to each detail screen and to datasources in general
  - BoardGameGeek provided a bunch of information about each game (some of which I'm currently storing, but not displaying). That would be useful to see when viewing the detail view of each game.
  - Finding other APIs that provide more information about the games, especially the steam games since the data was pretty limited, would be useful.
- Favorited list of games
- Add more detailed Game Types
- Pick For Me Logic could be imporved
  - Could store a list of recently suggested games so that we don't risk any repeats too frequently
  - Could have the option to specify games to exclude based on
    - Number of players
    - "Exclude Games" list
    - Genre of game
    - Game Type
- Sort
  - Alphabetically (0 to Z and Z to 0)
  - By Most Played
  - By Least Played
  - By Never Played
- Search and Filter
  - Number of Players
  - Ownership Status (own, want, want to trade, wishlist, etc)
  - Recently Played
  - Favorited
- Share games with friends
- Login to Steam and username for BoardGameGeek stored
- Loaders for network requests
- Pull to Refresh
- Empty states
  - For entire views
  - For missing images

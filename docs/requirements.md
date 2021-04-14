# Requirements

Pngme should reduce interruptions caused by other people in your household while you are working remotely in co-living situations.

## Motivation

During the pandemic the shift to remote work has led to increased interruptions by other people in your household, while you are in meetings or working in a focused manner. This can be especially annoying, if you cannot communicate properly through doors because you are wearing headphones and may be in a call.

## Usage

In order to enable non-intrusive "Pings", which do not require textual or voice interaction the sensors of an Earable are used to detect a knod or a shake of the head. This detected response is forwarded to the pinging user, who can then proceed to enter the room or maybe try again later.

For that there is an app, which pairs with the E-Sense Earables, receives "Pings" and sends back detected responses.
The "Ping" can be sent through a mobile-friendly web app, which discovers all users with active Pngme apps in the local network.
There is a backend required to facilitate the rooms/sessions in which onyl users from the same household can communicate.


### App

- The app must be able to pair the e-sense Earables
- The app must be able to send a audio signal to the earables
- The app must be able to recognize head movement by the user
- The app should ask for a name for the client
- The app might be calibrated by the user for the two head movements
- The app may offer a general "do not disturb" feature in a given timeframe

### Web application

- The web app must be responsive
- The web app should be mobile-first
- The web app must be able to discover Pngme apps on the same network
- The user must be able to ping an app user with the web app
- The web app should ask for a name for the client
- The web app should give the user relevant feedback on their "Ping"
- The web app should be able to ping multiple users in quick succession


### Server
- The server must register applications on the same network to the same session
- The server must allow message-based communication between participants in a session
- The server should offer information about a current session to authorized users
- The server should authorize users by their public ip
- The server should be able to handle v6 addresses

## Links

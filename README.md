# Yippy
macOS open source clipboard manager

<img src="https://yippy.mattdavo.com/static/media/screenshot.431c578d.jpg"/>

Follow progress at <a href="https://yippy.mattdavo.com" target="_blank">yippy.mattdavo.com</a>

Read about the progress and learnings at <a href="https://yippy.mattdavo.com/blog" target="_blank">yippy.mattdavo.com/blog</a>

Find all releases at <a href="https://yippy.mattdavo.com/releases" target="_blank">yippy.mattdavo.com/releases</a>

## Developing Yippy
### Contributions
All contributions are welcome, whether they are pull requests, bug reports, feature requests or general feedback.

### Project Structure
There are 3 different schemes:
- Yippy
- Yippy Beta
- Yippy XCTest

__Yippy__ is used for running and archiving a production build of Yippy. __Yippy Beta__ is used for development and archiving a beta release. __Yippy XCTest__ is used exclusively for running the unit and UI tests.

### TODO
- [ ] Support more types of pasteboard items
- [ ] Allow setting preferences for keyboard shortcuts
- [ ] Automatic updates (maybe use Sparkle?)
- [ ] Create a bug reporter, if places in code are reached that should not be possible create a unique error and a prompt to report the bug.
- [ ] Don’t let any of the app be used until access is granted
- [ ] Toggle for attributed text
- [ ] Convert history storage to storing each piece of data into a file organised by directory of indexes
- [ ] Favourites
- [ ] Search
- [ ] Max history length


# 🎬 Movie App

A polished Flutter application that fetches and displays popular movies using TMDB API. Built with Dio for networking, Shared Preferences for local state, and designed with scalable architecture and clean UI.

---

## ⚡ Key Features

- 🔍 Browse popular, top-rated, and upcoming movies
- 📄 Detailed movie pages: overview, release date, ratings, genres, trailers
- 🎥 Embedded video trailers (via YouTube links)
- 👍 Save favorite movies using Shared Preferences
- 🎨 Modern UI: grid listing, autoplaying hero carousels, themed design
- 🛠️ Customizable themes (light/dark)
- 🔁 Pull-to-refresh & infinite lazy loading
- 🚨 Graceful error handling & shimmer loading indicators

---

## 📲 Screenshots

![Home Screen Showing Popular Movies](screenshots/home_screen.png)
*Home screen with a grid of movies*

![Movie Details View with Trailer & Favorites](screenshots/movie_details.png)
*Movie details view: synopsis, trailer, and favorite toggle*

![Favorites Screen](screenshots/favorites_screen.png)
*User’s saved favorite movies*

---

## 🧩 Architecture & Folder Structure

```

lib/
├── core/
│   ├── network/        # Dio API client, interceptors, network handler
│   ├── theme/          # Theme styles & color palettes
│   ├── utils/          # Common utilities (e.g. date formatting)
│   └── constants/      # Global app constants (API keys, base URLs)
│
├── data/
│   ├── models/         # Movie, Genre, Trailer, etc.
│   ├── datasources/    # Remote & local (Shared Preferences) data sources
│   └── repositories/   # Abstraction layer for data handling
│
├── domain/
│   ├── entities/       # Core entity definitions
│   └── usecases/       # Business logic (e.g. `GetPopularMovies`)
│
├── presentation/
│   ├── blocs/          # Riverpod/BLoC providers & states
│   ├── pages/          # Screens (HomePage, DetailsPage, FavoritesPage)
│   └── widgets/        # Reusable UI components (cards, buttons)
│
├── main.dart           # App entry point
└── injector.dart       # Dependency injection setup

````

---

## 🛠️ Tech Stack

| Component                  | Details                                      |
|---------------------------|----------------------------------------------|
| **Flutter**               | UI toolkit                                    |
| **Dart**                  | Programming language                          |
| **Dio**                   | HTTP client with interceptor support          |
| **Shared Preferences**    | Local data caching (favorite movies)          |
| **TMDB API**              | Movie metadata provider                       |
| **State Management**      | Riverpod (or BLoC pattern as implemented)     |

---

## 🚀 Getting Started

1. Clone the repo  
   ```bash
   git clone https://github.com/Hedra-Nabil/movie_app.git
   cd movie_app
````

2. Install dependencies & run

   ```bash
   flutter pub get
   flutter run
   ```
3. Set up TMDB API Key

   * Sign up on [www.themoviedb.org](https://www.themoviedb.org)
   * In `lib/core/constants/api_constants.dart`, replace `YOUR_API_KEY_HERE` with your key
4. (Re)build to apply the changes

---

## 🧠 Core Concepts & Implementations

### Dio Setup

Unified network and error handling via global interceptors in `core/network/dio_client.dart`.

### Shared Preferences

Utilized for storing user favorite movies — simple key-based storing of movie IDs.

### Clean Architecture

Layers separated into data, domain, and presentation, with dependency injection facilitating loose coupling.

### State Management

Handles UI states, supports partial refresh and caching logic on scrolling or toggling favorites.

### UI/UX Design

* **Movie Grid**: responsive, scrollable grid view
* **Movie Detail**: hero animations, info cards, watch trailer button
* **Favorites**: list view with removal option
* Consistent theming and typography via `core/theme/`

---

## 📌 Usage Workflow

1. User launches app → Home screen shows lists: Popular, Now Playing, etc.
2. Swipes scrolls & loads more; pulls down for refresh
3. Taps a movie → navigates to details
4. In details, taps **Watch Trailer** → opens embedded video
5. Taps heart icon → movie saved locally in favorites
6. Visits **Favorites** tab → sees their saved movies list

---

## 📚 Learning Opportunities

* Clean architecture & Dart layering
* Advanced Flutter UI (animations, responsive design)
* Networking via Dio + API pagination
* Persistent local data (Shared Preferences)
* Effective state management (Riverpod / BLoC)
* Integrating external services: YouTube, TMDB API

---

## 🤝 Contributing

Pull requests are welcome! Include:

* Clean code with comments
* Relevant tests when adding new features
* Update documentation/screenshots if needed

---

## 📄 License

This project is open-source under the **MIT License**. See [LICENSE](LICENSE) for details.

---

## 📷 Screenshots (Optional)

If you'd like high-resolution or additional images/screenshots embedded inline, just send them over and I'll hook them into the README!

---


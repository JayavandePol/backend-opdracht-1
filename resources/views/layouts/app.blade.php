@vite(['resources/css/app.css', 'resources/js/app.js'])
<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title ?? 'Jamin Magazijn' }}</title>
    @stack('head')
</head>
<body class="d-flex flex-column min-vh-100">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="{{ route('home') }}">Jamin Magazijn</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Navigatie wisselen">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mainNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link {{ request()->routeIs('home') ? 'active' : '' }}" href="{{ route('home') }}">Home</a>
                    </li>
                    @auth
                        <li class="nav-item">
                            <a class="nav-link {{ request()->routeIs('product.index') ? 'active' : '' }}" href="{{ route('product.index') }}">Overzicht Magazijn</a>
                        </li>
                    @endauth
                </ul>
                <div class="d-flex gap-2">
                    @auth
                        <a class="btn btn-outline-light btn-sm" href="{{ route('dashboard') }}">Dashboard</a>
                        <form method="POST" action="{{ route('logout') }}">
                            @csrf
                            <button type="submit" class="btn btn-light btn-sm">Uitloggen</button>
                        </form>
                    @endauth

                    @guest
                        <a class="btn btn-outline-light btn-sm" href="{{ route('login') }}">Inloggen</a>
                        <a class="btn btn-light btn-sm" href="{{ route('register') }}">Registreren</a>
                    @endguest
                </div>
            </div>
        </div>
    </nav>

    <main class="container py-5 flex-grow-1">
        @yield('content')
    </main>

    <footer class="bg-light border-top py-3 mt-auto">
        <div class="container text-center">
            <small class="text-muted">&copy; {{ now()->year }} Jamin Magazijn. Alle rechten voorbehouden.</small>
        </div>
    </footer>

    @stack('scripts')
</body>
</html>

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
    <nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-semibold d-flex align-items-center gap-2" href="{{ route('home') }}">
                <span class="badge text-bg-primary rounded-circle px-2 py-2">JM</span>
                <span>Jamin Magazijn</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Navigatie wisselen">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mainNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link {{ request()->routeIs('home') ? 'active fw-semibold' : '' }}" href="{{ route('home') }}">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link {{ request()->routeIs('allergeen.*') ? 'active fw-semibold' : '' }}" href="{{ route('allergeen.index') }}">Allergenen</a>
                    </li>
                    @auth
                        <li class="nav-item">
                            <a class="nav-link {{ request()->routeIs('product.index') ? 'active fw-semibold' : '' }}" href="{{ route('product.index') }}">Magazijn</a>
                        </li>
                    @endauth
                </ul>
                <div class="d-flex flex-column flex-lg-row align-items-lg-center gap-2">
                    @auth
                        <span class="navbar-text small text-muted">Ingelogd als {{ auth()->user()->name }}</span>
                        <a class="btn btn-outline-primary btn-sm" href="{{ route('dashboard') }}">Dashboard</a>
                        <form method="POST" action="{{ route('logout') }}">
                            @csrf
                            <button type="submit" class="btn btn-primary btn-sm">Uitloggen</button>
                        </form>
                    @endauth

                    @guest
                        <a class="btn btn-outline-primary btn-sm" href="{{ route('login') }}">Inloggen</a>
                        <a class="btn btn-primary btn-sm" href="{{ route('register') }}">Registreren</a>
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

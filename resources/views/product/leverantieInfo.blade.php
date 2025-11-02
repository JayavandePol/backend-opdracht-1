@vite(['resources/css/app.css', 'resources/js/app.js'])
<!DOCTYPE html>
<html lang="nl">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>{{ $title }}</title>
	@if ($toonFallback)
		<meta http-equiv="refresh" content="4;url={{ route('product.index') }}">
	@endif
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="{{ route('home') }}">Jamin Magazijn</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Navigatie wisselen">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="mainNavbar">
				<ul class="navbar-nav me-auto">
					<li class="nav-item">
						<a class="nav-link {{ request()->routeIs('product.index') ? 'active' : '' }}" href="{{ route('product.index') }}">Overzicht Magazijn</a>
					</li>
				</ul>
				<div class="d-flex gap-2">
					<a class="btn btn-outline-light btn-sm" href="{{ route('home') }}">Home</a>
					<a class="btn btn-outline-light btn-sm" href="{{ route('product.index') }}">Magazijn</a>
				</div>
			</div>
		</div>
	</nav>

	<main class="container py-5">
		<div class="row justify-content-center">
			<div class="col-lg-10">
				<div class="d-flex justify-content-between align-items-center mb-4">
					<h1 class="mb-0">{{ $title }}</h1>
					<a href="{{ route('product.index') }}" class="btn btn-link">&laquo; Terug naar overzicht</a>
				</div>

				@if ($leverancier)
					<div class="card mb-4">
						<div class="card-body">
							<h2 class="h5 mb-3">Leverancier</h2>
							<dl class="row mb-0">
								<dt class="col-sm-4">Naam leverancier</dt>
								<dd class="col-sm-8">{{ $leverancier->Naam }}</dd>
								<dt class="col-sm-4">Contactpersoon</dt>
								<dd class="col-sm-8">{{ $leverancier->Contactpersoon }}</dd>
								<dt class="col-sm-4">Leveranciernummer</dt>
								<dd class="col-sm-8">{{ $leverancier->Leveranciernummer }}</dd>
								<dt class="col-sm-4">Mobiel</dt>
								<dd class="col-sm-8">{{ $leverancier->Mobiel }}</dd>
							</dl>
						</div>
					</div>
				@endif

				<div class="card shadow-sm">
					<div class="card-body">
						<h2 class="h5 mb-3">Leveringen {{ $productNaam ? 'voor ' . $productNaam : '' }}</h2>

						<table class="table table-striped align-middle">
							<thead class="table-light">
								<tr>
									<th scope="col">Naam product</th>
									<th scope="col">Datum laatste levering</th>
									<th scope="col">Aantal</th>
									<th scope="col">Eerstvolgende levering</th>
								</tr>
							</thead>
							<tbody>
								@if ($toonFallback)
									<tr>
										<td colspan="4" class="text-center fw-semibold">
											Er is van dit product op dit moment geen voorraad aanwezig,
											de verwachte eerstvolgende levering is:
											{{ $verwachteLevering ? \Carbon\Carbon::parse($verwachteLevering)->format('d-m-Y') : 'onbekend' }}
										</td>
									</tr>
								@elseif ($leveringen->isEmpty())
									<tr>
										<td colspan="4" class="text-center">Er zijn nog geen leveringen geregistreerd.</td>
									</tr>
								@else
									@foreach ($leveringen as $levering)
										<tr>
											<td>{{ $levering->Naam }}</td>
											<td>{{ \Carbon\Carbon::parse($levering->DatumLevering)->format('d-m-Y') }}</td>
											<td>{{ $levering->Aantal }}</td>
											<td>
												{{ $levering->DatumEerstVolgendeLevering
													? \Carbon\Carbon::parse($levering->DatumEerstVolgendeLevering)->format('d-m-Y')
													: 'N.v.t.' }}
											</td>
										</tr>
									@endforeach
								@endif
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</main>

	<footer class="bg-light border-top py-3 mt-auto">
		<div class="container text-center">
			<small class="text-muted">&copy; {{ now()->year }} Jamin Magazijn. Alle rechten voorbehouden.</small>
		</div>
	</footer>
</body>
</html>
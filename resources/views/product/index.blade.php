@vite(['resources/css/app.css', 'resources/js/app.js'])
<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title }}</title>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <h1 class="mb-4">{{ $title }}</h1>

                @if (session('success'))
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        {{ session('success') }}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Sluiten"></button>
                    </div>
                    <meta http-equiv="refresh" content="3;url={{ route('product.index') }}">
                @endif

                @if (session('error'))
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        {{ session('error') }}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Sluiten"></button>
                    </div>
                @endif

                <table class="table table-striped table-bordered align-middle shadow-sm">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Barcode</th>
                            <th scope="col">Naam</th>
                            <th scope="col" class="text-center">Verpakkingseenheid (kg)</th>
                            <th scope="col" class="text-center">Aantal aanwezig</th>
                            <th scope="col" class="text-center">Allergenen info</th>
                            <th scope="col" class="text-center">Leverantie info</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($products as $product)
                            <tr>
                                <td>{{ $product->Barcode }}</td>
                                <td>{{ $product->Naam }}</td>
                                <td class="text-center">{{ number_format((float) $product->VerpakkingsEenheid, 1) }}</td>
                                <td class="text-center">
                                    {{ is_null($product->AantalAanwezig) ? 'Onbekend' : $product->AantalAanwezig }}
                                </td>
                                <td class="text-center">
                                    <a href="{{ route('product.allergenenInfo', $product->Id) }}" class="btn btn-outline-danger btn-sm" title="Bekijk allergenen">
                                        &times;
                                    </a>
                                </td>
                                <td class="text-center">
                                    <a href="{{ route('product.leverantieInfo', $product->Id) }}" class="btn btn-outline-primary btn-sm" title="Bekijk leverantie">
                                        ?
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6" class="text-center">Geen producten gevonden.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
@extends('layouts.app')

@if (session('success'))
    @push('head')
        <meta http-equiv="refresh" content="3;url={{ route('allergeen.index') }}">
    @endpush
@endif

@section('content')
    <div class="row justify-content-center">
        <div class="col-lg-10 col-xl-8">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                <div>
                    <h1 class="mb-1">{{ $title }}</h1>
                    <p class="text-muted mb-0">Beheer hier alle geregistreerde allergenen.</p>
                </div>
                <a href="{{ route('allergeen.create') }}" class="btn btn-primary">Nieuwe allergeen</a>
            </div>

            @if (session('success'))
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    {{ session('success') }}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Sluiten"></button>
                </div>
            @endif

            @if (session('error'))
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    {{ session('error') }}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Sluiten"></button>
                </div>
            @endif

            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th scope="col">Naam</th>
                                    <th scope="col">Omschrijving</th>
                                    <th scope="col" class="text-center">Acties</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($allergenen as $allergeen)
                                    <tr>
                                        <td class="fw-semibold">{{ $allergeen->Naam }}</td>
                                        <td>{{ $allergeen->Omschrijving }}</td>
                                        <td class="text-center">
                                            <div class="d-flex justify-content-center gap-2">
                                                <a href="{{ route('allergeen.edit', $allergeen->Id) }}" class="btn btn-outline-primary btn-sm">Wijzig</a>
                                                <form action="{{ route('allergeen.destroy', $allergeen->Id) }}" method="POST" onsubmit="return confirm('Weet je zeker dat je dit allergeen wilt verwijderen?');">
                                                    @csrf
                                                    @method('DELETE')
                                                    <button type="submit" class="btn btn-outline-danger btn-sm">Verwijder</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="3" class="text-center text-muted py-4">Er zijn momenteel geen allergenen opgeslagen.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
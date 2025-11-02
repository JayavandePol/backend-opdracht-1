@extends('layouts.app')

@section('content')
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-6">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="mb-0">{{ $title }}</h1>
                <a href="{{ route('allergeen.index') }}" class="btn btn-outline-secondary">Terug naar overzicht</a>
            </div>

            @if ($errors->any())
                <div class="alert alert-danger">
                    <h2 class="h6 mb-2">Er ging iets mis</h2>
                    <ul class="mb-0 ps-3">
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <div class="card shadow-sm">
                <div class="card-body">
                    <form method="POST" action="{{ route('allergeen.update', $allergeen->Id) }}" novalidate>
                        @csrf
                        @method('PUT')

                        <div class="mb-3">
                            <label for="InputName" class="form-label">Naam</label>
                            <input name="naam" type="text" class="form-control @error('naam') is-invalid @enderror" id="InputName" value="{{ old('naam', $allergeen->Naam) }}" required>
                            @error('naam')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mb-4">
                            <label for="InputDescription" class="form-label">Omschrijving</label>
                            <textarea name="omschrijving" class="form-control @error('omschrijving') is-invalid @enderror" id="InputDescription" rows="3" required>{{ old('omschrijving', $allergeen->Omschrijving) }}</textarea>
                            @error('omschrijving')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">Opslaan</button>
                            <a href="{{ route('allergeen.index') }}" class="btn btn-secondary">Annuleren</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
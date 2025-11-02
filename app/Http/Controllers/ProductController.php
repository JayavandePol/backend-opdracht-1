<?php

namespace App\Http\Controllers;

use App\Models\ProductModel;
use Illuminate\Http\Request;


class ProductController extends Controller
{
    private $productModel;

    public function __construct()
    {
       $this->productModel = new ProductModel();
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products = collect($this->productModel->sp_GetAllProducts())
            ->sortBy('Barcode')
            ->values();

        return view('product.index', [
            'title' => 'Overzicht Magazijn Jamin',
            'products' => $products
        ]);
    }

    public function allergenenInfo()
    {
        return view('product.allergeenInfo', [
            'title' => 'Allergeen Informatie'
        ]);
    }

     public function leverantieInfo(int $id)
    {
        $leverancierRows = $this->productModel->sp_GetLeverantieInfo($id);
        $leveringenRows = $this->productModel->sp_GetLeverancierInfo($id);

        if (empty($leverancierRows) && empty($leveringenRows)) {
            return redirect()
                ->route('product.index')
                ->with('error', 'Leveringsinformatie voor dit product is niet gevonden.');
        }

        $leverancier = $leverancierRows[0] ?? null;
        $leveringen = collect($leveringenRows)->sortBy('DatumLevering')->values();

        $productNaam = $leveringen->first()->Naam ?? null;
        $aantalAanwezig = (int) ($leveringen->first()->AantalAanwezig ?? 0);

        $verwachteLevering = $leveringen
            ->map(fn ($row) => $row->DatumEerstVolgendeLevering)
            ->filter()
            ->first();

        if (!$verwachteLevering && $leveringen->isNotEmpty()) {
            $verwachteLevering = $leveringen->last()->DatumEerstVolgendeLevering;
        }

        return view('product.leverantieInfo', [
            'title' => 'Levering Informatie',
            'leverancier' => $leverancier,
            'leveringen' => $leveringen,
            'productNaam' => $productNaam,
            'toonFallback' => $aantalAanwezig <= 0,
            'verwachteLevering' => $verwachteLevering,
        ]);
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(ProductModel $productModel)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(ProductModel $productModel)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, ProductModel $productModel)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ProductModel $productModel)
    {
        //
    }
}

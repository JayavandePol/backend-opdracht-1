<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ProductModel extends Model
{
    public function sp_GetAllProducts()
    {
        return DB::select('CALL sp_GetAllProducts()');
    }

    public function sp_GetLeverantieInfo(int $productId)
    {
        return DB::select('CALL sp_GetLeverantieInfo(:id)', ['id' => $productId]);
    }

    public function sp_GetAllergenenByProduct(int $productId)
    {
        return DB::select('CALL sp_GetAllergenenByProduct(:id)', ['id' => $productId]);
    }

    public function sp_GetLeverancierInfo(int $productId)
    {
        return DB::select('CALL sp_GetLeverancierInfo(:id)', ['id' => $productId]);
    }
}

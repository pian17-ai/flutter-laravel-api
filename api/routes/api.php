<?php

use App\Http\Controllers\ProductController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/heloo', function () {
    return response()->json([
        'message' => 'hellowww'
    ]);
});

Route::apiResource('products', ProductController::class);

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;

#[Fillable(['name', 'price', 'stock', 'description', 'image'])]
class Product extends Model
{
    protected $fillable = [
        'name', 'price', 'stock', 'description', 'image'
    ];
}

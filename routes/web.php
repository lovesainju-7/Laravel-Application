<?php

use Illuminate\Support\Facades\Route;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/user', function () {
    return response()->make(
        '<h1 style="text-align:center; margin-top:40vh;">Welcome to user page</h1>'
    );
});


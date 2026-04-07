<?php

use App\Http\Controllers\MessageContoller;
use Illuminate\Support\Facades\Route;

Route::get('/',[MessageContoller::class, 'index']);
Route::post('/send',[MessageContoller::class, 'send']);

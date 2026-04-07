<?php

namespace App\Http\Controllers;

use App\Events\MessageSentEvent;
use App\Models\Message;
use Illuminate\Http\Request;

class MessageContoller extends Controller
{
    public function index() 
    {
        $messages = Message::latest()->take(30)->get()->reverse();

        return view('chat', compact('messages'));
    }

    public function send(Request $request) 
    {
        $validated = $request->validate([
            'content' => 'required|string',
        ]);

        $message = Message::create($validated);

        event(new MessageSentEvent($message->content));

        return response()->json([
            'status' => 'message sent'
        ], 200);
    }
}

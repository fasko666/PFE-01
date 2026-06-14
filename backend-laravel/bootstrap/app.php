<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    // SPA uses Bearer tokens — register /broadcasting/auth behind Sanctum
    // (the default web middleware would require session cookies). This also
    // loads routes/channels.php once the app has booted.
    ->withBroadcasting(
        channels: __DIR__.'/../routes/channels.php',
        attributes: ['middleware' => ['auth:sanctum']],
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->statefulApi();
        $middleware->alias([
            'admin' => \App\Http\Middleware\EnsureAdmin::class,
            'role'  => \App\Http\Middleware\EnsureRole::class,
            'plan'  => \App\Http\Middleware\EnsurePlan::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        // API requests must get JSON 401, not a redirect to a named 'login' route
        $exceptions->render(function (\Illuminate\Auth\AuthenticationException $e, \Illuminate\Http\Request $request) {
            if ($request->expectsJson() || $request->is('api/*')) {
                return response()->json(['message' => 'Unauthenticated.'], 401);
            }
        });
    })->create();

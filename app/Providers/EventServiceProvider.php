<?php

namespace App\Providers;

use App\Jobs\MessageSent;
use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Event;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event to listener mappings for the application.
     *
     * @var array<class-string, array<int, class-string>>
     */
    protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
    ];

    /**
     * Register any events for your application.
     */
    public function boot(): void
    {
        \App::bind(MessageSent::class. '@handle', fn ($job) => $job->handle());
        \App::bind(AdCreated::class . '@handle', fn ($job) => $job->handle());
        \App::bind(AdUpdated::class . '@handle', fn ($job) => $job->handle());
        \App::bind(AdDeleted::class . '@handle', fn ($job) => $job->handle());
        \App::bind(AddBanner::class . '@handle', fn ($job) => $job->handle());
        \App::bind(AddComment::class . '@handle', fn ($job) => $job->handle());
        \App::bind(AdLike::class . '@handle', fn ($job) => $job->handle());
        \App::bind(DeleteComment::class . '@handle', fn ($job) => $job->handle());
        \App::bind(DeleteBanner::class . '@handle', fn ($job) => $job->handle());
        \App::bind(UpdateBanner::class . '@handle', fn ($job) => $job->handle());
        \App::bind(UnLike::class . '@handle', fn ($job) => $job->handle());
        \App::bind(UserCreated::class . '@handle', fn ($job) => $job->handle());
        \App::bind(PlanUpdated::class . '@handle', fn ($job) => $job->handle());
        \App::bind(SplashCreated::class . '@handle', fn ($job) => $job->handle());
        \App::bind(SplashUpdated::class . '@handle', fn ($job) => $job->handle());
        \App::bind(SplashDeleted::class . '@handle', fn ($job) => $job->handle());
        \App::bind(SplashAdPriceUpdated::class . '@handle', fn ($job) => $job->handle());
        \App::bind(AdPromotion::class . '@handle', fn ($job) => $job->handle());
        \App::bind(AdEndPromotion::class . '@handle', fn ($job) => $job->handle());
    }

    /**
     * Determine if events and listeners should be automatically discovered.
     */
    public function shouldDiscoverEvents(): bool
    {
        return false;
    }
}

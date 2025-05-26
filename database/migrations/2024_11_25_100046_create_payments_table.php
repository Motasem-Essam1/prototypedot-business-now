<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('package_id')->constrained('packages');
            $table->text('transaction_id')->nullable();
            $table->text('local_token')->nullable();
            $table->double('amount_subtotal')->nullable();
            $table->string('request_create_at')->nullable();
            $table->string('currency')->nullable();
            $table->string('expires_at')->nullable();
            $table->timestamp('transaction_at')->nullable();
            $table->text('url')->nullable();
            $table->boolean('status')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};

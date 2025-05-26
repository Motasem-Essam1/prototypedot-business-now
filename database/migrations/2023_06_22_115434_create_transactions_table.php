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
        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->enum('type',['ad_promotion','banner','splash_ad']);
            $table->foreignId('ad_id')->nullable()->constrained()->onDelete('set null');
            $table->foreignId('banner_id')->nullable()->constrained()->onDelete('set null');
            $table->integer('user_id')->nullable();
//            $table->foreignId('splash_ad_id')->nullable()->constrained()->onDelete('set_null');
            $table->decimal('amount');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transactions');
    }
};

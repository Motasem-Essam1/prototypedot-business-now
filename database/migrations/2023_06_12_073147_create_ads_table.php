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
        Schema::create('ads', function (Blueprint $table) {
            $table->id();
            $table->enum('type',['product','service','required_service']);
            $table->string('title');
            $table->text('description');
            $table->decimal('price');
            $table->enum('region',['egypt','morocco']);
            $table->foreignId('category_id')->constrained();
            $table->integer('views')->default(0);
            $table->integer('user_id');
            $table->integer('company_id')->nullable();
            $table->boolean('approved')->default(false);
            $table->date('promotion_expiry')->nullable();
            $table->decimal('promotion_price')->nullable();
            $table->foreignId('promotion_plan_id')->nullable()->constrained('promotion_plans');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ads');
    }
};

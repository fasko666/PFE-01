<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('freelancer_profiles', function (Blueprint $table) {
            if (!Schema::hasColumn('freelancer_profiles', 'onboarding_completed')) {
                $table->boolean('onboarding_completed')->default(false)->after('is_available');
            }
            if (!Schema::hasColumn('freelancer_profiles', 'category')) {
                $table->string('category')->nullable()->after('title');
            }
            if (!Schema::hasColumn('freelancer_profiles', 'specialties')) {
                $table->json('specialties')->nullable()->after('category');
            }
            if (!Schema::hasColumn('freelancer_profiles', 'experience')) {
                $table->json('experience')->nullable();
            }
            if (!Schema::hasColumn('freelancer_profiles', 'education')) {
                $table->json('education')->nullable();
            }
            if (!Schema::hasColumn('freelancer_profiles', 'date_of_birth')) {
                $table->date('date_of_birth')->nullable();
            }
            if (!Schema::hasColumn('freelancer_profiles', 'address')) {
                $table->json('address')->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('freelancer_profiles', function (Blueprint $table) {
            $table->dropColumn([
                'onboarding_completed', 'category', 'specialties',
                'experience', 'education', 'date_of_birth', 'address',
            ]);
        });
    }
};

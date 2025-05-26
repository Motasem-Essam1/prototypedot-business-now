<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Category extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('categories')->insert([
            //1
            [
                'parent_id' => null,
                'name_en' => 'Furniture',
                'name_ar' => 'الأثاث',
                'name_fr' => 'Mobilier',
                'image_web' =>null,
                'image_app' => null,

            ],
            //2
            [
                'parent_id' => null,
                'name_en' => 'Lands',
                'name_ar' => 'الأراضي',
                'name_fr' => 'Terrains',
                'image_web' =>null,
                'image_app' => null,

            ],
            //3
            [
                'parent_id' => null,
                'name_en' => 'Property',
                'name_ar' => 'العقارات',
                'name_fr' => 'Propriétés',
                'image_web' => null,
                'image_app' => null,

            ],
            //4
            [
                'parent_id' => null,
                'name_en' => 'Cars',
                'name_ar' => 'السيارات',
                'name_fr' => 'Voitures',
                'image_web' => null,
                'image_app' => null,

            ],
            //5
            [
                'parent_id' => null,
                'name_en' => 'Car Showrooms',
                'name_ar' => 'معارض السيارات',
                'name_fr' => 'Salles d\'exposition de voitures',
                'image_web' => null,
                'image_app' => null,

            ],
            //6
            [
                'parent_id' => null,
                'name_en' => 'Motorcycles',
                'name_ar' => 'الدراجات النارية',
                'name_fr' => 'Motocyclettes',
                'image_web' => null,
                'image_app' => null,

            ],
            //7
            [
                'parent_id' => null,
                'name_en' => 'Spare Parts',
                'name_ar' => 'قطع الغيار',
                'name_fr' => 'Pièces de rechange',
                'image_web' => null,
                'image_app' => null,

            ],
            //8
            [
                'parent_id' => null,
                'name_en' => 'Offshore Tools',
                'name_ar' => 'أدوات البحرية',
                'name_fr' => 'Outils offshore',
                'image_web' => null,
                'image_app' => null,
            ],
            //9
            [
                'parent_id' => null,
                'name_en' => 'Heavy Equipment',
                'name_ar' => 'المعدات الثقيلة',
                'name_fr' => 'Équipement lourd',
                'image_web' => null,
                'image_app' => null,
            ],
            //10
            [
                'parent_id' => null,
                'name_en' => 'Pesticides & Pest Control',
                'name_ar' => 'المبيدات ومكافحة الآفات',
                'name_fr' => 'Pesticides et lutte antiparasitaire',
                'image_web' => null,
                'image_app' => null,
            ],
            //11
            [
                'parent_id' => null,
                'name_en' => 'Air Conditioner',
                'name_ar' => 'تكييف',
                'name_fr' => 'Climatiseur',
                'image_web' => null,
                'image_app' => null,
            ],
            //12
            [
                'parent_id' => null,
                'name_en' => 'Cleaning Services',
                'name_ar' => 'خدمات التنظيف',
                'name_fr' => null,
                'image_web' => null,
                'image_app' => null,
            ],
            //13
            [
                'parent_id' => null,
                'name_en' => 'Occasions',
                'name_ar' => 'مناسبات',
                'name_fr' => 'Occasions',
                'image_web' => null,
                'image_app' => null,
            ],
            //14
            [
                'parent_id' => null,
                'name_en' => 'Construction',
                'name_ar' => 'البناء',
                'name_fr' => 'Construction',
                'image_web' => null,
                'image_app' => null,
            ],
            //15
            [
                'parent_id' => null,
                'name_en' => 'Move Furniture',
                'name_ar' => 'نقل الأثاث',
                'name_fr' => 'Démenagement',
                'image_web' => null,
                'image_app' => null,
            ],
            //16
            [
                'parent_id' => null,
                'name_en' => 'Transport SRV',
                'name_ar' => 'خدمات النقل',
                'name_fr' => 'Services de transport',
                'image_web' => null,
                'image_app' => null,
            ],
            //17
            [
                'parent_id' => null,
                'name_en' => 'Decor & Interior Design',
                'name_ar' => 'ديكور وتصميم داخلي',
                'name_fr' => 'Décoration et design d\'intérieur',
                'image_web' =>null,
                'image_app' => null,
            ],
            //18
            [
                'parent_id' => null,
                'name_en' => 'Gardening & Agriculture',
                'name_ar' => 'الحدائق والزراعة',
                'name_fr' => 'Jardins et agriculture',
                'image_web' => null,
                'image_app' => null,
            ],
            //19
            [
                'parent_id' => null,
                'name_en' => 'Education',
                'name_ar' => 'تعليم',
                'name_fr' => 'Éducation',
                'image_web' => null,
                'image_app' => null,
            ],
            //20
            [
                'parent_id' => null,
                'name_en' => 'Selling Projects',
                'name_ar' => 'مشاريع للبيع',
                'name_fr' => 'Projets à vendre',
                'image_web' => null,
                'image_app' => null,
            ],
            //21
            [
                'parent_id' => null,
                'name_en' => 'Commercial Services',
                'name_ar' => 'خدمات تجارية',
                'name_fr' => 'Services commerciaux',
                'image_web' => null,
                'image_app' => null,
            ],
            //22
            [
                'parent_id' => null,
                'name_en' => 'Maintenance Services',
                'name_ar' => 'خدمات الصيانة',
                'name_fr' => 'Services de maintenance',
                'image_web' => null,
                'image_app' => null,
            ],
            //23
            [
                'parent_id' => null,
                'name_en' => 'Employers',
                'name_ar' => 'أرباب العمل',
                'name_fr' => 'Employeurs',
                'image_web' => null,
                'image_app' => null,
            ],
            //24
            [
                'parent_id' => null,
                'name_en' => 'Job Applicants',
                'name_ar' => 'الباحثون عن عمل',
                'name_fr' => 'Demandeurs d\'emploi',
                'image_web' => '/Services/jobApplicants.png',
                'image_app' => null,
            ],
            //25
            [
                'parent_id' => null,
                'name_en' => 'Men Stuff',
                'name_ar' => 'أشياء الرجال',
                'name_fr' => 'Affaires d\'hommes',
                'image_web' => '/family/men.png',
                'image_app' => null,
            ],
            //26
            [
                'parent_id' => null,
                'name_en' => 'Women Stuff',
                'name_ar' => 'أشياء النساء',
                'name_fr' => 'Affaires de femmes',
                'image_web' => '/family/women.png',
                'image_app' => null,
            ],
            //27
            [
                'parent_id' => null,
                'name_en' => 'Kids Stuff',
                'name_ar' => 'أشياء الأطفال',
                'name_fr' => 'Affaires d\'enfants',
                'image_web' => '/family/kids.png',
                'image_app' => null,
            ],
            //28
            [
                'parent_id' => null,
                'name_en' => 'Gifts',
                'name_ar' => 'الهدايا',
                'name_fr' => 'Cadeaux',
                'image_web' =>'/family/gifts.png',
                'image_app' => null,
            ],
            //29
            [
                'parent_id' => null,
                'name_en' => 'Foods',
                'name_ar' => 'الأطعمة',
                'name_fr' => 'Aliments',
                'image_web' => '/family/foods.png',
                'image_app' => null,
            ],
            //30
            [
                'parent_id' => null,
                'name_en' => 'Electronics',
                'name_ar' => 'الإلكترونيات',
                'name_fr' => 'Électronique',
                'image_web' => '/electronics/electronics.png',
                'image_app' => null,
            ],
            //31
            [
                'parent_id' => null,
                'name_en' => 'Mobiles',
                'name_ar' => 'الموبايلات',
                'name_fr' => 'Mobiles',
                'image_web' => '/electronics/mobiles.png',
                'image_app' => null,
            ],
            //32
            [
                'parent_id' => null,
                'name_en' => 'Home Appliance',
                'name_ar' => 'أجهزة المنزل',
                'name_fr' => 'Appareils ménagers',
                'image_web' => '/electronics/homeAppliances.png',
                'image_app' => null,
            ],
            //33
            [
                'parent_id' => null,
                'name_en' => 'Camera & Videos',
                'name_ar' => 'كاميرات و فيديوهات',
                'name_fr' => 'Appareils photo et vidéos',
                'image_web' => '/electronics/homeAppliances.png',
                'image_app' => null,
            ],
            //34
            [
                'parent_id' => null,
                'name_en' => 'Electronic Games',
                'name_ar' => 'ألعاب الكترونية',
                'name_fr' => 'Jeux électroniques',
                'image_web' => '/electronics/electronicGames.png',
                'image_app' => null,
            ],
            //35
            [
                'parent_id' => null,
                'name_en' => 'Sport & Fitness',
                'name_ar' => 'الرياضة واللياقة البدنية',
                'name_fr' => 'Sport et remise en forme',
                'image_web' => '/sportAndFitness/sportAndFitness.png',
                'image_app' => null,
            ],
            //36
            [
                'parent_id' => null,
                'name_en' => 'Health',
                'name_ar' => 'الصحة',
                'name_fr' => 'Santé',
                'image_web' => '/sportAndFitness/health.png',
                'image_app' => null,
            ],
            //37
            [
                'parent_id' => null,
                'name_en' => 'Smart & Bicycle',
                'name_ar' => 'الدراجات الذكية',
                'name_fr' => 'Vélo intelligent',
                'image_web' => '/sportAndFitness/smartAndBicycle.png',
                'image_app' => null,
            ],
            //38
            [
                'parent_id' => null,
                'name_en' => 'Tourism',
                'name_ar' => 'السياحة',
                'name_fr' => 'Tourisme',
                'image_web' => '/travel/airplan.png',
                'image_app' => null,
            ],
            //39
            [
                'parent_id' => null,
                'name_en' => 'Trip & Camping',
                'name_ar' => 'الرحلات والتخييم',
                'name_fr' => 'Voyages et camping',
                'image_web' => '/travel/camping.png',
                'image_app' => null,
            ],
            //40
            [
                'parent_id' => null,
                'name_en' => 'Horses, Sheep & Camels',
                'name_ar' => 'الخيل والأغنام والجمال',
                'name_fr' => 'Chevaux, moutons et chameaux',
                'image_web' => '/animals/camal.png',
                'image_app' => null,
            ],
            //41
            [
                'parent_id' => null,
                'name_en' => 'Other Animals',
                'name_ar' => 'حيوانات أخرى',
                'name_fr' => 'Autres animaux',
                'image_web' => '/animals/rabbit.png',
                'image_app' => null,
            ],
            //42
            [
                'parent_id' => null,
                'name_en' => 'Birds',
                'name_ar' => 'الطيور',
                'name_fr' => 'Oiseaux',
                'image_web' => '/animals/bird.png',
                'image_app' => null,
            ],
            //43
            [
                'parent_id' => null,
                'name_en' => 'Others',
                'name_ar' => 'أخرى',
                'name_fr' => 'Autres',
                'image_web' => '/others/book.png',
                'image_app' => null,
            ],
            //44
            [
                'parent_id' => null,
                'name_en' => 'Special Coins',
                'name_ar' => 'عملات خاصة',
                'name_fr' => 'Pièces spéciales',
                'image_web' =>'/others/coins.png',
                'image_app' => null,
            ],
            //45
            [
                'parent_id' => null,
                'name_en' => 'Antiques',
                'name_ar' => 'العتيقة',
                'name_fr' => 'Antiquités',
                'image_web' => '/others/antiques.png',
                'image_app' => null,
            ],
            //46
            [
                'parent_id' => null,
                'name_en' => 'Charity',
                'name_ar' => 'الخيرية',
                'name_fr' => 'Charité',
                'image_web' => '/others/charitable.png',
                'image_app' => null,
            ],
            //47
            [
                'parent_id' => null,
                'name_en' => 'Inquiry',
                'name_ar' => 'استفسار',
                'name_fr' => 'Demande',
                'image_web' => '/others/inquires.png',
                'image_app' => null,
            ],
             //48
             [
                'parent_id' => null,
                'name_en' => 'National Product',
                'name_ar' => 'منتج وطني',
                'name_fr' => 'Produit National',
                'image_web' => '/flag.png',
                'image_app' => null,
            ],
        ]);
    }
}

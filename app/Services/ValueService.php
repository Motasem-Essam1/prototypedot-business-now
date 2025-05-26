<?php

namespace App\Services;

use App\Models\Value;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class ValueService.
 */
class ValueService
{

    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index()
    {
        return Value::query()->get();
    }

    public function byFilter($filterId)
    {
        return Value::where('filter_id', $filterId)->get();
    }

    /**
     * Add a new value.
     *
     * @param array $data
     * @return array
     */
    public function addValue(array $data): array
    {
        $value = new Value;
        $value->filter_id = $data['filter_id'];
        $value->name = $data['name'];

        $value->save();

        return $value->toArray();
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return Builder|Builder[]|Collection|Model
     */
    public function show(int $id)
    {
        return Value::query()->find($id);
    }

    /**
     * Update the specified resource.
     *
     * @param array $data
     * @param int $id
     * @return Builder|Builder[]|Collection|Model
     */
    public function update(array $data, int $id)
    {
        $value = Value::query()->find($id);
        if ($value) {
            $value->filter_id = $data['filter_id'];
            $value->name = $data['name'];
            $value->save();
        }

        return $value;
    }

    /**
     * Delete the specified resource.
     *
     * @param int $id
     * @return void
     */
    public function destroy(int $id): void
    {
        $value = Value::query()->find($id);
        if ($value) {
            $value->delete();
        }
    }
}

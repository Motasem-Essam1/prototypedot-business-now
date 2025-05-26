<?php

namespace App\Services;

use App\Models\Filter;
use App\Models\Value;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class FilterService.
 */
class FilterService
{
    /**
     * Display a listing of the resource.
     *
     * @return Builder[]|Collection
     */
    public function index()
    {
        return Filter::query()->get();
    }

    public function byCategory(int $id)
    {
        return Filter::query()->where("category_id", $id)->get();
    }

    /**
     * Add a new Filter.
     *
     * @param array $data
     * @return array
     */
    public function addFilter(array $data): array
    {
        $filter = new Filter;
        $filter->name = $data['name'];
        $filter->category_id = $data['category_id'];
        $filter->save();

        return $filter->toArray();
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return Builder|Builder[]|Collection|Model
     */
    public function show(int $id)
    {
        return Filter::query()->find($id);
    }

    /**
     * Update the specified resource.
     *
     * @param array $request
     * @param int $id
     * @return Builder|Builder[]|Collection|Model
     */
    public function update(array $request, int $id)
    {
        $filter = Filter::query()->find($id);
        $filter->name = $request['name'];
        $filter->category_id = $request['category_id'];
        $filter->save();

        return $filter;
    }

    /**
     * Delete the specified resource.
     *
     * @param int $id
     * @return void
     */
    public function destroy(int $id): void
    {
        $filter = Filter::query()->find($id);
        Value::query()->where("filter_id", $filter->id)->delete();
        $filter->delete();
    }
}

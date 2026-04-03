# Filters

Saved filters are personal custom views for the authenticated user. They reuse the same filtering model as the cards page in the web app, and can be opened in the web UI via `GET /:account_slug/cards?filter_id=:id`.

## `GET /:account_slug/filters`

Returns the current user's saved personal custom views, ordered by most recently updated first.

__Response:__

```json
[
  {
    "id": "03filt9x2ab",
    "boards_label": "Writebook",
    "summary": "Newest, #mobile, and assigned to JZ",
    "params": {
      "sorted_by": "newest",
      "tag_ids": ["03f5tagmobile"],
      "assignee_ids": ["03f5userjz"]
    },
    "created_at": "2026-04-03T15:20:00.000Z",
    "updated_at": "2026-04-03T15:20:00.000Z",
    "url": "http://fizzy.localhost:3006/897362094/filters/03filt9x2ab.json",
    "cards_url": "http://fizzy.localhost:3006/897362094/cards?filter_id=03filt9x2ab"
  }
]
```

## `GET /:account_slug/filters/:id`

Returns one saved personal custom view belonging to the current user.

__Response:__

Returns the same object shape as `GET /:account_slug/filters`.

## `POST /:account_slug/filters`

Creates a saved personal custom view from the same filter fields supported by the web cards UI.

__Accepted Parameters:__

| Parameter | Description |
|-----------|-------------|
| `board_ids[]` | Filter by board ID(s) you can access |
| `tag_ids[]` | Filter by tag ID(s) in the current account |
| `assignee_ids[]` | Filter by assignee user ID(s) |
| `creator_ids[]` | Filter by creator user ID(s) |
| `closer_ids[]` | Filter by closer user ID(s) |
| `indexed_by` | One of: `all`, `closed`, `not_now`, `stalled`, `postponing_soon`, `golden` |
| `sorted_by` | One of: `latest`, `newest`, `oldest` |
| `assignment_status` | `unassigned` |
| `creation` | One of: `today`, `yesterday`, `thisweek`, `lastweek`, `thismonth`, `lastmonth`, `thisyear`, `lastyear` |
| `closure` | One of: `today`, `yesterday`, `thisweek`, `lastweek`, `thismonth`, `lastmonth`, `thisyear`, `lastyear` |
| `terms[]` | Search terms |

`card_ids[]` is intentionally not supported for saved-filter creation over JSON because it is not a normal user-facing saved filter in the web UI.

If you submit the same normalized filter more than once, Fizzy reuses the existing saved filter for that user and updates its `updated_at` timestamp instead of creating a duplicate.

__Response:__

Returns `201 Created` for a new saved filter, or `200 OK` when the same saved filter already exists for the current user.

```json
{
  "id": "03filt9x2ab",
  "boards_label": "Writebook",
  "summary": "Newest, #mobile, and assigned to JZ",
  "params": {
    "sorted_by": "newest",
    "tag_ids": ["03f5tagmobile"],
    "assignee_ids": ["03f5userjz"]
  },
  "created_at": "2026-04-03T15:20:00.000Z",
  "updated_at": "2026-04-03T15:20:00.000Z",
  "url": "http://fizzy.localhost:3006/897362094/filters/03filt9x2ab.json",
  "cards_url": "http://fizzy.localhost:3006/897362094/cards?filter_id=03filt9x2ab"
}
```

__Validation Errors:__

Returns `422 Unprocessable Entity` if the request contains unsupported values, malformed array fields, or unknown/inaccessible IDs.

```json
{
  "errors": {
    "board_ids": ["contains unknown or inaccessible ids"],
    "indexed_by": ["is invalid"]
  }
}
```

## `DELETE /:account_slug/filters/:id`

Deletes one of the current user's saved personal custom views.

__Response:__

Returns `204 No Content` on success.

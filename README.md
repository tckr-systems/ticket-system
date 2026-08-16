# HoloTek Ticket Vault

Ticket-sales console for FOI staff — a Rails 8 + Mongoid + Turbo 8 app for
recording sold tickets. Dark glassmorphism UI, full CRUD, and smooth
create/edit/delete transitions over Turbo Streams (deletes "poof" out).

*Rails 8 · MongoDB via Mongoid (no SQL) · Turbo 8 + Stimulus · Import Maps ·
Tailwind CSS (tailwindcss-rails)*

## Quick start

Docker Compose runs the app against an **ephemeral** MongoDB (data lives in
memory and resets on restart):

```bash
docker compose up --build
# open http://localhost:3000
```

Local (no Docker):

```bash
# needs a MongoDB at localhost:27017 (it can be ephemeral)
gem install bundler
bundle install
bin/rails tailwindcss:build
bin/rails db:mongoid:create_indexes
bin/dev   # rails server + tailwind watch via foreman
```

`MONGO_URI` overrides the Mongo connection (default:
`mongodb://mongo:27017/ticket_system_development`).

## Features

- **Create** — sell a ticket: buyer name, seat (e.g. `E14`), address, price
  paid, email. Validates presence, `seat_id_seq` uniqueness (DB index too),
  and email format.
- **Index** — the root page renders every sold ticket in a live glass table.
- **Show** — click a row for full buyer details in a no-reload modal.
- **Update** — inline panel edit, no page reload; same validations as create.
- **Destroy** — row fades out ("Poof!") and the document is deleted immediately.
- Controller responds to both **HTML** and **Turbo Streams** for
  create/update/destroy.

## Stack notes

- `app/models/ticket.rb` — `Mongoid::Document` with `price_paid` as `BigDecimal`.
- `docker-compose.yml` — `mongo:8` started with `--storageEngine
  ephemeralForTest` so soft-resetting the DB between dev sessions is free.
- `app/javascript/application.js` — intercepts `turbo:before-stream-render` to
  animate `remove` stream actions before Turbo deletes the row.
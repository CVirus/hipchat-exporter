HipChat Exporter
================

[![CircleCI](https://circleci.com/gh/livesense-inc/hipchat-exporter.svg?style=svg)](https://circleci.com/gh/livesense-inc/hipchat-exporter)

Export the history (messages) of rooms from HipChat.

## Requirements

* Ruby 2.5.0
* MySQL 5.6.4+ (utf8mb4)

## Usage

### (1) Export the history of rooms to JSON files

```
# bundle exec thor help history:export
Usage:
  thor task:history:export

Options:
  [--from=FROM]  # Date (or Time) like "20180101"
  [--to=TO]      # Date (or Time), like "20180131", default is Time.current
  [--threads=N]  # Threads count for speedup blocking operations
  [--force]      # Skip asking questions
```

Example:

```
bundle exec thor task:history:export --from=20171101 --to=20171107 --threads=20
```

### (2) Save the history of rooms to DB

```
bundle exec thor task:history:save
```

## Setup

```
git clone git@github.com:livesense-inc/hipchat-exporter.git
cd hipchat-exporter
```

```
bundle install --path vendor/bundle
bundle exec rake db:create
bundle exec rake db:migrate
```

```
cp .env.example .env
```

Fill `HIPCHAT_TOKEN` in `.env`

```
cp rooms.csv.example rooms.csv
```

Fill room_id and room_name in `rooms.csv` (room_name is optional)

## Testing

```
bundle exec rspec
```

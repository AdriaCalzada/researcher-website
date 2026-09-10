# Adrià Calzada — research website

A fast, responsive one-page research portfolio built with Jekyll and designed for GitHub Pages.

## Update the content

### Add a publication

1. Duplicate a file in `_posts/`.
2. Change the title, publication date, journal, field, authors, paper URL, short summary and abstract.
3. Add an optimized WebP image to `img/portfolio/` and reference its filename with `thumbnail`.

The filename must begin with a date (`YYYY-MM-DD-`) so Jekyll recognizes it as a post. The site sorts publications using the `date` in the front matter, newest first.

### Add a poster

1. Save the full PDF in `img/posters/`.
2. Export its first page as a WebP preview in the same folder.
3. Add the title, event, year, thumbnail and PDF paths to `_data/posters.yml`.

### Add a journal cover

Save the PDF and WebP preview in `img/covers/`, then update `_data/covers.yml`. The current design highlights the first cover in that file.

## Run locally

The repository includes Docker support:

```sh
docker compose up --build
```

Open `http://localhost:4000`. For a production-equivalent check, run:

```sh
bundle exec rake test
```

Every push and pull request is also built and checked automatically with GitHub Actions.

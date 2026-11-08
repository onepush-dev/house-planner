# House Planner on Railway — self-hosted 2D/3D house, utilities and BOM planner

[House Planner](https://github.com/egmalt/house-planner) (MIT) is a self-hosted planner for a private house: a true-scale 2D floor plan, 3D preview, satellite map overlay, sewer / electrical / water / underfloor-heating layers with calculations, and a priced bill of materials. React + PHP, no database. Deploy it on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/T__G38)

## What this template does

- Builds the **unmodified** upstream Dockerfile at commit `5c91280` (`ghcr.io/onepush-dev/house-planner:base-5c91280`) and adds a tiny wrapper (`5c91280-r1`) that loads exactly one Apache MPM (`prefork`). Without it, the upstream image crashes on Railway with `AH00534: More than one MPM loaded`.
- Generates the editor password (`HOUSE_PASSWORD`) and the setup key (`HOUSE_SETUP_KEY`) per deploy, so the install is never open to the first visitor. Public `/api/setup.php` returns 403 and the plan API returns 401 until you log in.
- Keeps plans, versions, snapshots and config on a volume at `/var/lib/house-planner`.

## After deploy

1. Open the service's **Variables** tab and copy `HOUSE_PASSWORD`.
2. Open your Railway URL and log in with that password to start editing. The read-only phone view and sharing work as upstream.

`HOUSE_PASSWORD` is applied on first boot only. To change it later, use the app's settings (changing the variable afterwards has no effect, because the install is already done).

## Service

| Service | Image | Volume | Port |
|---|---|---|---|
| `house-planner` | `ghcr.io/onepush-dev/house-planner:5c91280-r1` | `/var/lib/house-planner` | 8080 |

## Variables

| Variable | Default | Purpose |
|---|---|---|
| `HOUSE_PASSWORD` | generated (24 chars) | Editor password set on first install. |
| `HOUSE_SETUP_KEY` | generated (32 chars) | Secret key guarding the setup/installer endpoint. |

## License

House Planner is MIT-licensed by its authors. This repository only holds the build workflow and a small Apache MPM wrapper.

# Odoo Hospital Docker

A Docker-based setup for Odoo 17 Community Edition with Hospital Management module for patient management and scheduling.

## Features

- **Odoo 17 Community Edition**
- **Hospital Management Module** ([mahmodDAHOL/odoo_hospital_app](https://github.com/mahmodDAHOL/odoo_hospital_app))
- **PostgreSQL 15** database
- **Docker Compose** for easy deployment

## Quick Start

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed
- Git (optional, for cloning)

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/odoo-hospital-docker.git
   cd odoo-hospital-docker
   ```

2. Copy environment file:
   ```bash
   cp .env.example .env
   ```

3. Build and start containers:
   ```bash
   docker-compose up -d --build
   ```

4. Access Odoo at: **http://localhost:8069**

### First-time Setup

1. Create a new database:
   - Database Name: `hospital` (or your choice)
   - Email: your admin email
   - Password: your admin password
   - Language: English
   - Country: Your country

2. Install Hospital module:
   - Go to **Apps** menu
   - Click **Update Apps List** (in the Apps dropdown menu)
   - Remove the "Apps" filter in the search bar
   - Search for `hospital`
   - Install **Hospital Management**

## Module Features

The Hospital Management module includes:

- **Patient Management** - Patient records with tags, gender filters, archived patients
- **Appointment Scheduling** - Calendar views, status tracking, doctor assignments
- **Prescriptions** - State and priority management
- **Operations** - Track medical operations and procedures

## Directory Structure

```
odoo-hospital-docker/
├── addons/              # Custom addons (your modules)
├── config/
│   └── odoo.conf        # Odoo configuration
├── docker-compose.yml   # Docker services
├── Dockerfile           # Odoo image with hospital module
├── .env.example         # Environment variables template
└── README.md
```

## Useful Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f web

# Rebuild after Dockerfile changes
docker-compose up -d --build

# Rebuild from scratch (removes volumes)
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d

# Access Odoo shell
docker-compose exec web odoo shell -d hospital

# Restart Odoo
docker-compose restart web
```

## Backup

### Database Backup
```bash
docker-compose exec db pg_dump -U odoo hospital > backup.sql
```

### Database Restore
```bash
docker-compose exec -T db psql -U odoo hospital < backup.sql
```

## Troubleshooting

### "Module not found" error
1. Go to Apps → Update Apps List
2. Remove the "Apps" filter in search bar
3. Search again for `hospital`

### Database connection issues
```bash
docker-compose down
docker-compose up -d
```

### Permission issues
```bash
docker-compose exec web chown -R odoo:odoo /var/lib/odoo
```

### Clone failed during build
```bash
docker-compose build --no-cache
docker-compose up -d
```

## License

- Odoo Community: LGPL-3.0
- Hospital Module: LGPL-3.0

# Odoo Medical Docker

A Docker-based setup for Odoo 17 Community Edition with OCA Medical modules for patient management and scheduling.

## Features

- **Odoo 17 Community Edition**
- **OCA Medical Modules** (vertical-medical)
- **PostgreSQL 15** database
- **Docker Compose** for easy deployment

## Quick Start

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed
- Git (optional, for cloning)

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/odoo-medical-docker.git
   cd odoo-medical-docker
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
   - Database Name: `medical` (or your choice)
   - Email: your admin email
   - Password: your admin password
   - Language: English
   - Country: Your country

2. Install Medical modules:
   - Go to **Apps** menu
   - Click **Update Apps List** (in the top menu)
   - Search for `medical`
   - Install:
     - `medical` (core)
     - `medical_administration` (patient records)
     - `medical_appointment` (scheduling)

## Module Installation Order

For best results, install modules in this order:

1. `medical` - Core medical functionality
2. `medical_administration` - Patient and practitioner management
3. `medical_appointment` - Appointment scheduling

## Directory Structure

```
odoo-medical-docker/
├── addons/              # Custom addons (your modules)
├── config/
│   └── odoo.conf        # Odoo configuration
├── docker-compose.yml   # Docker services
├── Dockerfile           # Odoo image with OCA addons
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

# Access Odoo shell
docker-compose exec web odoo shell -d medical

# Restart Odoo
docker-compose restart web
```

## Future Expansion

When ready to expand, you can add:

| Phase | Modules |
|-------|---------|
| Phase 2 | Invoicing, `medical_clinical` |
| Phase 3 | Inventory, HR, Sales |
| Phase 4 | `medical_pharmacy`, `medical_lab` |

## Backup

### Database Backup
```bash
docker-compose exec db pg_dump -U odoo medical > backup.sql
```

### Database Restore
```bash
docker-compose exec -T db psql -U odoo medical < backup.sql
```

## Troubleshooting

### "Module not found" error
1. Go to Apps → Update Apps List
2. Search again for the module

### Database connection issues
```bash
docker-compose down
docker-compose up -d
```

### Permission issues
```bash
docker-compose exec web chown -R odoo:odoo /var/lib/odoo
```

## License

- Odoo Community: LGPL-3.0
- OCA Modules: AGPL-3.0

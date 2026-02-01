# AI Coding Agent Instructions - Odoo Hospital Docker

## Project Overview

Docker-based Odoo 17 CE with Hospital Management module for patient management and scheduling. Two-container architecture: `odoo-web` (port 8069) → `odoo-db` (PostgreSQL 15).

**Module source**: [mahmodDAHOL/odoo_hospital_app](https://github.com/mahmodDAHOL/odoo_hospital_app)

## Key Paths & Volumes

| Local Path | Container Mount | Purpose |
|------------|-----------------|---------|
| `addons/` | `/mnt/extra-addons` | Your custom modules |
| `config/odoo.conf` | `/etc/odoo/odoo.conf` | Server config |
| Dockerfile clones | `/mnt/hospital-addons/` | Hospital module (hospital, odoo_inheritance) |

## Hospital Modules

Cloned from `mahmodDAHOL/odoo_hospital_app`. **Install in order:**
1. `hospital` (main module) → 2. `odoo_inheritance` (optional extensions)

### Key Models to Extend

| Model | Purpose | Key Fields |
|-------|---------|------------|
| `hospital.patient` | Patient records | `name`, `date_of_birth`, `gender`, `tag_ids`, `appointment_count` |
| `hospital.appointment` | Scheduling | `patient_id`, `appointment_time`, `booking_date`, `state`, `doctor_id` |
| `hospital.patient.tag` | Patient tags | `name`, `color` |
| `hospital.operation` | Medical operations | `doctor_id`, `operation_name` |

**Creating records programmatically:**

```python
# Creating a patient
patient = self.env['hospital.patient'].create({
    'name': 'John Doe',
    'date_of_birth': '1990-01-15',
    'gender': 'male',
})

# Creating an appointment
appointment = self.env['hospital.appointment'].create({
    'patient_id': patient.id,
    'appointment_time': '14:30',
    'booking_date': '2024-01-20',
})
```

## Essential Commands

```bash
# First run
cp .env.example .env && docker-compose up -d --build

# Module development cycle
docker-compose restart web    # After code changes
# Then: Apps → Update Apps List → Install

# Debugging
docker-compose logs -f web                        # Live logs
docker-compose exec web odoo shell -d hospital    # Python REPL with ORM

# Database
docker-compose exec db pg_dump -U odoo hospital > backup.sql
docker-compose exec -T db psql -U odoo hospital < backup.sql

# Rebuild from scratch
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d
```

## Custom Module Pattern

Create modules in `addons/your_module/` with this structure:

```python
# __manifest__.py
{'name': 'Your Module', 'depends': ['hospital'], 'data': ['views/your_views.xml']}

# models/patient_extension.py - Inherit hospital models
from odoo import models, fields

class HospitalPatient(models.Model):
    _inherit = 'hospital.patient'
    custom_field = fields.Char('Custom Field')
```

```xml
<!-- views/your_views.xml - Extend existing views -->
<odoo>
  <record id="view_patient_form_inherit" model="ir.ui.view">
    <field name="inherit_id" ref="hospital.view_hospital_patient_form"/>
    <field name="arch" type="xml">
      <xpath expr="//field[@name='name']" position="after">
        <field name="custom_field"/>
      </xpath>
    </field>
  </record>
</odoo>
```

## Configuration Notes

- `odoo.conf` `addons_path`: Your addons load first (can override hospital module)
- `admin_passwd`: Hashed with pbkdf2-sha512 (don't store plaintext)
- DB credentials: `odoo/odoo` (override `POSTGRES_PASSWORD` in `.env`)

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Module not found | Apps → Update Apps List, remove "Apps" filter |
| Permission errors | `docker-compose exec web chown -R odoo:odoo /var/lib/odoo` |
| Container won't start | `docker-compose down && docker-compose up -d` |
| Clone failed | Rebuild: `docker-compose build --no-cache` |

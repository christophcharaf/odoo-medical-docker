FROM odoo:17.0

USER root

# Install git for cloning repositories
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# Clone Hospital Management module (Odoo 17 compatible)
# Source: https://github.com/mahmodDAHOL/odoo_hospital_app
RUN git clone --depth 1 https://github.com/mahmodDAHOL/odoo_hospital_app.git /mnt/hospital-addons

# Set proper permissions
RUN chown -R odoo:odoo /mnt/hospital-addons

USER odoo

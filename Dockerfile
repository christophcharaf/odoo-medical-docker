FROM odoo:17.0

USER root

# Install git for cloning OCA repositories
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# Clone OCA Medical addons
RUN git clone --depth 1 --branch 17.0 https://github.com/OCA/vertical-medical.git /mnt/oca-addons/vertical-medical || true

# Required dependency for medical modules
RUN git clone --depth 1 --branch 17.0 https://github.com/OCA/partner-contact.git /mnt/oca-addons/partner-contact || true

# Set proper permissions
RUN chown -R odoo:odoo /mnt/oca-addons

USER odoo

FROM biotux7/odoo-prod-base:13.0 as base


# Own libraries Odoo

RUN set -x; \
    sudo apt-get -qq update && sudo apt-get -qq install -y --no-install-recommends \
        libcairo2-dev \
        tesseract-ocr \
    && sudo apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && sudo rm -rf /var/lib/apt/lists/* /tmp/* \
    && pip3.7 --no-cache-dir install \
        httplib2==0.12.0 \
        signxml==2.6.0 \
        git+https://github.com/odoopartners/python-zeep.git#egg=zeep==4.0.1 \
        pytesseract==0.2.6 \
        git+https://github.com/odoopartners/culqi-python.git#egg=culqipy==0.2.7 \
        pycairo \
        pyfcm \
        numpy \
        numpy-financial==1.0.0 \
    && sudo apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && sudo rm -rf /var/lib/apt/lists/* /tmp/*


CMD ["odoo"]


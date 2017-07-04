#######
LDM-230
#######

============================================================
Concept of Operations for the LSST Batch Production Services
============================================================

This is a working repository for *LDM-230: Concept of Operations
for the LSST Batch Production Services*.

* Read the living document on the web: http://ldm-230.lsst.io
* Read the officially-approved document:
  https://docushare.lsstcorp.org/docushare/dsweb/ServicesLib/LDM-230/History

Working with this document
--------------------------

.. code::

   git clone git@github.com:lsst/LDM-230.git
   cd LDM-230
   pip install -r requirements.txt
   make html

The built site can be viewed by opening ``_build/html/index.html`` in
your web browser.

Whenever you push to ``master``, readthedocs.org will build and host the
document at http://ldm-230.readthedocs.org

Editing metadata
----------------

Metadata, such as document version, title, date of last edit, and
authors, are maintained in the ``metadata.yaml`` file

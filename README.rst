#######
LDM-230
#######

=======================================================
Automated Operations of the LSST Data Management System
=======================================================

This is a working repository for *LDM-230: Automated Operations of the
LSST Data Management System*.

* Read the living document on the web: https://ldm-230.lsst.io
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

Whenever you push to ``master``, LSST the Docs will build and host the
document at https://ldm-230.lsst.io

Editing metadata
----------------

Metadata, such as document version, title, date of last edit, and
authors, are maintained in the ``metadata.yaml`` file

:tocdepth: 1

.. sectnum::

.. _scope:

Scope of Document
=================

This document describes the operational concepts for the emerging LSST DPP group which will operate
the system that will be delivered by the LSST construction project. This system will be incrementally
stood up and operated by the construction project as part of validation and verification activities
within the construction project.

The concept of operations covers approximately 40 distinct services, The operations concepts
are initially developed in Google docs. It is the vision to  migrate these documents to
ReStructuredText as they mature.  Therefore, initially, we will provide pointers to documents as
the level of drafting within the working group becomes suitable to expose the documents to the
LSST construction project.

.. _overview:

Level 1 Services
================

Main Camera Data Prompt Processing Service
------------------------------------------

The prompt processing of raw data acquired from the main LSST camera by the DM system. The prompt processing service is primarily
presented to the the Observing Operations as an OCS-controllable device. 

`Main Camera Data Prompt Processing Service  <https://docs.google.com/a/illinois.edu/document/d/1hv0_ZhkPXt2xCUcMU5J94SjnEr2ZH8JK43PsqJJn_6k/edit?usp=sharing>`_

This figure illustrates a logical conception of the service.

`Logical Conception of the Main Camera Data Prompt Processing Service  <https://drive.google.com/open?id=0B4OAryR7BjSiU1BfVndSNzRRQ0U>`_



Main Camera Data Archiving Service
----------------------------------

The main camera data archive service is presented to Observing Operations as a OCS-controllable device.
The service constructs raw data files from exposures in the camera data system, and meta-data residing in OCS.
The files so constructed are ingested into the data backbone. 

`Main Camera Data Archiving Service <https://drive.google.com/open?id=1-2jV-VovfVpJO62C2PmVXSUWaXB0gFfZ4pgp6I1d3k0>`_

This figure illustrates a logical conception of the service.

`Logical Conception of the Main Camera Archiving Service  <https://docs.google.com/document/d/1ZolFLDtRbOxKhC6CMLXMRmy3zvQbiyE2kYkc_odSR6c/edit?usp=sharing>`_


Alert Distribution Service
--------------------------

The Alert Distribution service  a service which connects programs generating alert information to event brokers.

`Alert Distribution Service <https://docs.google.com/document/d/1z_j-b41BHwpfXoeRAwTVA76Uzp8Xodx3vOLFDAnVnrY/edit?usp=sharing>`_

A figure that illistrates a repesentative logical structure is here:

`Alert Distribution Figure <https://drive.google.com/open?id=0B4OAryR7BjSiWHEtYlFpX3lQM2M>`_

Auxiliary Telescope  Data Processing and Archiving
--------------------------------------------------

Telemetry Gateway
-----------------

Observatory Operations Data Services
------------------------------------

OCS-Driven Batch Services
-------------------------

EFD Replication
---------------

Commissioning Cluster Services
------------------------------

Summit Data Services
--------------------

Summit data services refer to presistent data storage at the summit site, Most likely to
satisfy use cases related to sustaining operations should the fiber be cut, or for any other
need that would emerge.

This Need is under discussion. 


Offline L1 Processing
---------------------

FIrst Order Scientific Quality Assurance
----------------------------------------

Level 1 Complete Test Environment
---------------------------------

Level 2 Services
================

This document describes the operational concept for batch production operations. Batch operations consists of executing large or small processing campaigns that use released software configured into pipelines to produce data products, such as calibrations and DRP products.

`Batch Production Services <https://docs.google.com/document/d/1MVe0qdHt5RNTN8KkIxWzd24nNbxA5ZWghajoak3i0HU/edit?usp=sharing>`_


Data Backbone Services
======================


Data Access Hosting Services
============================


Development Support Services
============================

Miscellaneous Services
======================

ITC Provisioning and Management
===============================


Service Management Processes
============================

.. _changerecord:

Change Record
=============


+-------------+------------+----------------------------------+--------------+
| **Version** | **Date**   | **Description**                  | **Owner**    |
+=============+============+==================================+==============+
| 1.0         | 5/22/2013  | Initial Version                  | Kian-Tat Lim |
+-------------+------------+----------------------------------+--------------+
| 1.1         | 10/9/2013  | Updates resulting from Process   | Kian-Tat Lim |
|             |            | Control and Data Products        |              |
|             |            | Reviews                          |              |
+-------------+------------+----------------------------------+--------------+
| 1.2         | 10/10/2013 | TCT approved                     | R Allsman    |
+-------------+------------+----------------------------------+--------------+
| 2.0         | 07/14/2016 |                                  | D Petravick  |
+-------------+------------+----------------------------------+--------------+

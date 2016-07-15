:tocdepth: 1

.. sectnum::

.. _scope:

Scope of Document
=================

This document describes the operational concept for batch production operations. Batch 
operations consists of executing large or small processing campaigns that use released
software configured into pipelines to produce data products, such as calibrations and DRP
products.

.. _overview:

Overview
========

Description (what)
------------------
...

Objective
---------

Batch operations consists of executing large or small processing campaigns that use released
software configured into pipelines to produce data products, such as calibrations and DRP
products.


Operational Context
-------------------

The Batch Production service executes **campaigns** on **computing resources** to produce
the desired **LSST data products**, which are measured against **first-level quality assurance criteria**. 

- A campaign is a set of pipelines, a set of inputs to run the pipelines against, and a method of handling the outputs of the pipelines.
- A campaign satisfies a need for data products. Campaigns produce the designated batch data products specified in the DPPD, or other authorized data products.
- Campaigns can be large, such as an annual release processing, or small, such as producing a few calibrations.

Risks
-----

   ...

Operational Concepts
--------------------

A **pipeline** is a body of code, typically maintained and originated within the Science 
Directorate.  Pipelines may produce final end data products in release processing, may
produce calibrations or other data products used internally within LSST operations, may
produce data products for investigations related to algorithm development, and may produce
data products for testing purposes that cannot be satisfied using development infrastructure.

A **campaign** is the set of all pipeline executions needed to achieve a LSST objective.
- Each campaign has one or more pipelines.
- Each pipeline possesses one or more configurations.
- Each campaign has a **coverage set**, enumerating the distinct pipeline invocations. There is a way to identify the input data needed for each invocation.
- Each campaign has an **ordering constraint** that specifies any dependencies on the order of running pipelines in a campaign.
- Each campaign has an adjustable **campaign priority** reflecting LSST priority for that objective.
- Each pipeline invocation may require one or more input **pipeline data sets**. 
- Each pipeline invocation produces one or more output **pipeline data sets**.  Notice that, for LSST, a given file may be in multiple data sets.
- For each input pipeline data set there is a **data handling scheme** for handling that data set in a way that inputs are properly retrieved from the archive and made available for pipeline use.
- For each output pipeline data set there is a **data handling scheme** for handling that data set in a way that outputs are properly archived.

The key factor in the nature of the LSST computing system is the inherent trivial paralleism in due to the nature of the computations.  This means that 
large campaigns can be divided into ensembles of smaller, independent jobs, even though some jobs may require a small number of nodes.


Batch Production services are distinct from other services that may use batch infrastructure,
such as Development Support services. Also, there are other scenarios where pipelines need
to be run outside the batch production service environment.  For example, alternate
environments include build-and-test, capable desk-side development infrastructure, and
ad-hoc running on central development infrastructure.  

From these considerations, we separate the concerns of a reliable production service from
these other use cases, which do not share the concerns of production. This also allows for
supporting infrastructure to evolve independently. Example production service concerns include:
- Supporting reliable operation of an ensemble of many campaigns, respecting priorities. 
- Dealing with the problems associated with large-scale needs.
- Dealing with the campaign documentation, presentation, curation and similar aspects of formally produced data.

**Computing Resources** are needed to carry out a campaign. Batch computing processing
occurs on LSST dedicated **computing platforms** at NCSA and CC-IN2P3, and potentially on
other platforms. Resources other than for computation (CPU and local storage), such as
curation storage to hold final data products, and network connectivity are also needed to
completely execute a pipeline and completely realize the data handling scheme for input
and output data sets.   

Computing Resources are physical items which are not always fit for use. They have
scheduled and unscheduled downtimes, and may have scheduled availability.  The
management of campaigns requires:
1. the detection of unscheduled downtimes of resources
2. recovery of executing pipelines affected by unscheduled downtimes, and 
3. best use of available resources. 


The types of computing platforms that may be available, with notes, are as follows.

+--------------------------+-------------------------------------------------+
| **Platform Type**        | **Notes**                                       |
+==========================+=================================================+
| NCSA batch production    | Ethernet cluster with compentent cluster        |
| computing system         | file system.                                    |
+--------------------------+-------------------------------------------------+
| NCSA L1 computing for    | Shared nothing machines, avaiable when not      |
| prompt processing        | needed for observing operations.                |
+--------------------------+-------------------------------------------------+
| NCSA L3 computing        | TBD                                             |
+--------------------------+-------------------------------------------------+
| CC-IN2P3 bulk computing  | Institutional experience is shared nothing      |
|                          | machines plus competent caches and large        |
|                          | volume storage.                                 |
+--------------------------+-------------------------------------------------+

An **Orchestration System** is a system that supports the execution of a pipeline instance. The basic functionality is as follows:

- Pre-job context:
    - Supports pre-handling of any input pipeline data sets when in-job context for input data is not required.
        - Pre-stages into a platform's cluster file system, if available
        - Produces condensed versions of database tables into portable lightweight format (e.g. mysql->sqlLite, flat table etc.)
    - Deals with TBD platform-specific edge services.
    - Identities and provides for local identity on the computing platforms.
    - Provides credentials and end-point informtion for any needed LSST services.
- In-job context:
    - Provides stage-in for any in-job pipeline input data sets
    - Provides any butler configurations necessarily provided from in-job context.
    - Invokes the pipeline and collects pipeline output status and other operational data
    - Provides any “pilot job” functionality.
    - Provides stage-out for pipeline output data sets when stage-out requires job context.
- Post-job context:
    - Ingests any designated data into database tables.
    - Arranges for any post-job stage out from cluster file systems
    - Arranges for detailed ingest into custodial data systems
    - Transmits job status to workload management, defined below.


**Workload Management**:

- Considers the ensemble of available compute resources and the ensemble of campaigns.
- Dispatches pipeline invocations to an Orchestration System based on resource availability and considering priority of campaigns.
- Considers pipeline failures reported by the Orchestration System.

 - Identifies errors indicative of a problem with computing resources, and arranges for incident report.

 - Identifies some computational errors, and arranges for incident report.

 - Retries failed pipeline invocations, if appropriate.

- Exposes progress of the campaign to relevant entities.
- Provides appropriate logging and events (n.b. critical events can be programmed to initiate an incident).


**Quality support**:

Operations are supported by the following concepts, defined as follows for this document.

- Quality Assurance (QA) is what people do. This is identifying the issue and arranging for fixes. One source of input is quality controls, described below. Another source of input are the operational and scientific data products. 
- A Quality Control (QC) is a software artifact that produces some sort of data that contains measure of quality. This data artifact may be

 - Simply produced, recorded and not used, because it seems useful for some future, likely retrospective purpose.
 - Displayed or presented for quality analysis.
 - Fed as input into active quality control which is software that automatically affects the execution of a campaign.
 - Fed into software that computes additional downstream quality control data.

.. _normal-operations:

Normal Operations
=================
During normal operations, the Batch Production service will conduct a number of concurrent
**campaigns** that support LSST goals. These campaigns will be drawn from 

- Runs to validate Data Release Processing, 
- Data Release Processing itself.
- After-burner processing (to correct specific errors in not-yet-released data products).
- Calibration processing.
- Miscellaneous processing.

While Batch Production services will use the majority of LSST batch capability, Batch
Production services will share the LSST batch infrastructure with certain Level 1 services that
require offline processing, and with Level 3 batch awardees. Resource conflicts are sorted out
and expressed as **priorities** for each respective campaign.

The workload management system is programmed to deal with anticipated errors. Human eye is applied during working hours (but can be summoned when events in the underlying systems generate incidents). 

Each campaign is monitored for technical progress -- both in in the sense of analyzing and responding to overtly flagged errors, and general monitoring and human assessment of the overall performance of the service. 

First Order Quality Assurance is as follows:
1. Quality controls are considered by a DPP Scientist and other staff. These people apply any standard authorized mitigations, such as reprocessing, flagging anomalies, etc. The First Order Quality Assurance group understands the full suite of quality controls, and alerts the Science Operations group to anomalies and collaborates in diagnosis and mitigation of problems, as requested.
2. The service provided by the First Order Quality Assurance group uses its operational and scientific acumen to assess the data products at a first level, in addition to monitoring the extant quality controls. Particular attention is paid to
- operationally critical data (e.g., next night’s flats needed for L1 processing)
- a processing campaign that is resource intensive, hence expensive to redo (or has expensive consequences)
- known problematic output data sets that are not adequately covered by existing quality controls.
- known problematic input data sets not adequately covered by existing quality controls.

Close collaboration is maintained between first order quality assurance and the broader scientific quality assurance in the project. Information obtained from first order quality assurance is continuously fed back to Science Operations. 

Campaign closeout provides that all outputs are in final form, documentation and other artifacts have been produced, and all parties are actively notified about the status of a campaign.

Operational Scenarios
=====================


Initiate campaign:
------------------
Campaigns are initiated in response to an LSST objective, by specifying an initial set 
of pipelines, a coverage set, and an initial priority. The Batch Production service is consulted 
with a reasonable lead time. Consistent with LSST processes, pipelines can modified or
added (for example in the case of after-burners) during a campaign. These changes and
additions are admitted when the criteria of change control processes are satisfied, including 
- relevant build-and test criteria
- the impact of resource-intensive campaigns is approved and understood.
- production-scale test campaigns

Terminate failed campaign:
--------------------------
Reasons for a campaign failure will be documented and submitted to Science Operations for
review. The deletion of data products needs to be scheduled so that it occurs after the
review has completed. This includes backing out files, materials from databases, and other
production artifacts from the Data Backbone, and maintaining production records as these activities occur.


Deal with problematic campaign:
-------------------------------
LSST is a large system. Pipelines will evolve and be maintained.  There will be the 
campaigns, described in the operations documents. It is the nature of the system that as
issues emerge extra resources will be needed to provide focused scrutiny on aspects of
production for some pipeline.  In many cases problems will be resolved by bug fixes, or
addressed by quality controls and changes to processes.  **Any system needs to support 
mustering focused effort on quality analysis that is urgent, and lacks an adequate
basis for robust quality controls.**  The Batch Production services staff contribute effort
to solve these problems, in collaboration with the Science Operations group (or other
party responsible for codes)


Deal with sudden lack (or surplus) in resources:
------------------------------------------------

As noted above, for large scale computing, the amount of resource available to support all
campaigns will vary due to scheduled and unscheduled outages.  
The technical system responds to an increase or decrease in resources by running more or
few jobs, once the workload manager is aware of the new level of resources. The technical
system responds to hardware failures on a running job in just like any other system -- with the
ultimate recovery being to  delete an partial data and retry, while respecting the priorities of
the respective campaigns. 



.. _support-environment:

Support Environment
===================


Service Delivery
----------------

In general, aspects of the services related to data release production do not require continuous availability as much as adequate throughput averaged over time.  However calibrations and and item related to telescope operations have TBD cadences, and may require that production be done on a more rigid cadence.

In the (likely) scenario, where computing is augmented yearly, There at TBD issues related to non uniform operating system, and related compatibility matters.  
There TBD issue about reproducing data using virtual techniques.


Service Transition
------------------

Special concern here are concern a  calendar of Business goals LSST has for the delivery of data products from the ensemble it’s of processing campaigns.  This suggest that multiple instances of workload management may need to exist to support incompatibilities within the workload management technical system. An example complication that should be considered the need to commission an incompatible upgrade to the workload management system while a lengthy campaign is underway  in the context of the current instance of of the workload management system.

Glossary
========
     *Definition of all key terms and acronyms used within the ConOps.*

References
==========
    *Self-explanatory.*

.. _change-record:

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

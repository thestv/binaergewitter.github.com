---
layout: post
title: "Binaergewitter #1 - NoSQL"
date: 2011-01-09 09:17
comments: true
categories: 
audio: http://archiv.radiotux.de/sendungen/binaergewitter/2011-01-08.RadioTux.Binaergewitter.NoSQL.mp3
---

Die erste Ausgabe unseres Formats beschäftigt sich mit Datenbanken und NoSQL. Diese neuen Datenbanken waren im Jahr 2010 schon Hype und werden uns sicher auch im Jahr 2011 stark begleiten. Warum soll man aber diese Datenbanken einsetzen? Welche gibt es und welche Stärken und Schwächen haben diese? Das versuchen Dirk, Marc, Sven und Ingo in 2,75 Stunden zu klären.

## Shownotes / Timeline und Links

* Vorstellung der Teilnehmer / Kurze Erklärung von NoSQL
 - Marc: Masterthesis: building blocks of a scalable webcrawler
* Grundlegende Einsatzgebiete von Datenbanken
 1. Persistenz von (Anwendungs)daten
  - Unterschied/Gemeinsamkeit Dateisystem -  Datenbank
  - Datensicherheit – WP: ACID
  - Verteilung
 2. Suchen
  - Via Indexierung (B+Tree)
  - Volltextsuche
 3. Navigation über Daten (Joins)
 4. Reporting
* Grundlegende Klärung der Bezeichnung NoSQL
* Grenzen von DBs (CAP-Theorem)
* Unterschiede SQL/NoSQL
 - Grober Unterschied
 - Zeilen/Spalten vs. Key-Value, Column-Stores, Dokumente, Graphen
 - JSON
 - Resource Description Framework
 - Sendung über GraphDB
* Patterns bei der Implementierung
* Datenbanksysteme
 1. Vor- und Nachteile (Datenschema, Zugriff)
  - Column Store: Cassandra
  - Column Store: HBase (BigTable)
  - Datastructure Store: Redis
   * Redis: under the hood
   * Redis, from the Ground Up
  - DocumentStore: MongoDB
   * BSON
   * GridFS
  - DocumentStore/KV Store: CouchDB
   * Futon + CouchApps
   * _changes feed + Lucene/ElasticSearch
  - Key Value Store: MemcachedDB
  - Key Value Store: Riak
   * RiakSearch API ist kompatibel zu: Apache Solr/Lucene
  - Graph Database: Neo4J / GraphDB
 2. Einsatzgebiete
  - kkovacs.eu Vergleich der NoSQL Datenbanken
  - readwriteweb.com NoSQL bei Twitter
 3. Polyglot Persistence

# Enterprise Magento 2.4 Infrastructure & Performance Stack

This repository documents the production-ready infrastructure blueprint and atomic architecture deployment frameworks executed for the MGT-Commerce Technical Assessment. The complete target stack is provisioned, hardened, and performance-tuned over a dedicated AWS compute baseline.

## 🛠️ Infrastructure Core Specifications

* **Host Engine Kernel:** Debian 12 (AWS EC2 Compute Boundary Node)
* **Static Routing Gateway:** Dedicated AWS Elastic IP (`3.77.161.114`)
* **Edge Proxy HTTP Accelerator:** Varnish Cache 7.1 (Listening on Port 81)
* **Web Entry Server Process:** NGINX 1.22.1 (SSL Termination on Port 443 -> Proxy Backend on Port 8080)
* **Runtime Processor:** PHP 8.3 FPM (Isolated UNIX Socket Pool Layer)
* **Relational Database Cluster:** MySQL 8.0.36 Community Server
* **Search & Indexing Engine:** Elasticsearch 8.19.17 Core Daemon
* **In-Memory Volatile Storage:** Redis Server (Decoupled Split Cache & Session Handling Slots)

## 📚 Technical Documentation & References Deployed

To guarantee absolute architectural compliance with enterprise standards and official support matrix loops, the following upstream documentation blueprints were referenced during the task implementations:

* **MySQL 8.0 Core Installation Pipeline:** Deployed community packages utilizing validated architecture steps via [Devart MySQL Deployment Guide](https://www.devart.com/dbforge/mysql/install-mysql-on-debian/).
* **PHP 8.3 Advanced FastCGI Process Manager Stack:** Bootstrapped and locked repository runtimes securely via [PHP.Watch 8.3 Release Architecture](https://php.watch/articles/php-8.3-install-upgrade-on-debian-ubuntu).
* **Redis Server High-Performance Memory Decoupling Cluster:** Orchestrated split-instance configuration structures via [Redis Official Archive Linux Installation Operations](https://redis.io/docs/latest/operate/oss_and_stack/install/archive/install-redis/install-redis-on-linux/).
* **Magento 2.4 Enterprise Source Code Provisioning:** Managed package dependencies via Composer injection using the formal [Adobe Commerce Installation Operations Guide](https://experienceleague.adobe.com/en/docs/commerce-operations/installation-guide/composer).
* **Varnish 7.x Edge Proxy Cache Engine Configuration:** Implemented high-efficiency VCL routing pipelines via [Reintech Debian 12 Varnish Caching Architecture](https://reintech.io/blog/configuring-caching-varnish-debian-12).

## 🗂️ Repository Directory Blueprint

* `/nginx` — Advanced server blocks for virtual host mapping, fastcgi parameter buffers, and SSL termination.
* `/varnish` — High-efficiency Varnish VCL structures routing cache lookups and managing backend health loops.
* `/php` — Custom PHP-FPM worker pool properties enforcing absolute permission separation rules.
* `/documentation` — Deep-dive architectural troubleshooting and operational incident containment protocols.

## 🚀 Post-Deployment System Verification & Operations Routine

Whenever the infrastructure node restarts from an absolute freeze state, execute the following operational sequence to audit and confirm structural alignment metrics across all server clusters:

### 1. Establish Remote Shell & Elevate Context

```bash
ssh -i frankfurt-eu-central-1.pem admin@3.77.161.114
sudo su -

### 2. Comprehensive Service Health Audit

```bash
systemctl status nginx php8.3-fpm mysql redis-server elasticsearch varnish --no-pager

### 3. Bulk Service Kickstart Protocol

```bash
systemctl start nginx php8.3-fpm mysql redis-server elasticsearch varnish

### 4. Rebuild Magento Indices & Purge Caching Pipelines

```bash
/usr/bin/php8.3 /var/www/html/magento/bin/magento indexer:reindex
/usr/bin/php8.3 /var/www/html/magento/bin/magento cache:flush

### 5. Local Network Edge Verification Testing

# Verify isolated phpMyAdmin local loopback
curl -I [http://pma.mgt.com](http://pma.mgt.com)

# Verify core active Varnish cache responses
curl -I [http://test.mgt.com](http://test.mgt.com)

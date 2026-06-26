# INFRASTRUCTURE DEPLOYMENT & TROUBLESHOOTING REPORT

**Candidate:** Gokula Kannan  
**Role Target:** Linux System Administrator  
**Deployment Environment:** AWS EC2 (Debian 12)  
**Static Public Target IP:** `3.77.161.114`  

---

## 1. CORE ARCHITECTURE SETUP & HARDENING
The entire application infrastructure stack was provisioned, structured, and completely isolated following industry-standard production blueprints:

* **Compute & Routing Continuity:** Provisioned compute boundaries and mapped network traffic onto a dedicated, permanent AWS Elastic IP (`3.77.161.114`).
* **Strict Permission & User Isolation:** Created a restricted system user `test-ssh` bound under the primary security group `clp` to recursively handle the Magento filesystem securely and eliminate root usage anomalies.
* **Production-Aligned Stack:** Manually bootstrapped and locked the environment to **NGINX 1.22.1**, **MySQL 8.0.36 Community Server**, and independent fast CGI processes managed via **PHP 8.3**.

---

## 2. HIGH-PERFORMANCE CACHING & PORTS ROUTING MATRIX
To handle intense traffic loads and optimize server response latency, a decoupled multi-tier reverse proxy network matrix was successfully deployed:

* **Varnish Edge Cache Integration:** Configured Varnish Cache to serve edge requests on Port 81 (aliased for Port 80 web hooks) with an optimized 1GB memory profile.
* **Redis Caching Tier:** Implemented an in-memory Redis split-cluster database layer to completely offload intensive user session and cache storage lookups from the raw storage disk.
* **Redirection Pipeline Layout:**
  $$\text{Client (Port 443 / SSL Target)} \longrightarrow \text{NGINX Termination} \longrightarrow \text{Varnish Cache (Port 81)} \longrightarrow \text{Backend NGINX (Port 8080)} \longrightarrow \text{PHP 8.3 Socket Pool}$$

---

## 3. INFRASTRUCTURE CRITICAL TROUBLESHOOTING RESOLUTIONS
During deployment orchestration, several advanced architectural challenges were intercepted and resolved systematically:

* **PHP CLI Binary Drift (Fixed):** Resolved automated setup script compiler anomalies and runtime binary mismatches by explicitly routing and wrapping all Magento CLI routines directly via the path `/usr/bin/php8.3`.
* **Nginx Configuration Purging (Fixed):** Purged duplicate block execution crashes by sanitizing background editor temporary auto-save metadata footprints (`*.save`) out of the server runtime environment.
* **Canonical Infinite Redirection Loops (Fixed):** Intercepted and cleared `ERR_TOO_MANY_REDIRECTS` traps between NGINX SSL blocks and the Varnish termination engine by enforcing systematic canonical transitions mapping internal `core_config_data` URL parameters onto strict `https://` schemas.
* **Elasticsearch 8.x Secure Certificate Overrides (Fixed):** Resolved connection drop states (`Empty reply from server`) caused by Magento expecting unencrypted payloads while Elasticsearch 8.x implicitly enforces default internal TLS. Disabled structural security flags globally in `elasticsearch.yml` for local network loops, successfully completing automated full-catalog sync index routines.

---

## 4. SYSTEM PRODUCTION LIVE VERIFICATION METRICS

### A. Varnish Cache Hit Output Header

Executing live network edge connection calls yields successful atomic full-page cache lookups:

```http
HTTP/1.1 200 OK
Server: nginx/1.22.1
X-Varnish: 5
Via: 1.1 varnish (Varnish/7.1)

### B.Isolated PHPMyAdmin Domain Verification Check

Local loopback hooks running over custom domain abstractions validate successful context containment
#### curl -I [http://pma.mgt.com](http://pma.mgt.com)
HTTP/1.1 200 OK
Server: nginx/1.22.1
Set-Cookie: phpMyAdmin=9gmlsvsin...; path=/; HttpOnly; SameSite-Strict

### C. Elasticsearch Cluster Operational Blueprint Metrics

{
  "name" : "ip-172-31-47-74",
  "cluster_name" : "elasticsearch",
  "version" : {
    "number" : "8.19.17",
    "lucene_version" : "9.12.2"
  },
  "tagline" : "You Know, for Search"
}


## 5. SECURE ENDPOINT ACCESS CREDENTIALS

Magento 2 Storefront Domain Base: https://test.mgt.com/ (Configured local mapping to server IP 3.77.161.114)

Magento Admin Portal Endpoint: https://test.mgt.com/index.php/admin

Isolated phpMyAdmin Domain URL: http://pma.mgt.com

Infrastructure SSH System Access Username: admin (Bound via private security key pair)

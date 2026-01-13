# CLI System Monitor (Linux)

A small collection of standalone CLI tools for monitoring **system resource pressure** on Linux.

This project focuses on **decision-oriented monitoring** — extracting meaningful signals from the OS and encoding clear OK / WARNING outcomes suitable for automation.

---

## Repository Structure

cli-system-monitor/
├── disk_management.sh
├── memory_management.sh
├── process_monitor.sh
└── logs/
├── disk_management.log
└── processes.log


Each script is independent and designed to be executed individually.

---

## Tools

### 1. `process_monitor.sh`
Informational snapshot of process-level CPU activity.

**Purpose**
- Reports total number of running processes
- Displays top CPU-consuming processes
- Appends results to a log file

**Design note**
This script is intentionally **non-alerting**.  
It provides visibility rather than automated decisions.

**Log**
- `logs/processes.log`

---

### 2. `disk_management.sh`
Threshold-based disk pressure monitor.

**Purpose**
- Evaluates filesystem usage using `df`
- Compares usage against a configurable threshold
- Emits explicit OK / WARNING states
- Returns automation-safe exit codes

**Configuration**
```bash
THRESHOLD=25 ./disk_management.sh
```
---

### 3. `memory_management.sh`
Threshold-based memory pressure monitor using kernel data.

**Purpose**
- Reads memory statistics directly from `/proc/meminfo`
- Uses `MemAvailable` (not `MemFree`) to assess real memory pressure
- Computes available memory as a percentage
- Emits explicit OK / WARNING states
- Returns automation-safe exit codes

**Why `MemAvailable`**
Linux aggressively uses memory for caching.  
Low free memory does not necessarily indicate pressure.

`MemAvailable` represents the amount of memory that can be allocated
without swapping, making it the correct signal for monitoring.

**Configuration**
```bash
MEM_THRESHOLD=20 ./memory_management.sh
```
#!/bin/bash

# Thresholds, in %
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
LOG_FILE="/var/log/system_health.log"

# Function to check CPU usage
check_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( ${cpu_usage%.*} > CPU_THRESHOLD )); then
        echo "$(date): High CPU usage detected: ${cpu_usage}%." | tee -a "$LOG_FILE"
    fi
}

# Function to check memory usage
check_memory_usage() {
    memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( ${memory_usage%.*} > MEMORY_THRESHOLD )); then
        echo "$(date): High memory usage detected: ${memory_usage}%." | tee -a "$LOG_FILE"
    fi
}

# Function to check disk space usage
check_disk_usage() {
    disk_usage=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
    if (( disk_usage > DISK_THRESHOLD )); then
        echo "$(date): High disk usage detected: ${disk_usage}%." | tee -a "$LOG_FILE"
    fi
}

# Function to check the number of running processes
check_running_processes() {
    max_processes=300
    process_count=$(ps aux | wc -l)
    if (( process_count > max_processes )); then
        echo "$(date): High number of running processes detected: ${process_count} processes." | tee -a "$LOG_FILE"
    fi
}

# Main monitoring function
monitor_system() {
    echo "Starting system health check..."
    check_cpu_usage
    check_memory_usage
    check_disk_usage
    check_running_processes
    echo "System health check completed."
}

# Monitoring function
monitor_system

#!/bin/bash

# System Maintenance Suite
# A comprehensive bash scripting suite for system maintenance tasks
# Author: System Administrator
# Version: 1.0

# Global variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/logs"
BACKUP_DIR="$SCRIPT_DIR/backups"
CONFIG_DIR="$SCRIPT_DIR/config"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create necessary directories
mkdir -p "$LOG_DIR" "$BACKUP_DIR" "$CONFIG_DIR"

# Logging function
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" >> "$LOG_DIR/maintenance.log"
}

# Error handling function
handle_error() {
    local exit_code=$1
    local error_message="$2"
    echo -e "${RED}Error: $error_message${NC}" >&2
    log_message "ERROR" "$error_message"
    exit $exit_code
}

# Success message function
success_message() {
    local message="$1"
    echo -e "${GREEN}Success: $message${NC}"
    log_message "SUCCESS" "$message"
}

# Warning message function
warning_message() {
    local message="$1"
    echo -e "${YELLOW}Warning: $message${NC}"
    log_message "WARNING" "$message"
}

# Info message function
info_message() {
    local message="$1"
    echo -e "${BLUE}Info: $message${NC}"
    log_message "INFO" "$message"
}

# Check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        handle_error 1 "This script must be run as root"
    fi
}

# Main menu function
show_menu() {
    clear
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}    System Maintenance Suite v1.0    ${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}1.${NC} Automated System Backup"
    echo -e "${GREEN}2.${NC} System Updates and Cleanup"
    echo -e "${GREEN}3.${NC} Log Monitoring and Alerts"
    echo -e "${GREEN}4.${NC} Run All Maintenance Tasks"
    echo -e "${GREEN}5.${NC} View System Status"
    echo -e "${GREEN}6.${NC} Configuration Management"
    echo -e "${GREEN}7.${NC} View Logs"
    echo -e "${GREEN}8.${NC} Exit"
    echo -e "${BLUE}========================================${NC}"
    echo -n "Please select an option (1-8): "
}

# Load configuration
load_config() {
    if [[ -f "$CONFIG_DIR/maintenance.conf" ]]; then
        source "$CONFIG_DIR/maintenance.conf"
    else
        # Default configuration
        export BACKUP_RETENTION_DAYS=7
        export UPDATE_AUTO_REBOOT=false
        export LOG_MONITOR_INTERVAL=300
        export ALERT_EMAIL=""
        export BACKUP_LOCATIONS="/etc /home /var/log"
        export EXCLUDE_PATTERNS="*.tmp *.cache *.log"
    fi
}

# Main execution
main() {
    # Load configuration
    load_config
    
    # Check if running with sufficient privileges
    if [[ $EUID -ne 0 ]]; then
        warning_message "Running without root privileges. Some features may not work correctly."
    fi
    
    while true; do
        show_menu
        read choice
        
        case $choice in
            1)
                bash "$SCRIPT_DIR/scripts/backup.sh"
                ;;
            2)
                bash "$SCRIPT_DIR/scripts/updates.sh"
                ;;
            3)
                bash "$SCRIPT_DIR/scripts/log_monitor.sh"
                ;;
            4)
                info_message "Running all maintenance tasks..."
                bash "$SCRIPT_DIR/scripts/backup.sh"
                bash "$SCRIPT_DIR/scripts/updates.sh"
                bash "$SCRIPT_DIR/scripts/log_monitor.sh"
                ;;
            5)
                bash "$SCRIPT_DIR/scripts/system_status.sh"
                ;;
            6)
                bash "$SCRIPT_DIR/scripts/config_manager.sh"
                ;;
            7)
                bash "$SCRIPT_DIR/scripts/view_logs.sh"
                ;;
            8)
                info_message "Exiting System Maintenance Suite. Goodbye!"
                exit 0
                ;;
            *)
                warning_message "Invalid option. Please select 1-8."
                sleep 2
                ;;
        esac
        
        echo -e "\n${YELLOW}Press Enter to continue...${NC}"
        read
    done
}

# Run main function
main "$@"
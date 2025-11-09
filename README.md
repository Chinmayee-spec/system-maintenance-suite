# System Maintenance Suite

A comprehensive collection of system maintenance scripts for both Linux and Windows environments. This suite provides automated tools for system monitoring, backup management, log rotation, software updates, and configuration management.

## Features

### Core Modules
- **System Status Monitoring** (`system_status.sh`/`ps1`) - Real-time system health checks
- **Backup Management** (`backup.sh`/`ps1`) - Automated backup creation and restoration
- **Log Management** (`view_logs.sh`/`ps1`) - Log viewing, rotation, and cleanup
- **Software Updates** (`updates.sh`/`ps1`) - System package updates and maintenance
- **Configuration Management** (`config_manager.sh`/`ps1`) - System configuration handling
- **Log Monitoring** (`log_monitor.sh`/`ps1`) - Real-time log monitoring and alerting

### Cross-Platform Support
- **Linux**: Full bash script support with systemd integration
- **Windows**: PowerShell scripts with Windows Event Log integration

## Installation

### Linux
```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/system-maintenance-suite.git
cd system-maintenance-suite

# Make scripts executable
chmod +x scripts/*.sh
chmod +x system_maintenance_suite.sh

# Run the main suite
./system_maintenance_suite.sh
```

### Windows
```powershell
# Clone the repository
git clone https://github.com/YOUR_USERNAME/system-maintenance-suite.git
cd system-maintenance-suite

# Run the PowerShell test suite
powershell -ExecutionPolicy Bypass -File test_suite.ps1
```

## Usage

### Main Suite
The main script provides an interactive menu system:
```bash
./system_maintenance_suite.sh
```

### Individual Scripts
Each module can be run independently:
```bash
# Linux
./scripts/system_status.sh
./scripts/backup.sh --type full
./scripts/view_logs.sh --action rotate

# Windows
powershell -File scripts/system_status.ps1
powershell -File scripts/backup.ps1 -Type full
powershell -File scripts/view_logs.ps1 -Action rotate
```

## Testing

### Run All Tests
```bash
# Linux
cd tests
./test_runner.sh

# Windows
powershell -ExecutionPolicy Bypass -File test_suite.ps1
```

### Individual Tests
```bash
# Linux
cd tests
./test_backup.sh
./test_updates.sh

# Windows
powershell -ExecutionPolicy Bypass -File test_backup.ps1
powershell -ExecutionPolicy Bypass -File test_updates.ps1
```

## Configuration

The suite uses configuration files for customization:
- `config/system_config.conf` - Main configuration
- `config/backup.conf` - Backup settings
- `config/logging.conf` - Log management settings

## Directory Structure
```
system-maintenance-suite/
├── scripts/                 # Core script modules
│   ├── backup.sh/ps1
│   ├── config_manager.sh/ps1
│   ├── log_monitor.sh/ps1
│   ├── system_status.sh/ps1
│   ├── updates.sh/ps1
│   └── view_logs.sh/ps1
├── system_maintenance_suite.sh  # Main suite script
├── tests/                   # Test scripts
│   ├── test_*.sh           # Bash tests
│   └── test_*.ps1          # PowerShell tests
├── config/                  # Configuration files
├── logs/                    # Log files
└── backups/                 # Backup storage
```

## Error Handling

All scripts include comprehensive error handling:
- Proper exit codes for automation
- Detailed logging for troubleshooting
- Graceful failure recovery
- Warning and error notifications

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues and feature requests, please use the [GitHub Issues](https://github.com/YOUR_USERNAME/system-maintenance-suite/issues) page.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and updates.
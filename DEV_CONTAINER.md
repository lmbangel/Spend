# 🐳 Dev Container Setup Guide

This project includes a complete development environment using VS Code Dev Containers. This means you don't need to install anything on your local machine - everything runs inside Docker containers!

## 🚀 Quick Start with Dev Container

### Prerequisites
- **VS Code** with the **Dev Containers extension** installed
- **Docker Desktop** or **Docker Engine** running

### Steps to Start

1. **Open the project in VS Code**
   ```bash
   code .
   ```

2. **Open in Dev Container**
   - When VS Code opens the project, you'll see a notification: "Reopen in Container"
   - Click **"Reopen in Container"** or press `Ctrl+Shift+P` and run "Dev Containers: Reopen in Container"

3. **Wait for setup**
   - VS Code will build the dev container (this may take 5-10 minutes on first run)
   - The container includes all necessary tools: Node.js 18, Go 1.21, Docker-in-Docker, Git, etc.

4. **Automatic setup**
   - The container will automatically run `make setup` and `make dev`
   - All services will start automatically

## 🎯 What's Included in the Dev Container

### 🛠️ Development Tools
- **Node.js 18** - For SvelteKit frontend
- **Go 1.21** - For backend development
- **Docker-in-Docker** - For running additional containers
- **Git** - Version control
- **Make** - Build automation
- **MySQL Client** - Database management
- **Air** - Go hot reloading
- **Prettier & ESLint** - Code formatting and linting

### 📦 VS Code Extensions (Auto-installed)
- **Svelte for VS Code** - SvelteKit support
- **Go** - Go language support
- **TypeScript** - TypeScript support
- **Docker** - Docker integration
- **ESLint & Prettier** - Code quality
- **Git Graph** - Git visualization
- **GitHub** - GitHub integration
- **YAML** - Configuration files
- **Todo Highlight** - Task management
- **Material Icon Theme** - File icons

### 🌐 Port Forwarding
- **3000** - Frontend (SvelteKit) - Auto-opens in browser
- **8000** - Backend (Golang API)
- **3306** - Database (MySQL)
- **80** - Nginx Proxy

## 🔧 Development Workflow

### Inside the Dev Container

1. **Check status**
   ```bash
   make health
   ```

2. **View project structure**
   ```bash
   make tree
   ```

3. **Start development**
   ```bash
   make dev
   ```

4. **View logs**
   ```bash
   make logs
   # or specific service logs
   make logs-frontend
   make logs-backend
   ```

5. **Database operations**
   ```bash
   make db-connect    # Connect to MySQL
   make db-reset      # Reset database
   make db-backup     # Create backup
   ```

### Frontend Development
```bash
cd frontend
npm run dev          # Start SvelteKit dev server
npm run build        # Build for production
npm run preview      # Preview production build
```

### Backend Development
```bash
cd backend
go run main.go       # Run backend server
air                  # Run with hot reloading
go test ./...        # Run tests
```

## 🎨 VS Code Features

### Integrated Terminal
- Multiple terminals available
- All commands run inside the container
- No need to install anything locally

### IntelliSense
- Full TypeScript support for SvelteKit
- Go language server for backend
- Auto-completion and error checking

### Debugging
- Debug SvelteKit frontend
- Debug Go backend
- Breakpoints and step-through debugging

### Git Integration
- Full Git support inside container
- Commit, push, pull operations
- Git Graph visualization

## 🔍 Troubleshooting

### Container Build Issues
```bash
# Rebuild the dev container
Ctrl+Shift+P -> "Dev Containers: Rebuild Container"
```

### Service Issues
```bash
# Check service health
make health

# Restart services
make restart

# View logs
make logs
```

### Port Conflicts
```bash
# Check used ports
make ports

# Stop all services
make down
```

### Database Issues
```bash
# Reset database
make db-reset

# Check database connection
make db-connect
```

## 🚀 Benefits of Dev Container

### ✅ **No Local Installation**
- No need to install Node.js, Go, or any other tools
- No version conflicts
- Clean development environment

### ✅ **Consistent Environment**
- Same environment for all developers
- Works on Windows, macOS, and Linux
- No "works on my machine" issues

### ✅ **Isolated Development**
- No impact on your local system
- Easy to reset and rebuild
- Multiple projects with different requirements

### ✅ **Production-like Environment**
- Docker-based development
- Same containerization as production
- Easy deployment testing

## 📋 Useful Commands Inside Container

```bash
# Development
make dev              # Start all services
make build            # Build containers
make restart          # Restart services
make down             # Stop services

# Monitoring
make health           # Check service health
make logs             # View all logs
make status           # Container status
make tree             # Project structure

# Database
make db-connect       # Connect to MySQL
make db-reset         # Reset database
make db-backup        # Create backup

# Maintenance
make clean            # Clean up resources
make prune            # Remove unused Docker resources
```

## 🎉 Getting Started

1. **Open VS Code** with the project
2. **Click "Reopen in Container"**
3. **Wait for setup to complete**
4. **Access the application:**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - Health check: http://localhost:8000/health

The dev container provides a complete, isolated development environment where you can build, test, and run your expense tracking app without installing anything on your local machine!




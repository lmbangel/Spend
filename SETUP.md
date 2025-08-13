# 🚀 Quick Setup Guide

## Prerequisites

Before starting, make sure you have the following installed:

- **Docker** and **Docker Compose**
- **Git** (for version control)
- **Node.js** (optional, for local development)
- **Go** (optional, for local development)

## 🏗️ Project Structure

```
expense-tracker/
├── frontend/          # SvelteKit PWA
├── backend/           # Golang Azure Functions
├── database/          # MySQL schema and migrations
├── nginx/            # Reverse proxy configuration
├── scripts/          # Development scripts
└── docker-compose.yml # Container orchestration
```

## ⚡ Quick Start

### Option 1: Using Makefile (Recommended)

```bash
# Clone the repository (if not already done)
git clone <your-repo-url>
cd expense-tracker

# See all available commands
make help

# Quick setup and start development (one command)
make quick-dev

# Or step by step:
make setup      # Initial setup (copy env, install deps)
make dev        # Start development environment
```

### Option 2: Manual Setup

```bash
# Clone the repository (if not already done)
git clone <your-repo-url>
cd expense-tracker

# Copy environment template
cp env.example .env

# Edit .env file with your API keys
nano .env
```

### 2. Configure Environment Variables

Edit the `.env` file and add your API keys:

```bash
# Mistral AI OCR
MISTRAL_API_KEY=your_mistral_api_key_here

# Google OAuth
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret

# Azure (for production)
AZURE_STORAGE_CONNECTION_STRING=your_azure_storage_connection_string
AZURE_FUNCTIONS_KEY=your_azure_functions_key
```

### 3. Start Development Environment

```bash
# Option 1: Using Makefile (Recommended)
make dev

# Option 2: Use the development script
./scripts/dev.sh

# Option 3: Manual Docker Compose
docker-compose up --build -d
```

### 4. Access the Application

Once all services are running:

- **Frontend (SvelteKit)**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **Nginx Proxy**: http://localhost:80
- **Database**: localhost:3306

## 🔧 Development Workflow

### Using Makefile Commands (Recommended)

```bash
# View project structure
make tree

# Check service health
make health

# View specific service logs
make logs-frontend
make logs-backend
make logs-db

# Restart services
make restart

# Clean up resources
make clean
```

### Frontend Development (SvelteKit)

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies (if needed)
npm install

# Start development server
npm run dev

# Build for production
npm run build
```

### Backend Development (Golang)

```bash
# Navigate to backend directory
cd backend

# Install dependencies
go mod download

# Run with hot reloading
go run main.go

# Or use Air for hot reloading
air
```

### Database Management

```bash
# Using Makefile commands (Recommended)
make db-connect    # Connect to MySQL database
make db-reset      # Reset database
make db-backup     # Create backup
make db-restore    # Restore from backup

# Manual commands
docker-compose exec db mysql -u expense_user -p expense_tracker
docker-compose logs db
docker-compose down -v
docker-compose up -d
```

## 📱 PWA Features

The application includes Progressive Web App features:

- **Offline Support**: Service worker for offline functionality
- **Installable**: Can be installed on mobile devices
- **Camera Integration**: Receipt photo capture
- **Local Storage**: SQLite for offline data

## 🔍 Troubleshooting

### Common Issues

1. **Port conflicts**: Make sure ports 3000, 8000, 3306, and 80 are available
2. **Docker not running**: Start Docker Desktop or Docker daemon
3. **Permission issues**: Run `chmod +x scripts/dev.sh` if needed
4. **Database connection**: Wait a few seconds for MySQL to initialize

### Useful Commands

```bash
# Using Makefile commands (Recommended)
make logs          # View all container logs
make logs-frontend # View frontend logs only
make logs-backend  # View backend logs only
make logs-db       # View database logs only
make restart       # Restart all services
make down          # Stop all services
make build         # Rebuild and start

# Manual Docker commands
docker-compose logs -f
docker-compose logs -f frontend
docker-compose logs -f backend
docker-compose logs -f db
docker-compose restart frontend
docker-compose down
docker-compose up --build -d
```

### Health Checks

```bash
# Using Makefile (Recommended)
make health  # Check all services health

# Manual checks
curl http://localhost:3000  # Frontend
curl http://localhost:8000/health  # Backend
curl http://localhost/health  # Nginx proxy
```

## 🚀 Next Steps

After the development environment is running:

1. **Set up Mistral AI API** for OCR functionality
2. **Configure Google OAuth** for authentication
3. **Start building the frontend** with SvelteKit
4. **Implement the backend** with Golang Azure Functions
5. **Add PWA features** and offline support

## 📋 Makefile Quick Reference

### Essential Commands
```bash
make help          # Show all commands
make quick-dev     # One-command setup and start
make tree          # View project structure
make health        # Check service status
make logs          # View all logs
make restart       # Restart all services
make clean         # Clean up resources
```

### Database Commands
```bash
make db-reset      # Reset database
make db-connect    # Connect to database
make db-backup     # Create backup
make db-restore    # Restore backup
```

### Service Management
```bash
make frontend      # Start frontend only
make backend       # Start backend only
make db            # Start database only
make logs-frontend # Frontend logs only
make logs-backend  # Backend logs only
```

## 📚 Learning Resources

- **SvelteKit**: https://kit.svelte.dev/
- **Golang**: https://golang.org/doc/
- **Azure Functions**: https://docs.microsoft.com/en-us/azure/azure-functions/
- **Mistral AI**: https://docs.mistral.ai/
- **Docker**: https://docs.docker.com/

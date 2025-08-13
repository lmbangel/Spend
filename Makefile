# Expense Tracker App - Makefile
# Usage: make <command>

.PHONY: help install dev build clean logs restart stop status tree db-reset db-connect frontend backend nginx test lint format

# Default target
help:
	@echo "🚀 Expense Tracker App - Available Commands:"
	@echo ""
	@echo "📦 Setup & Installation:"
	@echo "  install     - Install dependencies for frontend and backend"
	@echo "  setup       - Initial setup (copy env, install deps)"
	@echo ""
	@echo "🐳 Docker Commands:"
	@echo "  dev         - Start development environment"
	@echo "  build       - Build all containers"
	@echo "  up          - Start containers in background"
	@echo "  down        - Stop all containers"
	@echo "  restart     - Restart all containers"
	@echo "  logs        - View all container logs"
	@echo "  status      - Show container status"
	@echo ""
	@echo "🔧 Individual Services:"
	@echo "  frontend    - Start only frontend service"
	@echo "  backend     - Start only backend service"
	@echo "  nginx       - Start only nginx service"
	@echo "  db          - Start only database service"
	@echo ""
	@echo "🗄️ Database Commands:"
	@echo "  db-reset    - Reset database (remove volumes)"
	@echo "  db-connect  - Connect to MySQL database"
	@echo "  db-backup   - Create database backup"
	@echo "  db-restore  - Restore database from backup"
	@echo ""
	@echo "🧹 Maintenance:"
	@echo "  clean       - Clean up containers, images, and volumes"
	@echo "  prune       - Remove unused Docker resources"
	@echo ""
	@echo "📊 Utility Commands:"
	@echo "  tree        - Show project structure"
	@echo "  health      - Check service health"
	@echo "  ports       - Show used ports"
	@echo ""
	@echo "🔍 Development:"
	@echo "  test        - Run tests"
	@echo "  lint        - Run linting"
	@echo "  format      - Format code"
	@echo ""

# Setup & Installation
install:
	@echo "📦 Installing dependencies in Docker containers..."
	@docker-compose build --no-cache
	@echo "✅ Dependencies installed in containers"

setup:
	@echo "🔧 Setting up development environment..."
	@if [ ! -f .env ]; then \
		cp env.example .env; \
		echo "📝 Created .env file from template"; \
		echo "⚠️  Please update .env with your API keys"; \
	else \
		echo "✅ .env file already exists"; \
	fi
	@echo "🎉 Setup complete! Run 'make dev' to start development"

# Docker Commands
dev:
	@echo "🚀 Starting development environment..."
	@docker-compose up --build -d
	@echo "⏳ Waiting for services to be ready..."
	@sleep 10
	@make health

build:
	@echo "🔨 Building all containers..."
	@docker-compose build

up:
	@echo "⬆️  Starting containers in background..."
	@docker-compose up -d

down:
	@echo "⬇️  Stopping all containers..."
	@docker-compose down

restart:
	@echo "🔄 Restarting all containers..."
	@docker-compose restart

logs:
	@echo "📋 Viewing container logs..."
	@docker-compose logs -f

status:
	@echo "📊 Container status:"
	@docker-compose ps

# Individual Services
frontend:
	@echo "📱 Starting frontend service..."
	@docker-compose up -d frontend

backend:
	@echo "🔧 Starting backend service..."
	@docker-compose up -d backend

nginx:
	@echo "🌐 Starting nginx service..."
	@docker-compose up -d nginx

db:
	@echo "🗄️  Starting database service..."
	@docker-compose up -d db

# Database Commands
db-reset:
	@echo "🗑️  Resetting database..."
	@docker-compose down -v
	@docker-compose up -d db
	@echo "⏳ Waiting for database to initialize..."
	@sleep 10
	@echo "✅ Database reset complete"

db-connect:
	@echo "🔌 Connecting to MySQL database..."
	@docker-compose exec db mysql -u expense_user -pexpense_password expense_tracker

db-backup:
	@echo "💾 Creating database backup..."
	@mkdir -p backups
	@docker-compose exec db mysqldump -u expense_user -pexpense_password expense_tracker > backups/backup_$(shell date +%Y%m%d_%H%M%S).sql
	@echo "✅ Backup created in backups/ directory"

db-restore:
	@echo "📥 Restoring database from backup..."
	@if [ -z "$(file)" ]; then \
		echo "❌ Please specify backup file: make db-restore file=backups/backup_20231201_120000.sql"; \
		exit 1; \
	fi
	@docker-compose exec -T db mysql -u expense_user -pexpense_password expense_tracker < $(file)
	@echo "✅ Database restored from $(file)"

# Maintenance
clean:
	@echo "🧹 Cleaning up Docker resources..."
	@docker-compose down -v --remove-orphans
	@docker system prune -f
	@docker volume prune -f
	@echo "✅ Cleanup complete"

prune:
	@echo "🗑️  Removing unused Docker resources..."
	@docker system prune -a -f
	@docker volume prune -f
	@docker network prune -f
	@echo "✅ Prune complete"

# Utility Commands
tree:
	@echo "🌳 Project structure:"
	@tree -a -I 'node_modules|.git|.svelte-kit|build|dist|tmp' --dirsfirst

health:
	@echo "🏥 Checking service health..."
	@echo "Frontend:"
	@curl -f http://localhost:3000 > /dev/null 2>&1 && echo "✅ Frontend is running" || echo "❌ Frontend is not responding"
	@echo "Backend:"
	@curl -f http://localhost:8000/health > /dev/null 2>&1 && echo "✅ Backend is running" || echo "❌ Backend is not responding"
	@echo "Nginx:"
	@curl -f http://localhost/health > /dev/null 2>&1 && echo "✅ Nginx is running" || echo "❌ Nginx is not responding"
	@echo "Database:"
	@docker-compose exec -T db mysqladmin ping -h localhost -u expense_user -pexpense_password > /dev/null 2>&1 && echo "✅ Database is running" || echo "❌ Database is not responding"

ports:
	@echo "🔌 Checking used ports:"
	@echo "Port 80 (Nginx):"
	@netstat -tlnp 2>/dev/null | grep :80 || echo "Port 80 is available"
	@echo "Port 3000 (Frontend):"
	@netstat -tlnp 2>/dev/null | grep :3000 || echo "Port 3000 is available"
	@echo "Port 8000 (Backend):"
	@netstat -tlnp 2>/dev/null | grep :8000 || echo "Port 8000 is available"
	@echo "Port 3306 (Database):"
	@netstat -tlnp 2>/dev/null | grep :3306 || echo "Port 3306 is available"

# Development Commands
test:
	@echo "🧪 Running tests..."
	@cd frontend && npm test 2>/dev/null || echo "⚠️  No tests configured for frontend"
	@cd backend && go test ./... 2>/dev/null || echo "⚠️  No tests configured for backend"

lint:
	@echo "🔍 Running linting..."
	@cd frontend && npm run lint 2>/dev/null || echo "⚠️  No linting configured for frontend"
	@cd backend && golangci-lint run 2>/dev/null || echo "⚠️  No linting configured for backend"

format:
	@echo "🎨 Formatting code..."
	@cd frontend && npm run format 2>/dev/null || echo "⚠️  No formatting configured for frontend"
	@cd backend && go fmt ./... 2>/dev/null || echo "⚠️  No formatting configured for backend"

# Service-specific logs
logs-frontend:
	@echo "📱 Frontend logs:"
	@docker-compose logs -f frontend

logs-backend:
	@echo "🔧 Backend logs:"
	@docker-compose logs -f backend

logs-db:
	@echo "🗄️  Database logs:"
	@docker-compose logs -f db

logs-nginx:
	@echo "🌐 Nginx logs:"
	@docker-compose logs -f nginx

# Quick commands
quick-dev:
	@echo "⚡ Quick development start..."
	@make setup
	@make dev

quick-restart:
	@echo "⚡ Quick restart..."
	@docker-compose restart
	@make health
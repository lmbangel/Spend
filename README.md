# Expense Tracking App

A Progressive Web App (PWA) for tracking personal expenses with OCR receipt scanning capabilities.

## 🎯 Project Overview

This is an expense tracking application that allows users to:
- Take photos of receipts and extract data using OCR
- Track expenses with detailed categorization
- View comprehensive reports and analytics
- Access data offline with local SQLite storage
- Sync data with cloud MySQL database
- Sign in using Gmail authentication

## 🏗️ Tech Stack

### Frontend
- **SvelteKit** - Full-stack web framework for building the PWA
- **Mobile-first responsive design** - Optimized for mobile, tablet, and desktop
- **PWA capabilities** - Offline support, app-like experience

### Backend
- **Golang** - Backend API development
- **Azure Functions** - Serverless backend deployment
- **Docker** - Containerized development and deployment

### Database
- **Azure MySQL** - Cloud database for data persistence
- **SQLite** - Local database for offline functionality on mobile devices

### Authentication
- **Gmail OAuth** - Email-based authentication

### Infrastructure
- **Azure** - Cloud hosting and services
- **Docker** - Containerization for consistent development and deployment

## 📱 Features

### Core Functionality
1. **Receipt OCR (Mistral AI)**
   - Camera integration for photo capture
   - Mistral AI API for OCR processing and data extraction
   - Intelligent parsing of receipt items, amounts, dates, and merchants
   - Automatic categorization of expenses based on extracted data

2. **Expense Management**
   - Add, edit, and delete expenses
   - Categorize expenses (food, transport, utilities, etc.)
   - Add notes and tags to expenses

3. **Reporting & Analytics**
   - Time period filtering (daily, weekly, monthly, yearly)
   - Spending overview and trends
   - Category-wise expense breakdown
   - Shop/merchant analysis
   - Detailed expense item views

4. **Data Synchronization**
   - Offline-first approach with SQLite
   - Sync with Azure MySQL when online
   - Conflict resolution for data consistency

5. **User Authentication**
   - Gmail OAuth integration
   - Secure user sessions
   - Multi-device support

### Technical Features
- **Responsive Design** - Mobile-first, works on all devices
- **PWA** - Installable, offline-capable web app
- **Real-time Sync** - Automatic data synchronization
- **Image Processing** - Receipt image optimization and Mistral AI OCR
- **Data Export** - Export reports in various formats

## 🏛️ Architecture

### Frontend Architecture (SvelteKit)
```
src/
├── lib/
│   ├── components/     # Reusable UI components
│   ├── stores/         # Svelte stores for state management
│   ├── utils/          # Utility functions
│   └── types/          # TypeScript type definitions
├── routes/             # SvelteKit routes
│   ├── auth/           # Authentication pages
│   ├── dashboard/      # Main dashboard
│   ├── expenses/       # Expense management
│   ├── reports/        # Reporting and analytics
│   └── settings/       # App settings
└── app.html           # Base HTML template
```

### Backend Architecture (Azure Functions + Golang)
```
functions/
├── auth/              # Authentication functions
├── expenses/          # Expense CRUD operations
├── ocr/              # Mistral AI OCR processing functions
├── sync/             # Data synchronization
└── reports/          # Report generation
```

### Database Schema
```sql
-- Users table
CREATE TABLE users (
    id VARCHAR(255) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories table
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    color VARCHAR(7),
    icon VARCHAR(50)
);

-- Expenses table
CREATE TABLE expenses (
    id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    category_id INT,
    merchant VARCHAR(255),
    date DATE NOT NULL,
    receipt_image_url VARCHAR(500),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Receipt items table (for detailed OCR data)
CREATE TABLE receipt_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    expense_id VARCHAR(255) NOT NULL,
    item_name VARCHAR(255),
    quantity INT,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    FOREIGN KEY (expense_id) REFERENCES expenses(id)
);
```

## 🐳 Development Setup

### Prerequisites
- **Docker** and **Docker Compose**
- **Git** (for version control)
- **Node.js** (optional, for local development)
- **Go** (optional, for local development)
- **Make** (for using the Makefile commands)

### Quick Start with Makefile

The project includes a comprehensive Makefile with all the commands you need:

```bash
# See all available commands
make help

# Quick setup and start development
make quick-dev

# Or step by step:
make setup      # Initial setup (copy env, install deps)
make dev        # Start development environment
```

### Manual Setup (Alternative)

```bash
# Clone the repository
git clone <repository-url>
cd expense-tracker

# Copy environment template
cp env.example .env

# Edit .env file with your API keys
nano .env

# Start development environment with Docker
docker-compose up -d

# Frontend development
cd frontend
npm install
npm run dev

# Backend development
cd backend
go mod download
go run main.go
```

### Docker Configuration
- **Frontend Container** - SvelteKit development server
- **Backend Container** - Golang Azure Functions runtime
- **Database Container** - MySQL for local development
- **Nginx Container** - Reverse proxy and static file serving

## 🛠️ Makefile Commands

The project includes a comprehensive Makefile for easy development workflow:

### 📦 Setup & Installation
```bash
make help          # Show all available commands
make install       # Install dependencies for frontend and backend
make setup         # Initial setup (copy env, install deps)
```

### 🐳 Docker Commands
```bash
make dev           # Start development environment
make build         # Build all containers
make up            # Start containers in background
make down          # Stop all containers
make restart       # Restart all containers
make logs          # View all container logs
make status        # Show container status
```

### 🔧 Individual Services
```bash
make frontend      # Start only frontend service
make backend       # Start only backend service
make nginx         # Start only nginx service
make db            # Start only database service
```

### 🗄️ Database Commands
```bash
make db-reset      # Reset database (remove volumes)
make db-connect    # Connect to MySQL database
make db-backup     # Create database backup
make db-restore    # Restore database from backup
```

### 🧹 Maintenance
```bash
make clean         # Clean up containers, images, and volumes
make prune         # Remove unused Docker resources
```

### 📊 Utility Commands
```bash
make tree          # Show project structure
make health        # Check service health
make ports         # Show used ports
```

### 🔍 Development
```bash
make test          # Run tests
make lint          # Run linting
make format        # Format code
```

### 📋 Service-specific Logs
```bash
make logs-frontend # Frontend logs only
make logs-backend  # Backend logs only
make logs-db       # Database logs only
make logs-nginx    # Nginx logs only
```

### ⚡ Quick Commands
```bash
make quick-dev     # Quick development start
make quick-restart # Quick restart with health check
```

## 🚀 Deployment

### Azure Resources
- **Azure Functions** - Backend API hosting
- **Azure MySQL Database** - Production database
- **Azure Storage** - Receipt image storage
- **Azure CDN** - Static asset delivery
- **Azure App Service** - Frontend hosting (optional)

### Deployment Pipeline
1. **Docker Build** - Build container images
2. **Azure Container Registry** - Store images
3. **Azure Functions** - Deploy backend
4. **Static Web Apps** - Deploy frontend
5. **Database Migration** - Apply schema changes

## 📋 Development Roadmap

### Phase 1: Foundation ✅
- [x] Project setup with Docker
- [x] Comprehensive Makefile with all commands
- [x] Basic SvelteKit frontend structure
- [x] Golang Azure Functions backend structure
- [x] Database schema and migrations
- [x] Development environment documentation
- [ ] Basic authentication flow

### Phase 2: Core Features
- [ ] Expense CRUD operations
- [ ] Receipt photo capture
- [ ] OCR integration
- [ ] Basic reporting
- [ ] Offline SQLite support

### Phase 3: Advanced Features
- [ ] Advanced analytics and reporting
- [ ] Data synchronization
- [ ] PWA capabilities
- [ ] Performance optimization
- [ ] Testing and documentation

### Phase 4: Polish & Deploy
- [ ] UI/UX improvements
- [ ] Security hardening
- [ ] Production deployment
- [ ] Monitoring and logging
- [ ] User feedback integration

## 🔧 Configuration

### Environment Variables
```bash
# Database
DATABASE_URL=mysql://user:password@host:port/database
SQLITE_PATH=/path/to/local/database.db

# Azure
AZURE_STORAGE_CONNECTION_STRING=
AZURE_FUNCTIONS_KEY=

# Authentication
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# OCR Service (Mistral AI)
MISTRAL_API_KEY=
MISTRAL_MODEL=mistral-large-latest

# App Configuration
APP_ENV=development
APP_URL=http://localhost:3000
```

## 🤖 Mistral AI OCR Integration

### OCR Processing Flow
1. **Image Capture** - User takes photo of receipt using device camera
2. **Image Preprocessing** - Optimize image quality for better OCR results
3. **Mistral AI API Call** - Send image to Mistral AI for text extraction
4. **Data Parsing** - Extract structured data from OCR response:
   - Merchant/store name
   - Date and time
   - Total amount
   - Individual line items
   - Tax and subtotal information
5. **Categorization** - Auto-categorize based on merchant and items
6. **Data Storage** - Save to local SQLite and sync to cloud MySQL

### Mistral AI Benefits
- **High Accuracy** - Advanced AI models for better text recognition
- **Structured Output** - JSON response with parsed receipt data
- **Multi-language Support** - Works with receipts in various languages
- **Context Understanding** - Better understanding of receipt structure
- **Cost Effective** - Competitive pricing for OCR services

## 📱 PWA Features

- **Service Worker** - Offline functionality
- **Web App Manifest** - App-like installation
- **Push Notifications** - Expense reminders
- **Background Sync** - Data synchronization
- **Camera API** - Receipt photo capture

## 🔒 Security Considerations

- **OAuth 2.0** - Secure authentication
- **HTTPS** - Encrypted data transmission
- **Input Validation** - Prevent injection attacks
- **Rate Limiting** - API abuse prevention
- **Data Encryption** - Sensitive data protection

## 📊 Performance Goals

- **Lighthouse Score** - 90+ for all metrics
- **First Contentful Paint** - < 1.5s
- **Largest Contentful Paint** - < 2.5s
- **Cumulative Layout Shift** - < 0.1
- **First Input Delay** - < 100ms

## 🤝 Contributing

This is a learning project focused on:
- SvelteKit development
- Golang backend development
- Azure cloud services
- Docker containerization
- PWA development

## 📄 License

This project is for educational purposes.

## 📚 Project Files Overview

### Core Configuration Files
- **`docker-compose.yml`** - Container orchestration for all services
- **`Makefile`** - Comprehensive development commands
- **`env.example`** - Environment variables template
- **`.gitignore`** - Git ignore rules for the project

### Frontend (SvelteKit)
- **`frontend/package.json`** - Dependencies and scripts
- **`frontend/svelte.config.js`** - SvelteKit configuration with PWA support
- **`frontend/vite.config.js`** - Vite development server configuration
- **`frontend/tsconfig.json`** - TypeScript configuration
- **`frontend/Dockerfile.dev`** - Development container for SvelteKit

### Backend (Golang Azure Functions)
- **`backend/go.mod`** - Go module dependencies
- **`backend/air.toml`** - Hot reloading configuration
- **`backend/Dockerfile.dev`** - Development container for Golang

### Database & Infrastructure
- **`database/init.sql`** - Complete database schema with default data
- **`nginx/nginx.conf`** - Reverse proxy configuration
- **`scripts/dev.sh`** - Development environment startup script

### Documentation
- **`README.md`** - Comprehensive project documentation
- **`SETUP.md`** - Step-by-step setup guide

## 🎯 Getting Started

1. **Clone the repository**
2. **Run `make help`** to see all available commands
3. **Run `make quick-dev`** for one-command setup and start
4. **Access the application** at http://localhost:3000

---

**Next Steps**: Start building the SvelteKit frontend with PWA features and implement the Golang backend with Mistral AI OCR integration.

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/gin-gonic/gin"
)

type HealthResponse struct {
	Status    string    `json:"status"`
	Timestamp time.Time `json:"timestamp"`
	Service   string    `json:"service"`
	Version   string    `json:"version"`
}

type Expense struct {
	ID          string    `json:"id"`
	Amount      float64   `json:"amount"`
	Category    string    `json:"category"`
	Merchant    string    `json:"merchant"`
	Date        time.Time `json:"date"`
	Description string    `json:"description"`
}

func main() {
	// Set Gin to release mode in production
	if os.Getenv("ENVIRONMENT") == "production" {
		gin.SetMode(gin.ReleaseMode)
	}

	r := gin.Default()

	// CORS middleware
	r.Use(func(c *gin.Context) {
		c.Header("Access-Control-Allow-Origin", "*")
		c.Header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		c.Header("Access-Control-Allow-Headers", "Origin, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")
		
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204)
			return
		}
		
		c.Next()
	})

	// Health check endpoint
	
	// API routes
	api := r.Group("/api")
	{
		api.GET("/health", func(c *gin.Context) {
			response := HealthResponse{
				Status:    "healthy",
				Timestamp: time.Now(),
				Service:   "expense-tracker-backend",
				Version:   "1.0.0",
			}
			c.JSON(http.StatusOK, response)
		})
		// Expenses endpoints
		api.GET("/expenses", getExpenses)
		api.POST("/expenses", createExpense)
		api.GET("/expenses/:id", getExpense)
		api.PUT("/expenses/:id", updateExpense)
		api.DELETE("/expenses/:id", deleteExpense)

		// OCR endpoint
		api.POST("/ocr", processReceipt)

		// Categories endpoint
		api.GET("/categories", getCategories)
	}

	// Root endpoint
	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "Expense Tracker API",
			"version": "1.0.0",
			"status":  "running",
		})
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8000"
	}

	fmt.Printf("🚀 Expense Tracker Backend starting on port %s\n", port)
	fmt.Printf("📊 Health check: http://localhost:%s/health\n", port)
	fmt.Printf("🔗 API docs: http://localhost:%s/api\n", port)

	if err := r.Run(":" + port); err != nil {
		log.Fatal("Failed to start server:", err)
	}
}

// Mock data for development
var mockExpenses = []Expense{
	{
		ID:          "1",
		Amount:      25.50,
		Category:    "Food & Dining",
		Merchant:    "Starbucks",
		Date:        time.Now().AddDate(0, 0, -1),
		Description: "Coffee and pastry",
	},
	{
		ID:          "2",
		Amount:      45.00,
		Category:    "Transportation",
		Merchant:    "Uber",
		Date:        time.Now().AddDate(0, 0, -2),
		Description: "Ride to work",
	},
}

// API Handlers
func getExpenses(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"expenses": mockExpenses,
		"count":    len(mockExpenses),
	})
}

func createExpense(c *gin.Context) {
	var expense Expense
	if err := c.ShouldBindJSON(&expense); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	expense.ID = fmt.Sprintf("%d", len(mockExpenses)+1)
	expense.Date = time.Now()
	mockExpenses = append(mockExpenses, expense)

	c.JSON(http.StatusCreated, expense)
}

func getExpense(c *gin.Context) {
	id := c.Param("id")
	for _, expense := range mockExpenses {
		if expense.ID == id {
			c.JSON(http.StatusOK, expense)
			return
		}
	}
	c.JSON(http.StatusNotFound, gin.H{"error": "Expense not found"})
}

func updateExpense(c *gin.Context) {
	id := c.Param("id")
	var updatedExpense Expense
	if err := c.ShouldBindJSON(&updatedExpense); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	for i, expense := range mockExpenses {
		if expense.ID == id {
			updatedExpense.ID = id
			mockExpenses[i] = updatedExpense
			c.JSON(http.StatusOK, updatedExpense)
			return
		}
	}
	c.JSON(http.StatusNotFound, gin.H{"error": "Expense not found"})
}

func deleteExpense(c *gin.Context) {
	id := c.Param("id")
	for i, expense := range mockExpenses {
		if expense.ID == id {
			mockExpenses = append(mockExpenses[:i], mockExpenses[i+1:]...)
			c.JSON(http.StatusOK, gin.H{"message": "Expense deleted"})
			return
		}
	}
	c.JSON(http.StatusNotFound, gin.H{"error": "Expense not found"})
}

func processReceipt(c *gin.Context) {
	// Mock OCR processing
	c.JSON(http.StatusOK, gin.H{
		"message": "Receipt processing endpoint",
		"status":  "OCR processing will be implemented with Mistral AI",
		"data": map[string]interface{}{
			"merchant": "Sample Store",
			"amount":   29.99,
			"date":     time.Now(),
			"items": []map[string]interface{}{
				{"name": "Item 1", "price": 15.99},
				{"name": "Item 2", "price": 14.00},
			},
		},
	})
}

func getCategories(c *gin.Context) {
	categories := []map[string]interface{}{
		{"id": 1, "name": "Food & Dining", "color": "#EF4444", "icon": "utensils"},
		{"id": 2, "name": "Transportation", "color": "#3B82F6", "icon": "car"},
		{"id": 3, "name": "Shopping", "color": "#8B5CF6", "icon": "shopping-bag"},
		{"id": 4, "name": "Entertainment", "color": "#EC4899", "icon": "film"},
		{"id": 5, "name": "Utilities", "color": "#10B981", "icon": "bolt"},
		{"id": 6, "name": "Healthcare", "color": "#F59E0B", "icon": "heart"},
		{"id": 7, "name": "Travel", "color": "#06B6D4", "icon": "plane"},
		{"id": 8, "name": "Education", "color": "#84CC16", "icon": "graduation-cap"},
		{"id": 9, "name": "Home & Garden", "color": "#F97316", "icon": "home"},
		{"id": 10, "name": "Other", "color": "#6B7280", "icon": "ellipsis-h"},
	}

	c.JSON(http.StatusOK, gin.H{
		"categories": categories,
		"count":      len(categories),
	})
}

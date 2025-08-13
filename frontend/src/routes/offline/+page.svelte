<script>
  import { Camera, Receipt, BarChart3, Settings, Mail, Lock, Eye, EyeOff, Chrome, X, Menu, Play, Users, Zap, Shield, Star } from "lucide-svelte";
  import { onMount } from "svelte";

  let showLogin = true;
  let showPassword = false;
  let showConfirmPassword = false;
  let showAuthModal = false;
  let showMobileMenu = false;
  let isScrolled = false;
  
  // Currency and location
  let userCurrency = { symbol: '$', code: 'USD', name: 'US Dollar' };
  let userCountry = 'United States';
  let showCurrencySelector = false;
  
  // Available currencies
  const availableCurrencies = [
    { symbol: '$', code: 'USD', name: 'US Dollar', flag: '🇺🇸' },
    { symbol: 'R', code: 'ZAR', name: 'South African Rand', flag: '🇿🇦' },
    { symbol: '£', code: 'GBP', name: 'British Pound', flag: '🇬🇧' },
    { symbol: '€', code: 'EUR', name: 'Euro', flag: '🇪🇺' },
    { symbol: '¥', code: 'JPY', name: 'Japanese Yen', flag: '🇯🇵' },
    { symbol: '₹', code: 'INR', name: 'Indian Rupee', flag: '🇮🇳' },
    { symbol: 'C$', code: 'CAD', name: 'Canadian Dollar', flag: '🇨🇦' },
    { symbol: 'A$', code: 'AUD', name: 'Australian Dollar', flag: '🇦🇺' }
  ];
  
  // Form data
  let loginForm = {
    email: "",
    password: ""
  };
  
  let signupForm = {
    name: "",
    email: "",
    password: "",
    confirmPassword: ""
  };

  onMount(() => {
    detectUserLocation();
    handleScroll();
  });

  // Detect user location and set currency
  async function detectUserLocation() {
    // Check if user has manually selected a currency
    const savedCurrency = localStorage.getItem('selectedCurrency');
    if (savedCurrency) {
      userCurrency = JSON.parse(savedCurrency);
      return; // Use saved preference
    }

    try {
      const response = await fetch('https://ipapi.co/json/');
      const data = await response.json();
      
      // if (data.country_code === 'ZA') {
      //   userCurrency = { symbol: 'R', code: 'ZAR', name: 'South African Rand' };
      //   userCountry = 'South Africa';
      // } else if (data.country_code === 'US') {
        userCurrency = { symbol: '$', code: 'USD', name: 'US Dollar' };
        userCountry = 'United States';
      // } else if (data.country_code === 'GB') {
      //   userCurrency = { symbol: '£', code: 'GBP', name: 'British Pound' };
      //   userCountry = 'United Kingdom';
      // } else if (data.country_code === 'EU') {
      //   userCurrency = { symbol: '€', code: 'EUR', name: 'Euro' };
      //   userCountry = 'European Union';
      // }
      
      // Save detected currency to localStorage
      localStorage.setItem('selectedCurrency', JSON.stringify(userCurrency));
    } catch (error) {
      console.log('Could not detect location, using default USD');
    }
  }

  // Handle scroll for header transparency
  function handleScroll() {
    window.addEventListener('scroll', () => {
      isScrolled = window.scrollY > 50;
    });
  }

  // Manual currency selection
  function selectCurrency(currency) {
    userCurrency = currency;
    showCurrencySelector = false;
    // Save to localStorage for persistence
    localStorage.setItem('selectedCurrency', JSON.stringify(currency));
  }

  // Toggle currency selector
  function toggleCurrencySelector() {
    showCurrencySelector = !showCurrencySelector;
  }

  // Toggle password visibility
  function togglePassword() {
    showPassword = !showPassword;
  }

  function toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
  }

  // Handle form submissions
  function handleLogin(e) {
    e.preventDefault();
    console.log("Login attempt:", loginForm);
    // TODO: Implement backend login
  }

  function handleSignup(e) {
    e.preventDefault();
    console.log("Signup attempt:", signupForm);
    // TODO: Implement backend signup
  }

  // Social login handlers
  function handleGoogleLogin() {
    console.log("Google login clicked");
    // TODO: Implement Google OAuth
  }

  function handleMicrosoftLogin() {
    console.log("Microsoft login clicked");
    // TODO: Implement Microsoft OAuth
  }

  // Close modal and reset forms
  function closeAuthModal() {
    showAuthModal = false;
    showLogin = true;
    loginForm = { email: "", password: "" };
    signupForm = { name: "", email: "", password: "", confirmPassword: "" };
  }

  // Open auth modal
  function openAuthModal(isLogin = true) {
    showLogin = isLogin;
    showAuthModal = true;
  }
</script>

<svelte:head>
  <title>Expense Tracker - Welcome</title>
</svelte:head>

<!-- Header Navigation -->
<header class="header {isScrolled ? 'scrolled' : ''}">
  <div class="header-container">
    <div class="logo">
      <span class="logo-icon">
        <img src="/icons/icon.svg" alt="Spend Icon" srcset="">
      </span>
      <span class="logo-text">!Spend</span>
    </div>
    
    <nav class="nav-desktop">
      <a href="#features" class="nav-link">Features</a>
      <a href="#pricing" class="nav-link">Pricing</a>
      <a href="#about" class="nav-link">About</a>
      
      <!-- Currency Selector -->
      <!-- <div class="currency-selector">
        <button class="currency-btn" on:click={toggleCurrencySelector}>
          <span class="currency-flag">{userCurrency.flag || '💱'}</span>
          <span class="currency-symbol">{userCurrency.symbol}</span>
          <span class="currency-arrow">▼</span>
        </button>
        
        {#if showCurrencySelector}
          <div class="currency-dropdown">
            {#each availableCurrencies as currency}
              <button 
                class="currency-option {userCurrency.code === currency.code ? 'active' : ''}"
                on:click={() => selectCurrency(currency)}
              >
                <span class="currency-flag">{currency.flag}</span>
                <span class="currency-info">
                  <span class="currency-name">{currency.name}</span>
                  <span class="currency-code">{currency.code}</span>
                </span>
                {#if userCurrency.code === currency.code}
                  <span class="checkmark">✓</span>
                {/if}
              </button>
            {/each}
          </div>
        {/if}
      </div> -->
      
      <button class="btn btn-outline" on:click={() => openAuthModal(true)}>Sign In</button>
      <button class="btn btn-primary" on:click={() => openAuthModal(false)}>Get Started</button>
    </nav>

    <button class="mobile-menu-btn" on:click={() => showMobileMenu = !showMobileMenu}>
      <Menu size={24} />
    </button>
  </div>

      <!-- Mobile Menu -->
    {#if showMobileMenu}
      <div class="mobile-menu">
        <a href="#features" class="mobile-nav-link">Features</a>
        <a href="#pricing" class="mobile-nav-link">Pricing</a>
        <a href="#about" class="mobile-nav-link">About</a>
        
        <!-- Mobile Currency Selector -->
        <div class="mobile-currency-section">
          <div class="mobile-currency-label">Currency</div>
          <div class="mobile-currency-options">
            {#each availableCurrencies as currency}
              <button 
                class="mobile-currency-option {userCurrency.code === currency.code ? 'active' : ''}"
                on:click={() => { selectCurrency(currency); showMobileMenu = false; }}
              >
                <span class="currency-flag">{currency.flag}</span>
                <span class="currency-symbol">{currency.symbol}</span>
                <span class="currency-name">{currency.name}</span>
              </button>
            {/each}
          </div>
        </div>
        
        <button class="btn btn-outline mobile-btn" on:click={() => { openAuthModal(true); showMobileMenu = false; }}>Sign In</button>
        <button class="btn btn-primary mobile-btn" on:click={() => { openAuthModal(false); showMobileMenu = false; }}>Get Started</button>
      </div>
    {/if}
</header>

<!-- Hero Section -->
<section class="hero">
  <div class="hero-container">
    <!-- Left Side: Hero Content -->
    <div class="hero-content">
      <!-- <div class="hero-badge">
        <span>🔗 Trusted by 25,000+ users</span>
      </div> -->
      
      <h1 class="hero-title">
        We're here to <span class="highlight">Simplify Your Finances</span>
      </h1>
      
      <div class="hero-decoration">
        <svg width="120" height="20" viewBox="0 0 120 20" fill="none">
          <path d="M10 10 Q30 5, 50 10 T90 10 T130 10" stroke="#10b981" stroke-width="3" fill="none"/>
        </svg>
      </div>
      
      <p class="hero-subtitle">
        Track, analyze, and optimize your spending effortlessly with our AI-powered Expense Tracker.
      </p>
      
      <div class="hero-actions">
        <button class="btn btn-primary btn-large" on:click={() => openAuthModal(false)}>
          Try Free Trial
        </button>
        <button class="btn btn-outline btn-large" on:click={() => openAuthModal(false)}>
          <Play size={16} />
          View Demo
        </button>
      </div>
      
      <div class="hero-stats">
        <div class="stat">
          <div class="stat-number">0K+</div>
          <div class="stat-label">Active Users</div>
        </div>
        <div class="stat">
          <div class="stat-number">100%</div>
          <div class="stat-label">Satisfaction</div>
        </div>
        <!-- <div class="stat">
          <div class="stat-number">24/7</div>
          <div class="stat-label">Support</div>
        </div> -->
      </div>
    </div>

    <!-- Right Side: Phone with Floating Elements -->
    <div class="hero-visual">
      <div class="phone-container">
        <!-- Floating Elements -->
        <div class="floating-element card-1">
          <div class="floating-card">
            <div class="card-icon">✓</div>
            <div class="card-text">Expense Added</div>
          </div>
        </div>
        
        <div class="floating-element card-2">
          <div class="floating-card">
            <div class="card-header">OCR Receipt Scan</div>
            <!-- <div class="card-input">Snap & Scan</div> -->
            <button class="card-btn">Scan</button>
          </div>
        </div>
        
        <div class="floating-element card-3">
          <div class="floating-card">
            <div class="card-header">Smart Categorization</div>
            <div class="card-number">Categorization</div>
            <div class="card-expiry">_</div>
          </div>
        </div>
        
        <div class="floating-element card-4">
          <div class="floating-card">
            <div class="card-header">Total Income</div>
            <div class="card-amount">{userCurrency.symbol}245.00</div>
            <BarChart3 size={16} />
          </div>
        </div>
        
        <div class="floating-element card-5">
          <div class="floating-card">
            <div class="card-header">Insights & Reports</div>
            <div class="card-input">Actionable Insights</div>
            <!-- <div class="card-icon">Insights & Reports</div> -->
          </div>
        </div>

        <!-- Phone Mockup -->
        <div class="phone-mockup">
          <div class="phone-screen">
            <div class="app-header">
              <div class="app-title">Expenses</div>
              <div class="app-total">{userCurrency.symbol}2,847.50</div>
            </div>
            <div class="expense-item">
              <div class="expense-icon">🍕</div>
              <div class="expense-details">
                <div class="expense-name">Pizza Delivery</div>
                <div class="expense-category">Food & Dining</div>
              </div>
              <div class="expense-amount">{userCurrency.symbol}24.99</div>
            </div>
            <div class="expense-item">
              <div class="expense-icon">🚗</div>
              <div class="expense-details">
                <div class="expense-name">Uber</div>
                <div class="expense-category">Transportation</div>
              </div>
              <div class="expense-amount">{userCurrency.symbol}45.00</div>
            </div>
            <div class="expense-item">
              <div class="expense-icon">🛒</div>
              <div class="expense-details">
                <div class="expense-name">Grocery Store</div>
                <div class="expense-category">Shopping</div>
              </div>
              <div class="expense-amount">{userCurrency.symbol}67.50</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Features Section -->
<section id="features" class="features-section">
  <div class="container">
    <div class="section-header">
      <h2>Everything you need to manage expenses</h2>
      <p>Powerful features to help you stay on top of your spending</p>
    </div>
    
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon">
          <Camera size={32} />
        </div>
        <h3>AI Receipt Scanning</h3>
        <p>Take photos of receipts and let our AI extract all the details automatically</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">
          <Receipt size={32} />
        </div>
        <h3>Smart Categorization</h3>
        <p>Automatically categorize expenses and organize them intelligently</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">
          <BarChart3 size={32} />
        </div>
        <h3>Detailed Analytics</h3>
        <p>Get insights into your spending patterns with beautiful charts and reports</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">
          <Settings size={32} />
        </div>
        <h3>Offline Support</h3>
        <p>Works offline with local storage and syncs when you're back online</p>
      </div>
    </div>
  </div>
</section>

<!-- About Section -->
<section id="about" class="about-section">
  <div class="container">
    <div class="section-header">
      <h2>Why Choose !Spend?</h2>
      <p>Built for modern teams who need powerful expense management</p>
    </div>
    
    <div class="about-grid">
      <div class="about-card">
        <div class="about-icon">
          <Zap size={32} />
        </div>
        <h3>Lightning Fast</h3>
        <p>Process receipts in seconds with our AI-powered OCR technology</p>
      </div>
      
      <div class="about-card">
        <div class="about-icon">
          <Shield size={32} />
        </div>
        <h3>Bank-Level Security</h3>
        <p>Your financial data is protected with enterprise-grade encryption</p>
      </div>
      
      <div class="about-card">
        <div class="about-icon">
          <Users size={32} />
        </div>
        <h3>Team Collaboration</h3>
        <p>Share expenses, approve reimbursements, and manage team budgets</p>
      </div>
    </div>
  </div>
</section>

<!-- Pricing Section -->
<section id="pricing" class="pricing-section">
  <div class="container">
    <div class="section-header">
      <h2>Simple, Transparent Pricing</h2>
      <p>Choose the plan that fits your needs</p>
    </div>
    
    <div class="pricing-grid">
      <div class="pricing-card">
        <div class="pricing-header">
          <h3>Starter</h3>
          <div class="pricing-price">
            <span class="currency">{userCurrency.symbol}</span>
            <span class="amount">0</span>
            <span class="period">/month</span>
          </div>
          <p>Perfect for individuals</p>
        </div>
        <ul class="pricing-features">
          <li>✓ Up to 100 receipts/month</li>
          <li>✓ Basic categorization</li>
          <li>✓ Mobile app access</li>
          <li>✓ Email support</li>
        </ul>
        <button class="btn btn-outline pricing-btn">Get Started Free</button>
      </div>
      
      <div class="pricing-card featured">
        <div class="pricing-badge">Most Popular</div>
        <div class="pricing-header">
          <h3>Pro</h3>
          <div class="pricing-price">
            <span class="currency">{userCurrency.symbol}</span>
            <span class="amount">5</span>
            <span class="period">/month</span>
          </div>
          <p>Great for small teams</p>
        </div>
        <ul class="pricing-features">
          <li>✓ Unlimited receipts</li>
          <li>✓ Advanced analytics</li>
          <li>✓ Team collaboration</li>
          <li>✓ Priority support</li>
          <li>✓ API access</li>
        </ul>
        <button class="btn btn-primary pricing-btn">Start Pro Trial</button>
      </div>
      
      <div class="pricing-card">
        <div class="pricing-header">
          <h3>Enterprise</h3>
          <div class="pricing-price">
            <span class="currency">{userCurrency.symbol}</span>
            <span class="amount">12</span>
            <span class="period">/month</span>
          </div>
          <p>For large organizations</p>
        </div>
        <ul class="pricing-features">
          <li>✓ Everything in Pro</li>
          <li>✓ Custom integrations</li>
          <li>✓ Dedicated support</li>
          <li>✓ Advanced reporting</li>
          <li>✓ SSO & compliance</li>
        </ul>
        <button class="btn btn-outline pricing-btn">Contact Sales</button>
      </div>
    </div>
  </div>
</section>

<!-- <footer class="footer">
  <div class="footer-content">
    <div class="footer-attribution">
      <span>Built with</span>
      <span class="heart">❤️</span>
      <span>by</span>
      <a href="https://www.linkedin.com/in/lmbangel/" target="_blank" rel="noopener noreferrer" class="author-link">
        lmbangel
      </a>
      <span class="profile-picture">
        <img src="/img/lmbangel_profile_photo.jpg" alt="lmbangel" />
      </span>
    </div>
  </div>
</footer> -->

<!-- Auth Modal -->
{#if showAuthModal}
  <div class="modal-overlay" on:click={closeAuthModal}>
    <div class="modal-content" on:click|stopPropagation>
      <div class="modal-header">
        <h2>{showLogin ? 'Sign In' : 'Create Account'}</h2>
        <button class="modal-close" on:click={closeAuthModal}>
          <X size={24} />
        </button>
      </div>

      <!-- Toggle Buttons -->
      <div class="auth-toggle">
        <button 
          class="toggle-btn {showLogin ? 'active' : ''}" 
          on:click={() => showLogin = true}
        >
          Sign In
        </button>
        <button 
          class="toggle-btn {!showLogin ? 'active' : ''}" 
          on:click={() => showLogin = false}
        >
          Sign Up
        </button>
      </div>

      <!-- Login Form -->
      {#if showLogin}
        <form class="auth-form" on:submit={handleLogin}>
          <div class="form-group">
            <label for="login-email">Email</label>
            <div class="input-wrapper">
              <Mail size={20} class="input-icon" />
              <input 
                id="login-email"
                type="email" 
                placeholder="Enter your email" 
                bind:value={loginForm.email}
                required
              />
            </div>
          </div>
          
          <div class="form-group">
            <label for="login-password">Password</label>
            <div class="input-wrapper">
              <Lock size={20} class="input-icon" />
              {#if showPassword}
                <input 
                  id="login-password"
                  type="text"
                  placeholder="Enter your password" 
                  bind:value={loginForm.password}
                  required
                />
              {:else}
                <input 
                  id="login-password"
                  type="password"
                  placeholder="Enter your password" 
                  bind:value={loginForm.password}
                  required
                />
              {/if}
              <button type="button" class="password-toggle" on:click={togglePassword}>
                {#if showPassword}
                  <EyeOff size={18} />
                {:else}
                  <Eye size={18} />
                {/if}
              </button>
            </div>
          </div>

          <button type="submit" class="btn btn-primary auth-submit">
            Sign In
          </button>

          <div class="divider">
            <span>or continue with</span>
          </div>

          <div class="social-login">
            <button type="button" class="social-btn google" on:click={handleGoogleLogin}>
              <Chrome size={20} />
              Google
            </button>
            <button type="button" class="social-btn microsoft" on:click={handleMicrosoftLogin}>
              <svg width="20" height="20" viewBox="0 0 21 21" fill="none">
                <path d="M10 1H1v9h9V1zM20 1h-9v9h9V1zM10 11H1v9h9v-9zM20 11h-9v9h9v-9z" fill="currentColor"/>
              </svg>
              Microsoft
            </button>
          </div>
        </form>
      {:else}
        <!-- Signup Form -->
        <form class="auth-form" on:submit={handleSignup}>
          <div class="form-group">
            <label for="signup-name">Full Name</label>
            <div class="input-wrapper">
              <input 
                id="signup-name"
                type="text" 
                placeholder="Enter your full name" 
                bind:value={signupForm.name}
                required
              />
            </div>
          </div>

          <div class="form-group">
            <label for="signup-email">Email</label>
            <div class="input-wrapper">
              <Mail size={20} class="input-icon" />
              <input 
                id="signup-email"
                type="email" 
                placeholder="Enter your email" 
                bind:value={signupForm.email}
                required
              />
            </div>
          </div>
          
          <div class="form-group">
            <label for="signup-password">Password</label>
            <div class="input-wrapper">
              <Lock size={20} class="input-icon" />
              {#if showPassword}
                <input 
                  id="signup-password"
                  type="text"
                  placeholder="Create a password" 
                  bind:value={signupForm.password}
                  required
                />
              {:else}
                <input 
                  id="signup-password"
                  type="password"
                  placeholder="Create a password" 
                  bind:value={signupForm.password}
                  required
                />
              {/if}
              <button type="button" class="password-toggle" on:click={togglePassword}>
                {#if showPassword}
                  <EyeOff size={18} />
                {:else}
                  <Eye size={18} />
                {/if}
              </button>
            </div>
          </div>

          <div class="form-group">
            <label for="signup-confirm">Confirm Password</label>
            <div class="input-wrapper">
              <Lock size={20} class="input-icon" />
              {#if showConfirmPassword}
                <input 
                  id="signup-confirm"
                  type="text"
                  placeholder="Confirm your password" 
                  bind:value={signupForm.confirmPassword}
                  required
                />
              {:else}
                <input 
                  id="signup-confirm"
                  type="password"
                  placeholder="Confirm your password" 
                  bind:value={signupForm.confirmPassword}
                  required
                />
              {/if}
              <button type="button" class="password-toggle" on:click={toggleConfirmPassword}>
                {#if showConfirmPassword}
                  <EyeOff size={18} />
                {:else}
                  <Eye size={18} />
                {/if}
              </button>
            </div>
          </div>

          <button type="submit" class="btn btn-primary auth-submit">
            Create Account
          </button>

          <div class="divider">
            <span>or continue with</span>
          </div>

          <div class="social-login">
            <button type="button" class="social-btn google" on:click={handleGoogleLogin}>
              <Chrome size={20} />
              Google
            </button>
            <button type="button" class="social-btn microsoft" on:click={handleMicrosoftLogin}>
              <svg width="20" height="20" viewBox="0 0 21 21" fill="none">
                <path d="M10 1H1v9h9V1zM20 1h-9v9h9V1zM10 11H1v9h9v-9zM20 11h-9v9h9v-9z" fill="currentColor"/>
              </svg>
              Microsoft
            </button>
          </div>
        </form>
      {/if}
    </div>
  </div>
{/if}

<style>
  /* Reset and base styles */
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
    line-height: 1.6;
    color: #1f2937;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
  }

  /* Header Styles */
  .header {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    background: rgba(255, 255, 255, 0.8);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    z-index: 1000;
    transition: all 0.3s ease;
  }

  .header.scrolled {
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  }

  .header-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 1rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .logo {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 1.5rem;
    font-weight: 700;
    color: #667eea;
  }

  .logo-icon {
    font-size: 2rem;
  }
  .logo-icon > img{
    width: 1.5rem;
  }

  /* Currency Selector */
  .currency-selector {
    position: relative;
  }

  .currency-btn {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: rgba(255, 255, 255, 0.9);
    border: 1px solid rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    padding: 0.5rem 0.75rem;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 0.875rem;
    font-weight: 500;
  }

  .currency-btn:hover {
    background: rgba(255, 255, 255, 1);
    border-color: rgba(0, 0, 0, 0.2);
    transform: translateY(-1px);
  }

  .currency-flag {
    font-size: 1rem;
  }

  .currency-symbol {
    font-weight: 600;
    color: #374151;
  }

  .currency-arrow {
    font-size: 0.75rem;
    color: #6b7280;
    transition: transform 0.2s ease;
  }

  .currency-selector:hover .currency-arrow {
    transform: rotate(180deg);
  }

  .currency-dropdown {
    position: absolute;
    top: 100%;
    right: 0;
    background: white;
    border: 1px solid rgba(0, 0, 0, 0.1);
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
    min-width: 200px;
    z-index: 1001;
    margin-top: 0.5rem;
    overflow: hidden;
  }

  .currency-option {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    width: 100%;
    padding: 0.75rem 1rem;
    border: none;
    background: none;
    cursor: pointer;
    transition: background 0.2s ease;
    text-align: left;
  }

  .currency-option:hover {
    background: #f9fafb;
  }

  .currency-option.active {
    background: #eff6ff;
    color: #1d4ed8;
  }

  .currency-info {
    flex: 1;
    display: flex;
    flex-direction: column;
  }

  .currency-name {
    font-weight: 500;
    font-size: 0.875rem;
  }

  .currency-code {
    font-size: 0.75rem;
    color: #6b7280;
    font-weight: 400;
  }

  .checkmark {
    color: #10b981;
    font-weight: 600;
  }

  .nav-desktop {
    display: flex;
    align-items: center;
    gap: 2rem;
  }

  .nav-link {
    text-decoration: none;
    color: #6b7280;
    font-weight: 500;
    transition: color 0.2s;
  }

  .nav-link:hover {
    color: #374151;
  }

  .mobile-menu-btn {
    display: none;
    background: none;
    border: none;
    color: #6b7280;
    cursor: pointer;
    padding: 0.5rem;
  }

  .mobile-menu {
    display: none;
    background: white;
    border-top: 1px solid rgba(0, 0, 0, 0.1);
    padding: 1rem;
  }

  .mobile-nav-link {
    display: block;
    padding: 0.75rem 0;
    text-decoration: none;
    color: #6b7280;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
  }

  .mobile-btn {
    display: block;
    width: 100%;
    margin: 0.5rem 0;
  }

  /* Mobile Currency Selector */
  .mobile-currency-section {
    padding: 1rem 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    margin-bottom: 1rem;
  }

  .mobile-currency-label {
    font-size: 0.875rem;
    font-weight: 600;
    color: #374151;
    margin-bottom: 0.75rem;
    text-align: center;
  }

  .mobile-currency-options {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 0.5rem;
  }

  .mobile-currency-option {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.25rem;
    padding: 0.75rem;
    border: 1px solid rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    background: white;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 0.75rem;
  }

  .mobile-currency-option:hover {
    border-color: #667eea;
    background: #f8fafc;
  }

  .mobile-currency-option.active {
    border-color: #667eea;
    background: #eff6ff;
    color: #1d4ed8;
  }

  .mobile-currency-option .currency-flag {
    font-size: 1.25rem;
  }

  .mobile-currency-option .currency-symbol {
    font-weight: 600;
    font-size: 0.875rem;
  }

  .mobile-currency-option .currency-name {
    font-size: 0.625rem;
    color: #6b7280;
    text-align: center;
    line-height: 1.2;
  }

  /* Button Styles */
  .btn {
    padding: 0.75rem 1.5rem;
    border-radius: 8px;
    font-weight: 600;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: all 0.2s;
    font-size: 0.875rem;
  }

  .btn-primary {
    background: #667eea;
    color: white;
  }

  .btn-primary:hover {
    background: #5a67d8;
    transform: translateY(-1px);
  }

  .btn-outline {
    background: transparent;
    color: #667eea;
    border: 2px solid #667eea;
  }

  .btn-outline:hover {
    background: #667eea;
    color: white;
  }

  .btn-large {
    padding: 1rem 2rem;
    font-size: 1rem;
  }

  /* Hero Section */
  .hero {
    padding: 8rem 1rem 4rem;
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    color: #1f2937;
    min-height: 100vh;
    display: flex;
    align-items: center;
  }

  .hero-container {
    max-width: 1200px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 4rem;
    align-items: center;
  }

  .hero-badge {
    display: inline-block;
    background: rgba(16, 185, 129, 0.1);
    color: #059669;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.875rem;
    font-weight: 600;
    margin-bottom: 1.5rem;
  }

  .hero-title {
    font-size: 3.5rem;
    font-weight: 700;
    line-height: 1.2;
    margin-bottom: 1rem;
    color: #1f2937;
  }

  .highlight {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .hero-decoration {
    margin: 1.5rem 0;
  }

  .hero-subtitle {
    font-size: 1.25rem;
    color: #6b7280;
    margin-bottom: 2.5rem;
    line-height: 1.6;
  }

  .hero-actions {
    display: flex;
    gap: 1rem;
    margin-bottom: 3rem;
    flex-wrap: wrap;
  }

  .hero-stats {
    display: flex;
    gap: 2rem;
  }

  .stat {
    text-align: center;
  }

  .stat-number {
    font-size: 1.5rem;
    font-weight: 700;
    color: #667eea;
  }

  .stat-label {
    font-size: 0.875rem;
    color: #6b7280;
  }

  .hero-visual {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .phone-container {
    position: relative;
    width: 100%;
    height: 600px;
  }

  .floating-element {
    position: absolute;
    animation: float 6s ease-in-out infinite;
  }

  .floating-element:nth-child(1) { animation-delay: 0s; }
  .floating-element:nth-child(2) { animation-delay: 1s; }
  .floating-element:nth-child(3) { animation-delay: 2s; }
  .floating-element:nth-child(4) { animation-delay: 3s; }
  .floating-element:nth-child(5) { animation-delay: 4s; }

  .card-1 { top: 10%; left: 10%; }
  .card-2 { top: 15%; right: 15%; }
  .card-3 { top: 50%; right: 5%; }
  .card-4 { bottom: 20%; left: 15%; }
  .card-5 { bottom: 10%; right: 20%; }

  .floating-card {
    background: white;
    padding: 1rem;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(0, 0, 0, 0.05);
    min-width: 120px;
  }

  .card-icon {
    font-size: 1.5rem;
    text-align: center;
  }

  .card-text {
    font-size: 0.75rem;
    color: #6b7280;
    margin-top: 0.5rem;
  }

  .card-header {
    font-size: 0.75rem;
    color: #6b7280;
    margin-bottom: 0.5rem;
  }

  .card-input {
    font-size: 1rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 0.5rem;
  }

  .card-btn {
    background: #10b981;
    color: white;
    border: none;
    padding: 0.25rem 0.75rem;
    border-radius: 6px;
    font-size: 0.75rem;
    cursor: pointer;
  }

  .card-number {
    font-size: 0.875rem;
    font-weight: 600;
    color: #1f2937;
  }

  .card-expiry {
    font-size: 0.75rem;
    color: #6b7280;
  }

  .card-amount {
    font-size: 1.25rem;
    font-weight: 700;
    color: #10b981;
  }

  @keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-20px); }
  }

  .app-preview {
    perspective: 1000px;
  }

  .phone-mockup {
    width: 280px;
    height: 560px;
    background: #1f2937;
    border-radius: 40px;
    padding: 8px;
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
    transform: rotateY(-15deg) rotateX(5deg);
  }

  .phone-screen {
    width: 100%;
    height: 100%;
    background: white;
    border-radius: 32px;
    padding: 2rem 1.5rem;
    color: #1f2937;
  }

  .app-header {
    text-align: center;
    margin-bottom: 2rem;
  }

  .app-title {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
  }

  .app-total {
    font-size: 2rem;
    font-weight: 700;
    color: #10b981;
  }

  .expense-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 1rem;
    background: #f9fafb;
    border-radius: 12px;
    margin-bottom: 0.6rem;
    font-size: smaller;
  }

  .expense-icon {
    font-size: 1.5rem;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: white;
    border-radius: 50%;
  }

  .expense-details {
    flex: 1;
  }

  .expense-name {
    font-weight: 600;
    margin-bottom: 0.25rem;
  }

  .expense-category {
    font-size: 0.875rem;
    color: #6b7280;
  }

  .expense-amount {
    font-weight: 700;
    color: #ef4444;
  }

  /* Features Section */
  .features-section {
    padding: 6rem 1rem;
    background: #f9fafb;
  }

  .section-header {
    text-align: center;
    margin-bottom: 4rem;
  }

  .section-header h2 {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    color: #1f2937;
  }

  .section-header p {
    font-size: 1.125rem;
    color: #6b7280;
    max-width: 600px;
    margin: 0 auto;
  }

  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2rem;
  }

  .feature-card {
    background: white;
    padding: 2rem;
    border-radius: 16px;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .feature-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  }

  .feature-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 1.5rem;
    color: white;
  }

  .feature-card h3 {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: #1f2937;
  }

  .feature-card p {
    color: #6b7280;
    line-height: 1.6;
  }

  /* About Section */
  .about-section {
    padding: 6rem 1rem;
    background: white;
  }

  .section-header {
    text-align: center;
    margin-bottom: 4rem;
  }

  .section-header h2 {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    color: #1f2937;
  }

  .section-header p {
    font-size: 1.125rem;
    color: #6b7280;
    max-width: 600px;
    margin: 0 auto;
  }

  .about-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
  }

  .about-card {
    text-align: center;
    padding: 2rem;
  }

  .about-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 1.5rem;
    color: white;
  }

  .about-card h3 {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: #1f2937;
  }

  .about-card p {
    color: #6b7280;
    line-height: 1.6;
  }

  /* Pricing Section */
  .pricing-section {
    padding: 6rem 1rem;
    background: #f9fafb;
  }

  .pricing-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    max-width: 1000px;
    margin: 0 auto;
  }

  .pricing-card {
    background: white;
    padding: 2rem;
    border-radius: 16px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    position: relative;
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .pricing-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  }

  .pricing-card.featured {
    border: 2px solid #667eea;
    transform: scale(1.05);
  }

  .pricing-badge {
    position: absolute;
    top: -12px;
    left: 50%;
    transform: translateX(-50%);
    background: #667eea;
    color: white;
    padding: 0.25rem 1rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
  }

  .pricing-header {
    text-align: center;
    margin-bottom: 2rem;
  }

  .pricing-header h3 {
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: #1f2937;
  }

  .pricing-price {
    font-size: 3rem;
    font-weight: 700;
    color: #1f2937;
    margin: 1rem 0;
  }

  .currency {
    font-size: 1.5rem;
    vertical-align: top;
  }

  .period {
    font-size: 1rem;
    color: #6b7280;
    font-weight: 400;
  }

  .pricing-features {
    list-style: none;
    margin: 2rem 0;
  }

  .pricing-features li {
    padding: 0.5rem 0;
    color: #6b7280;
  }

  .pricing-btn {
    width: 100%;
  }

  /* Modal Styles */
  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 2000;
    padding: 1rem;
  }

  .modal-content {
    background: white;
    border-radius: 16px;
    padding: 2rem;
    max-width: 450px;
    width: 100%;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
  }

  .modal-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1.5rem;
  }

  .modal-header h2 {
    font-size: 1.5rem;
    font-weight: 700;
    color: #1f2937;
  }

  .modal-close {
    background: none;
    border: none;
    color: #6b7280;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 8px;
    transition: background 0.2s;
  }

  .modal-close:hover {
    background: #f3f4f6;
  }

  /* Auth Toggle */
  .auth-toggle {
    display: flex;
    background: #f3f4f6;
    border-radius: 12px;
    padding: 4px;
    margin-bottom: 2rem;
  }

  .toggle-btn {
    flex: 1;
    background: transparent;
    border: none;
    color: #6b7280;
    padding: 0.75rem;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: 500;
  }

  .toggle-btn.active {
    background: white;
    color: #1f2937;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  /* Form Styles */
  .auth-form {
    text-align: left;
  }

  .form-group {
    margin-bottom: 1.5rem;
  }

  label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 600;
    color: #374151;
    font-size: 0.875rem;
  }

  .input-wrapper {
    position: relative;
    display: flex;
    align-items: center;
  }

  .input-icon {
    position: absolute;
    left: 12px;
    color: #9ca3af;
    z-index: 1;
  }

  input {
    width: 100%;
    padding: 0.75rem 1rem 0.75rem 2.5rem;
    background: #f9fafb;
    border: 2px solid #e5e7eb;
    border-radius: 8px;
    color: #1f2937;
    font-size: 1rem;
    transition: all 0.3s ease;
  }

  input::placeholder {
    color: #9ca3af;
  }

  input:focus {
    outline: none;
    border-color: #667eea;
    background: white;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
  }

  .password-toggle {
    position: absolute;
    right: 12px;
    background: none;
    border: none;
    color: #9ca3af;
    cursor: pointer;
    padding: 4px;
  }

  .auth-submit {
    width: 100%;
    margin-top: 1rem;
    padding: 0.875rem;
    font-size: 1rem;
    font-weight: 600;
  }

  /* Divider */
  .divider {
    text-align: center;
    margin: 1.5rem 0;
    position: relative;
  }

  .divider::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 0;
    right: 0;
    height: 1px;
    background: #e5e7eb;
  }

  .divider span {
    background: white;
    padding: 0 1rem;
    color: #6b7280;
    font-size: 0.875rem;
  }

  /* Social Login */
  .social-login {
    display: flex;
    gap: 1rem;
  }

  .social-btn {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    padding: 0.75rem;
    border: 2px solid #e5e7eb;
    border-radius: 8px;
    background: white;
    color: #374151;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 0.875rem;
    font-weight: 500;
  }

  .social-btn:hover {
    border-color: #d1d5db;
    background: #f9fafb;
  }

  .social-btn.google:hover {
    border-color: #dc2626;
    background: #fef2f2;
    color: #dc2626;
  }

  .social-btn.microsoft:hover {
    border-color: #2563eb;
    background: #eff6ff;
    color: #2563eb;
  }

  /* Responsive Design */
  @media (max-width: 768px) {
    .nav-desktop {
      display: none;
    }

    .mobile-menu-btn {
      display: block;
    }

    .mobile-menu {
      display: block;
    }

    .hero-container {
      grid-template-columns: 1fr;
      text-align: center;
      gap: 2rem;
    }

    .hero-title {
      font-size: 2.5rem;
    }

    .hero-stats {
      justify-content: center;
    }

    .hero-actions {
      justify-content: center;
    }

    .floating-element {
      display: none;
    }

    .phone-mockup {
      width: 240px;
      height: 480px;
      position: relative;
      transform: none;
      margin: 0 auto;
    }

    .features-grid {
      grid-template-columns: 1fr;
    }

    .about-grid {
      grid-template-columns: 1fr;
    }

    .pricing-grid {
      grid-template-columns: 1fr;
    }

    .pricing-card.featured {
      transform: none;
    }

    .social-login {
      flex-direction: column;
    }

    .modal-content {
      padding: 1.5rem;
    }
  }

  @media (max-width: 480px) {
    .hero {
      padding: 6rem 1rem 2rem;
    }

    .hero-title {
      font-size: 2rem;
    }

    .hero-subtitle {
      font-size: 1rem;
    }

    .hero-actions {
      flex-direction: column;
    }

    .hero-stats {
      flex-direction: column;
      gap: 1rem;
    }

    .btn-large {
      width: 100%;
    }

    .section-header h2 {
      font-size: 2rem;
    }

    .pricing-price {
      font-size: 2.5rem;
    }
  }
  footer.footer {
  position: relative;
  bottom: 10px; /* slight spacing from bottom */
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  font-family: sans-serif;
  font-size: 14px;
  color: #ccc;
}

.footer-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
}

.footer-attribution .heart {
  color: #e25555;
  margin: 0 4px;
}

.footer-attribution .author-link {
  color: #00c853; /* green link like example */
  font-weight: 600;
}

.footer-attribution .author-link:hover {
  text-decoration: underline;
}

.profile-picture img {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  margin-left: 4px;
  vertical-align: middle;
}

</style>

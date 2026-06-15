<div align="center">

<img src="https://raw.githubusercontent.com/fasko666/PFE-01/main/frontend-react/public/2.png" alt="PANDA Logo" width="100" />

# PANDA — Freelance Marketplace Platform

**A full-stack freelance marketplace connecting talented freelancers with clients worldwide.**

[![Laravel](https://img.shields.io/badge/Laravel-11-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)](https://laravel.com)
[![React](https://img.shields.io/badge/React-18-61DAFB?style=for-the-badge&logo=react&logoColor=black)](https://react.dev)
[![Vite](https://img.shields.io/badge/Vite-5-646CFF?style=for-the-badge&logo=vite&logoColor=white)](https://vitejs.dev)
[![TailwindCSS](https://img.shields.io/badge/Tailwind-3-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white)](https://tailwindcss.com)
[![MySQL](https://img.shields.io/badge/MySQL-8-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://mysql.com)
[![Stripe](https://img.shields.io/badge/Stripe-Payments-635BFF?style=for-the-badge&logo=stripe&logoColor=white)](https://stripe.com)

[🌐 Live Demo](https://project-kn296.vercel.app) · [📖 Documentation](#) · [🐛 Report Bug](https://github.com/fasko666/PFE-01/issues) · [✨ Request Feature](https://github.com/fasko666/PFE-01/issues)

</div>

---

## 📌 About PANDA

PANDA is a modern freelance marketplace platform built as a final-year engineering project (PFE). It enables **freelancers** to showcase their skills and find work, while **clients** can post jobs, hire talent, and manage contracts — all in one place.

Inspired by platforms like Upwork and Fiverr, PANDA provides a complete end-to-end experience from job posting to payment processing.

---

## ✨ Features

### For Freelancers
- 🧑‍💼 Rich profile with skills, portfolio & hourly rate
- 📨 Submit proposals on job listings
- 💬 Real-time messaging with clients
- 📊 Earnings dashboard & analytics
- 🔔 Smart notifications
- ⚡ Connects system for proposals
- 🤖 AI-powered assistant

### For Clients
- 📋 Post jobs with budgets and deadlines
- 🔍 Search & filter top freelancers
- 📝 Manage contracts & milestones
- 💳 Secure payments via Stripe
- ⭐ Review and rate freelancers
- 📁 Save favorite talent lists

### Platform
- 🔐 Google OAuth + Email authentication
- 🛡️ Two-factor authentication (2FA)
- 🌙 Light / Dark / System theme
- 📱 Fully responsive (mobile-first)
- 🔴 Real-time chat (Laravel Reverb / WebSockets)
- 🧾 Automated weekly invoices
- 🏢 Agency support
- 👨‍💼 Admin dashboard

---

## 🏗️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | React 18, Vite, TailwindCSS, Zustand, Framer Motion |
| **Backend** | Laravel 11, Sanctum, Socialite, Reverb |
| **Database** | MySQL 8 |
| **Payments** | Stripe (escrow + payouts) |
| **Real-time** | Laravel Reverb (WebSockets) |
| **Auth** | Email/Password, Google OAuth, 2FA (TOTP) |
| **AI** | Claude API (AI assistant) |
| **DevOps** | Docker, Docker Compose |

---

## 📁 Project Structure

```
PFE-01/
├── backend-laravel/        # Laravel 11 REST API
│   ├── app/
│   │   ├── Http/Controllers/API/
│   │   │   ├── Auth/       # Authentication & OAuth
│   │   │   ├── Chat/       # Real-time messaging
│   │   │   ├── Contracts/  # Contract management
│   │   │   ├── Jobs/       # Job listings
│   │   │   ├── Payments/   # Stripe integration
│   │   │   └── Admin/      # Admin dashboard
│   │   ├── Models/
│   │   └── Events/         # WebSocket events
│   └── routes/api.php
│
├── frontend-react/         # React 18 + Vite SPA
│   ├── src/
│   │   ├── pages/          # All page components
│   │   ├── components/     # Reusable UI components
│   │   ├── store/          # Zustand state management
│   │   └── api/            # API client
│   └── public/
│
├── PANDA.bat               # One-click Windows launcher
└── docker-compose.yml      # Docker setup
```

---

## 🚀 Quick Start

### Option 1 — Windows (One-click)

Double-click **`PANDA.bat`** — it automatically installs dependencies, sets up the database, and starts both servers.

### Option 2 — Manual Setup

**Requirements:** PHP 8.2+, Composer, Node.js 18+, MySQL 8

**Backend:**
```bash
cd backend-laravel
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

**Frontend:**
```bash
cd frontend-react
npm install
npm run dev
```

**Frontend runs at:** `http://localhost:5173`  
**Backend API at:** `http://localhost:8000/api`

### Option 3 — Docker

```bash
docker-compose up --build
```

---

## ⚙️ Environment Variables

Copy `.env.example` to `.env` in the backend and configure:

```env
# Database
DB_DATABASE=panda
DB_USERNAME=root
DB_PASSWORD=

# Google OAuth
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret
GOOGLE_REDIRECT_URI=http://localhost:8000/api/auth/google/callback

# Stripe
STRIPE_KEY=pk_test_...
STRIPE_SECRET=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Frontend URL
FRONTEND_URL=http://localhost:5173
```

---

## 🔌 API Overview

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/auth/register` | Register a new user |
| `POST` | `/api/auth/login` | Login |
| `GET` | `/api/auth/google` | Google OAuth redirect |
| `GET` | `/api/jobs` | List all jobs |
| `POST` | `/api/jobs` | Post a new job |
| `GET` | `/api/freelancers` | Browse freelancers |
| `GET` | `/api/contracts` | List contracts |
| `POST` | `/api/payments/checkout` | Create Stripe checkout |
| `GET` | `/api/messages` | Get conversations |

Full API documentation available in the backend README.

---

## 👨‍💻 Authors

**Ayoub Elmernissi & Omar Elezouzi**  
Final Year Project (PFE) — Full Stack Web Development

[![GitHub](https://img.shields.io/badge/GitHub-fasko666-181717?style=flat&logo=github)](https://github.com/fasko666)
[![GitHub](https://img.shields.io/badge/GitHub-omarelleazzouzi--eng-181717?style=flat&logo=github)](https://github.com/omarelleazzouzi-eng)

---

## 📄 License

This project is for academic purposes (PFE). All rights reserved © 2025 Ayoub Elmernissi.

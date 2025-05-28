library(shiny)
library(shinydashboard)
library(ggplot2)
library(stringr)
library(shinyjs)
library(shinyWidgets)
library(shinyjs)

ui <- dashboardPage(
  dashboardHeader(
    title = tags$div(
      style = "display: flex; align-items: center; height: 100%; position: relative; top: 50%; transform: translateY(-50%); width:100%;",
      tags$span(
        class = "my-toggle", `data-toggle` = "offcanvas", role = "button",
        style = "margin-right: 15px; padding: 10px; cursor: pointer;",
        icon("bars")
      ),
      actionLink(
        "go_dashboard", 
        label = tags$div(
          tags$img(
            src = "https://drive.google.com/thumbnail?id=1SxJ_KpRwKEMhx54bQy1S07s90DIKy15n",
            height = "35px", 
            style = "vertical-align: middle; margin-right: 10px;"
          )
        ),
        style = "text-decoration: none; background-color: transparent; border: none;"
      ),
      div(
        style = "margin-left:auto; display: flex; align-items: center;",
        switchInput(
          inputId = "dark_mode",
          label = NULL,   
          size = "mini",
          onLabel = "🌙", 
          offLabel = "☀️",
          labelWidth = "1px"
        )
      )
    ),
    titleWidth = 280
  ),
  
  dashboardSidebar(
    width = 280,
    tags$style(".left-side, .main-sidebar {background-color: #ffffff; border-right: 1px solid #ebeced;}"),
    sidebarMenu(
      id = "tabs",
      menuItem("Dashboard", tabName = "dashboard", icon = icon("compass"), badgeColor = "green"),
      menuItem("Mental Health Checkup", tabName = "tes", icon = icon("edit"), badgeColor = "orange"),
      menuItem("Profil Pengguna", tabName = "profil", icon = icon("user"), badgeColor = "blue"),
      menuItem("Tentang Kami", tabName = "tentang", icon = icon("users"), badgeColor = "purple"),
      menuItem("Kenali Emosi", tabName = "emosi", icon = icon("face-smile"), badgeColor = "yellow"),
      tags$div(
        style = "padding:20px; margin-top:40px;",
        tags$img(
          src = "https://drive.google.com/thumbnail?id=1tbrw-By734RVt6Pde2xmwI1FfpQ6wFyD",
          style = "width:100%; opacity:0.4;"
        )
      )
    )
  ),
  
  dashboardBody(
    useShinyjs(),
    # ------ CSS ------
    tags$head(
      # Google Fonts
      tags$link(
        href = "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap", 
        rel="stylesheet"
      ),
      # Style block (CSS)
      tags$style(HTML("
:root {
  --primary-color: #2F5CFA;
  --secondary-color: #4F46E5;
  --accent-color: #F472B6;
  --bg-color: #ffffff;
  --text-color: #37352f;
  --border-color: #e5e7eb;
}

/* Base font & background */
body {
  background-color: #f8fafc;
  font-family: 'Inter', sans-serif;
  color: var(--text-color);
}

.skin-blue .main-sidebar {
  background-color: #F0F4FF !important;
}
.skin-blue .main-sidebar .sidebar-menu > li > a {
  color: #374151 !important;
}
.skin-blue .main-sidebar .sidebar-menu > li.active > a {
  background-color: #DDE7FF !important;
  color: var(--primary-color) !important;
  font-weight: bold;
}
.sidebar-menu li a {
  border-radius: 6px;
  margin: 4px 12px;
  padding: 10px 16px !important;
  color: #5a5a5a !important;
  transition: all 0.2s ease;
}
.sidebar-menu li a:hover {
  background-color: #f5f5f5 !important;
}
.sidebar-menu li.active a {
  background-color: #f0f5ff !important;
  color: var(--primary-color) !important;
  font-weight: 500;
  border-left: 4px solid var(--primary-color);
}
.main-header,
.main-header .navbar,
.main-header .logo {
  height: 50px !important;
  min-height: 50px !important;
  line-height: 50px !important;
  padding: 0 !important;
  overflow: hidden;
  background-color: #ffffff !important;
}
.main-header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1030;
  width: 100%;
}
.main-header .sidebar-toggle {
  display: none !important;
}
.main-sidebar {
  position: fixed;
  top: 0 !important;
  left: 0;
  height: calc(100% - 50px);
  overflow-y: auto;
  width: 280px;
  background-color: #ffffff;
}
.sidebar-mini.sidebar-collapse .main-sidebar {
  transform: translateX(-100%) !important;
  position: fixed;
  z-index: 1050;
}
.sidebar-mini.sidebar-collapse .content-wrapper {
  margin-left: 0 !important;
}
.content-wrapper, .main-footer {
  margin-left: 280px;
}
.content-wrapper {
  margin-top: 40px;
  padding: 10px;
  margin-left: 0 !important;
}

.welcome-title {
  font-size: 2.2rem;
  margin-bottom: 1.5rem;
  color: var(--primary-color);
}
.feature-icon {
  font-size: 1.8rem;
  margin-right: 12px;
  color: var(--primary-color);
}
h1, h2, h3 {
  color: var(--text-color);
  font-weight: 600;
}
.text-muted {
  color: #78716c !important;
}

.btn-notion {
  background: var(--primary-color);
  color: white !important;
  border: none;
  border-radius: 8px;
  padding: 12px 24px;
  font-weight: 500;
  transition: all 0.2s ease;
  box-shadow: 0 2px 4px rgba(47, 92, 250, 0.15);
}
.btn-notion:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(47, 92, 250, 0.25);
  background: var(--secondary-color);
}
.btn-option {
  background: var(--bg-color) !important;
  border: 1px solid var(--border-color) !important;
  border-radius: 8px !important;
  color: var(--text-color) !important;
  margin: 8px 0;
  text-align: left;
  padding: 14px 20px !important;
  transition: all 0.15s ease;
}
.btn-option.selected {
  background: #f0f5ff !important;
  border-color: var(--primary-color) !important;
  color: var(--primary-color) !important;
  font-weight: 500;
}
.explore-btn {
  display: inline-block;
  background-color: #facc15;
  color: #000;
  font-weight: 600;
  padding: 10px 20px;
  text-align: center;
  border-radius: 8px;
  text-decoration: none;
  margin-top: 16px;
  transition: background-color 0.3s ease;
  width: 100%;
}
.explore-btn:hover {
  background-color: #fbbf24;
  color: #111827;
  transform: scale(1.05);
}
.hotline-btn {
  font-size: 16px;
  font-weight: bold;
  padding: 12px 24px;
  border-radius: 10px;
  color: #dc3545;
  background-color: white;
  border: 2px solid #dc3545;
  text-decoration: none;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease-in-out;
}
.hotline-btn:hover {
  background-color: #dc3545;
  color: white;
}

.notion-card {
  background: var(--bg-color);
  border: 1px solid var(--border-color);
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 16px;
  transition: all 0.2s ease;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.03);
  max-width: 720px;
  margin: 40px auto;
  position: relative;
}
.notion-card:hover {
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
  transform: translateY(-2px);
}
.benefit-card {
  background: linear-gradient(135deg, #F8FAFC, #FFFFFF);
  border-left: 5px solid var(--primary-color);
  border-radius: 12px;
  padding: 16px 20px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.03);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.benefit-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
  cursor: pointer;
}
.profile-section {
  background: var(--bg-color);
  border: 1px solid var(--border-color);
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 16px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.03);
}
.metric-badge {
  background: #f0f5ff;
  border-radius: 8px;
  padding: 12px;
  margin: 8px 0;
  color: var(--primary-color);
}
.emotion-card {
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  transition: all 0.2s ease;
  border-radius: 16px;
}
.emotion-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
}
.news-card {
  background: #f8f9fa;
  border-radius: 15px;
  padding: 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
  width: 300px;
  max-width: 300px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  flex-shrink: 0;
  margin: 0 10px;
}
.news-card:hover {
  transform: translateY(-5px);
}
.news-title {
  color: #2c3e50;
  font-size: 1.4em;
  font-weight: 600;
  margin-bottom: 15px;
  border-bottom: 2px solid #3498db;
  padding-bottom: 10px;
  white-space: normal;
  word-wrap: break-word;
  overflow-wrap: break-word;
  overflow-y: auto;
}
.news-body {
  color: #7f8c8d;
  font-size: 1em;
  line-height: 1.6;
  margin-bottom: 20px;
  max-weight: 100px;
  white-space: normal;
}
.tentang-kami-card,
.profil-header-card {
  display: flex;
  align-items: center;
  gap: 12px;
  background-color: #ffffff;
  border: 1px solid #e0e7ff;
  padding: 16px 20px;
  border-radius: 14px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
  transition: all 0.3s ease;
  max-width: 300px;
}
.tentang-kami-card:hover,
.profil-header-card:hover {
  background-color: #f4f7ff;
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
  transform: translateY(-2px);
}
.tentang-kami-text {
  font-size: 20px;
  font-weight: 600;
  color: #2F5CFA;
  margin: 0;
}
.profil-header-text {
  font-size: 22px;
  font-weight: 700;
  color: #2F5CFA;
  margin: 0;
}

.sdg-card {
  background-color: var(--bg-color);
  border: 1px solid var(--border-color);
  border-radius: 16px;
  padding: 24px 20px;
  margin: 16px 0;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.sdg-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
}
.sdg-card h4, .sdg-card strong {
  color: #1f2937;
  font-weight: 600;
  margin-bottom: 8px;
}
.sdg-card p, .sdg-card li {
  color: #4b5563;
  font-size: 0.95rem;
  line-height: 1.5;
}

.progress-bar {
  height: 6px;
  border-radius: 3px;
  background-color: #e0e7ff;
}
.progress-bar > div {
  background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
  border-radius: 3px;
}

.scroll-container {
  overflow-x: auto;
  white-space: nowrap;
  padding: 20px 0;
  width: 100%;
}
.scroll-content {
  display: flex;
  gap: 20px;
  flex-wrap: nowrap;
  min-width: max-content;
}
.col-sm-4 {
  padding-right: 0;
  padding-left: 0;
}
ul.sidebar-menu li:nth-child(5) {
  display: none !important;
}
.my-toggle i {
  color: #000000 !important;
  font-size: 20px;
}
.test-badge {
  flex: 1 1 calc(33.33% - 10px);
  padding: 14px 16px;
  border-radius: 12px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  gap: 10px;
  min-width: 100px;
  transition: all 0.2s ease;
  font-weight: 500;
  font-size: 0.95rem;
  color: #374151;
  cursor: default;
}
.test-badge:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
.test-kecemasan {
  background: linear-gradient(135deg, #E0E7FF, #F0F9FF);
  border-left: 4px solid #6366F1;
}
.test-depresi {
  background: linear-gradient(135deg, #FEE2E2, #FEF2F2);
  border-left: 4px solid #EF4444;
}
.test-overthinking {
  background: linear-gradient(135deg, #FEF9C3, #FEFCE8);
  border-left: 4px solid #F59E0B;
}

body.dark-mode {
  --primary-color: #62a0ff;
  --secondary-color: #395ce6;
  --accent-color: #ff89d7;
  --bg-color: #181924;
  --text-color: #f4f4f9;
  --border-color: #24243c;
  background: #181924 !important;
  color: #f4f4f9 !important;
}
/* Wrapper dark backgrounds */
body.dark-mode,
body.dark-mode .content-wrapper,
body.dark-mode .wrapper,
body.dark-mode .main-footer,
body.dark-mode .modal-content {
  background: #181924 !important;
  color: #f4f4f9 !important;
}

/* Sidebar & Header (Dark) */
body.dark-mode .main-sidebar, body.dark-mode .left-side {
  background: #1c1d2c !important;
  border-right: 1px solid #24243c !important;
}
body.dark-mode .main-header,
body.dark-mode .main-header .navbar,
body.dark-mode .main-header .logo {
  background: #20213a !important;
  color: #f4f4f9 !important;
}
body.dark-mode .sidebar-menu > li > a {
  color: #c9d1d9 !important;
}
body.dark-mode .sidebar-menu > li.active > a {
  background-color: #2d334a !important;
  color: var(--primary-color) !important;
  font-weight: bold;
}
body.dark-mode .sidebar-menu li a:hover {
  background: #222336 !important;
  color: var(--primary-color) !important;
}
body.dark-mode .my-toggle i {
  color: #e0e7ff !important;
}

/* Cards & Section (Dark) */
body.dark-mode .notion-card,
body.dark-mode .profile-section,
body.dark-mode .emotion-card,
body.dark-mode .news-card,
body.dark-mode .contact-card,
body.dark-mode .benefit-card {
  background: #222336 !important;
  color: #f4f4f9 !important;
}
body.dark-mode .modal-content {
  background: #222336 !important;
  border-color: #292950 !important;
  color: #f4f4f9 !important;
  box-shadow: 0 2px 10px rgba(30,35,60,0.18) !important;
}
body.dark-mode .notion-card[style*='linear-gradient'],
body.dark-mode .benefit-card[style*='linear-gradient'] {
  background: #222336 !important;
}
body.dark-mode .notion-card:hover,
body.dark-mode .benefit-card:hover,
body.dark-mode .sdg-card:hover,
body.dark-mode .emotion-card:hover,
body.dark-mode .news-card:hover {
  box-shadow: 0 6px 20px rgba(30,35,60,0.23) !important;
  background: #232442 !important;
  transform: translateY(-2px);
}

/* Blockquote & Highlight (Dark) */
body.dark-mode blockquote,
body.dark-mode .notion-card blockquote {
  background: #222336 !important;
  color: #90caf9 !important;
  border-left: 4px solid #62a0ff !important;
}

/* Badges & Metrics (Dark) */
body.dark-mode .metric-badge {
  background: #232442 !important;
  color: #62a0ff !important;
}

/* Buttons (Dark) */
body.dark-mode .btn-notion,
body.dark-mode .explore-btn,
body.dark-mode .hotline-btn {
  background: #395ce6 !important;
  color: #fff !important;
  border: none !important;
  box-shadow: 0 2px 6px rgba(47, 92, 250, 0.09) !important;
}
body.dark-mode .btn-notion:hover,
body.dark-mode .explore-btn:hover,
body.dark-mode .hotline-btn:hover {
  background: #62a0ff !important;
  color: #fff !important;
}

/* Form, Inputs (Dark) */
body.dark-mode input,
body.dark-mode select,
body.dark-mode textarea,
body.dark-mode .selectize-input {
  background: #20213a !important;
  color: #e1e6f0 !important;
  border-color: #353559 !important;
}
body.dark-mode .selectize-dropdown-content {
  background: #20213a !important;
  color: #e1e6f0 !important;
}
body.dark-mode .form-control:focus {
  background: #232442 !important;
  color: #fff !important;
}

/* Progress Bar (Dark) */
body.dark-mode .progress-bar {
  background: #232442 !important;
}
body.dark-mode .progress-bar > div {
  background: linear-gradient(90deg, #62a0ff, #395ce6) !important;
}

/* News Card (Dark) */
body.dark-mode .news-card {
  background: #24243c !important;
  color: #e1e6f0 !important;
  border: 1px solid #2d334a !important;
}
body.dark-mode .news-title {
  color: #62a0ff !important;
  border-bottom: 2px solid #395ce6 !important;
}
body.dark-mode .news-body {
  color: #d2dbe8 !important;
}

/* Scrollbar (Dark) */
body.dark-mode ::-webkit-scrollbar-thumb {
  background: #232442 !important;
}

/* Table (Dark) */
body.dark-mode table,
body.dark-mode .table,
body.dark-mode th,
body.dark-mode td {
  background: #181924 !important;
  color: #e1e6f0 !important;
  border-color: #2d334a !important;
}

/* HR (Dark) */
body.dark-mode hr,
body.dark-mode .hr {
  border-top: 1px solid #2d334a !important;
}

/* Text & Heading (Dark) */
body.dark-mode h1,
body.dark-mode h2,
body.dark-mode h3,
body.dark-mode h4,
body.dark-mode h5,
body.dark-mode strong {
  color: #e1e6f0 !important;
}
body.dark-mode .text-muted {
  color: #b0b5c3 !important;
}
body.dark-mode .sidebar-menu i,
body.dark-mode .sidebar-menu .fa,
body.dark-mode .main-header .fa {
  color: #9cc9ff !important;
}
body.dark-mode .main-header .fa-bars {
  color: #f4f4f9 !important;
}
body.dark-mode .sidebar-menu > li > a > .fa {
  color: #62a0ff !important;
}

body.dark-mode .content-wrapper {
  transition: margin-left 0.35s cubic-bezier(0.77, 0, 0.175, 1), background 0.3s !important;
  margin-left: 280px;
}
body.dark-mode.sidebar-collapse .content-wrapper {
  margin-left: 0
}

/* Others (Dark) */
body.dark-mode .login-card,
body.dark-mode .signup-card,
body.dark-mode .login-box,
body.dark-mode .form-auth-box {
  background: #232336 !important;
  border-radius: 18px !important;
  box-shadow: 0 2px 18px 0 rgba(30, 35, 60, 0.17) !important;
  color: #f1f5fa !important;
  border: none !important;
}
body.dark-mode .login-card h2,
body.dark-mode .login-card h3,
body.dark-mode .form-auth-title {
  color: #f4f4f9 !important;
  font-weight: 800 !important;
}
body.dark-mode .login-card label,
body.dark-mode .login-card .form-label,
body.dark-mode .login-card strong,
body.dark-mode .form-auth-label {
  color: #e1e6f0 !important;
  font-weight: 700 !important;
  opacity: 1 !important;
}
body.dark-mode .login-card .form-control {
  background: #20213a !important;
  color: #f1f5fa !important;
  border: 1.3px solid #395ce6 !important;
}
body.dark-mode .login-card .btn,
body.dark-mode .login-card button {
  background: linear-gradient(90deg, #2F5CFA 60%, #4F46E5 100%) !important;
  color: #fff !important;
  border-radius: 12px !important;
  font-weight: 700;
}
body.dark-mode .login-card .btn:hover,
body.dark-mode .login-card button:hover {
  background: linear-gradient(90deg, #2463eb 60%, #6648ec 100%) !important;
}
body.dark-mode .login-card ::placeholder {
  color: #b1badc !important;
  opacity: 1 !important;
}
body.dark-mode .profil-header-card {
  background-color: #232336 !important;
  border: 1px solid #292950 !important;
  color: #f4f4f9 !important;
  box-shadow: 0 4px 10px rgba(30,35,60,0.13) !important;
}
body.dark-mode .profil-header-text {
  color: #62a0ff !important;
}
body.dark-mode .profil-header-card .fa-user {
  color: #bb86fc !important;
}
body.dark-mode .sdg-minicard {
  background: #232442 !important;
  color: #e0e6fa !important;
}
body.dark-mode .mini-category-card {
  background: #232336 !important;
  color: #e1e6f0 !important;
  border-radius: 12px !important;
  box-shadow: 0 2px 8px rgba(20,25,50,0.13) !important;
}
body.dark-mode .mini-category-card h4 {
  color: #a6c8ff !important;
}
body.dark-mode .mini-category-card span,
body.dark-mode .mini-category-card svg,
body.dark-mode .mini-category-card i {
  color: #ff89d7 !important;
}
body.dark-mode .sdg-card p,
body.dark-mode .sdg-card li,
body.dark-mode .sdg-card ul,
body.dark-mode .notion-card p,
body.dark-mode .notion-card li,
body.dark-mode .benefit-card,
body.dark-mode .tentang-kami-card,
body.dark-mode .tentang-kami-card p {
  color: #f1f5fa !important;
}
body.dark-mode .sdg-card h4,
body.dark-mode .benefit-card strong,
body.dark-mode .profil-header-text,
body.dark-mode .notion-card h2,
body.dark-mode .notion-card h3,
body.dark-mode .notion-card h4,
body.dark-mode .notion-card h5 {
  color: #62a0ff !important;
  font-weight: bold;
}
body.dark-mode .sdg-card {
  background: #232336 !important;
  border-color: #2d334a !important;
}

.main-sidebar {
  transition: transform 0.35s cubic-bezier(0.77,0,0.175,1), background 0.3s, box-shadow 0.3s !important;
  will-change: transform;
}
.sidebar-mini.sidebar-collapse .main-sidebar {
  transform: translateX(-100%) !important;
}
.sidebar-mini .main-sidebar {
  transform: translateX(0) !important;
}
body.dark-mode .test-kecemasan {
  background: linear-gradient(135deg, #2a334d, #232336) !important;
  border-left: 4px solid #8ab4ff !important;
  color: #f4f4f9 !important;
}
body.dark-mode .test-depresi {
  background: linear-gradient(135deg, #442626, #232336) !important;
  border-left: 4px solid #ff7675 !important;
  color: #f4f4f9 !important;
}
body.dark-mode .test-overthinking {
  background: linear-gradient(135deg, #534f2a, #232336) !important;
  border-left: 4px solid #ffe066 !important;
  color: #f4f4f9 !important;
}
body.dark-mode .notion-card {
  background: #222336 !important;
  color: #f4f4f9 !important;
}
body.dark-mode .fa-2x, 
body.dark-mode .fa-lg {
  filter: drop-shadow(0 2px 4px #18192440);
}
.hotline-card {
  display: flex;
  align-items: center;
  gap: 16px;
  border-radius: 14px;
  padding: 18px 30px 18px 20px;
  margin: 0 auto 14px auto;
  min-width: 0;
  max-width: 340px;
  box-shadow: 0 2px 12px rgba(30,35,60,0.07);
  font-weight: 700;
  font-size: 1.11rem;
  transition: background 0.22s, color 0.22s;
}

.hotline-card.kemenkes {
  background: #e0f2fe;
  border-left: 6px solid #2F5CFA;
  color: #2F5CFA;
}
.hotline-card.wa {
  background: #f0fdf4;
  border-left: 6px solid #25D366;
  color: #25D366;
}
.hotline-card .fa-2x {
  font-size: 2.1rem !important;
  min-width: 34px;
}

body.dark-mode .hotline-card.kemenkes {
  background: #232d40 !important;
  color: #8ab4ff !important;
  border-left: 6px solid #8ab4ff !important;
}
body.dark-mode .hotline-card.wa {
  background: #1e352a !important;
  color: #75f0ae !important;
  border-left: 6px solid #75f0ae !important;
}

:root {
  --accent-yellow: #fef3c7;
  --accent-yellow-dark: #50420c;
  --accent-pink: #f3f6fb;
  --accent-pink-dark: #292944;
  --accent-warning: #fffbe7;
  --accent-warning-dark: #524406;
}
body.dark-mode {
  --accent-yellow: #554408;
  --accent-yellow-dark: #fffbe7;
  --accent-pink: #292944;
  --accent-pink-dark: #e1e6fa;
  --accent-warning: #524406;
  --accent-warning-dark: #fffbe7;
}
.roadmap-card {
  background: var(--bg-color);
  color: var(--text-color);
  border-radius: 18px;
  box-shadow: 0 6px 18px rgba(0,0,0,0.06);
  margin-bottom: 16px;
  padding: 32px 24px;
  transition: background 0.25s, color 0.25s;
}
.roadmap-highlight-yellow {
  background: var(--accent-yellow);
  color: #5b4506;
  border-radius: 14px;
  padding: 18px;
  margin-top: 14px;
  transition: background 0.25s, color 0.25s;
}
body.dark-mode .roadmap-highlight-yellow {
  background: var(--accent-yellow);
  color: #ffe066;
}
.roadmap-highlight-pink {
  background: var(--accent-pink);
  color: #444;
  border-radius: 14px;
  padding: 18px;
  margin-top: 14px;
  transition: background 0.25s, color 0.25s;
}
body.dark-mode .roadmap-highlight-pink {
  background: var(--accent-pink);
  color: #b9bbf1;
}
body.dark-mode .roadmap-title-glow {
  text-shadow:
    0 0 8px var(--glow-color, #fff),
    0 0 18px var(--glow-color, #fff),
    0 0 40px var(--glow-color, #fff);
}

")),
      tags$script(HTML("
      Shiny.addCustomMessageHandler('setDarkMode', function(mode) {
        if(mode) {
          document.body.classList.add('dark-mode');
        } else {
          document.body.classList.remove('dark-mode');
        }
      });
    "))
    ),
    
    # ------ CONTENT: TAB ITEMS ------
    tabItems(
      tabItem(tabName = "dashboard",
              div(
                class = "notion-card",
                style = "background: linear-gradient(135deg, #dbeafe, #f8fafc);",
                h2("Selamat Datang di Reach-Me", style = "margin-bottom: 8px;"),
                p("Mulai perjalanan kesehatan mentalmu dengan tes sederhana kami", class = "text-muted")
              ),
              fluidRow(
                column(4, div(
                  class = "notion-card",
                  style = "cursor: pointer;",
                  onclick = "Shiny.setInputValue('open_emosi', Math.random());",
                  div(
                    style = "display: flex; align-items: center; gap: 16px;",
                    div(
                      style = "background: #e0e7ff; width: 48px; height: 48px; border-radius: 8px; display: flex; align-items: center; justify-content: center;",
                      icon("children", class = "fas fa-children", style = "color: var(--primary-color);")
                    ),
                    div(
                      h4("Kenali", style = "margin: 0;"),
                      p("Emosimu", class = "text-muted", style = "margin: 0;")
                    )
                  )
                )),
                column(4, div(
                  class = "notion-card",
                  style = "cursor: pointer;",
                  onclick = "Shiny.setInputValue('open_roadmap', Math.random());",
                  div(
                    style = "display: flex; align-items: center; gap: 16px;",
                    div(
                      style = "background: #ffe0e7; width: 48px; height: 48px; border-radius: 8px; display: flex; align-items: center; justify-content: center;",
                      icon("heart", class = "fa-lg", style = "color: #F472B6;")
                    ),
                    div(
                      h4("Peduli", style = "margin: 0;"),
                      p("Mendukungmu", class = "text-muted", style = "margin: 0;")
                    )
                  )
                )),
                column(4, div(
                  class = "notion-card",
                  div(
                    style = "display: flex; align-items: center; gap: 16px;",
                    div(
                      style = "background: #dcfce7; width: 48px; height: 48px; border-radius: 8px; display: flex; align-items: center; justify-content: center;",
                      icon("smile", class = "fa-lg", style = "color: #34d399;")
                    ),
                    div(
                      h4("Positif", style = "margin: 0;"),
                      p("Mentalmu", class = "text-muted", style = "margin: 0;")
                    )
                  )
                ))
              ),
              div(
                class = "scroll-container",
                div(
                  class = "scroll-content",
                  # News Cards
                  div(class = "news-card",
                      div(class = "news-title", "Mindfulness sebagai Solusi Stres di Tempat Kerja"),
                      div(class = "news-body", "Praktik mindfulness semakin diadopsi di lingkungan kerja untuk mengurangi stres dan meningkatkan kesejahteraan karyawan."),
                      tags$a("Pelajari Lebih Lanjut", href = "https://training-indonesia.org/news/mindfulness-sebagai-solusi-untuk-kesehatan-mental-dan-stres-di-tempat-kerja", class = "explore-btn", target = "_blank")),
                  div(class = "news-card",
                      div(class = "news-title", "Tantangan Kesehatan Mental Akibat Kecanduan Digital"),
                      div(class = "news-body", "Kecanduan digital menjadi tantangan serius bagi kesehatan mental di tahun 2025."),
                      tags$a("Baca Selengkapnya", href = "https://www.kompasiana.com/rahma44596/672523c1ed6415527c2c1232/kesehatan-mental-di-era-digital-tantangan-dan-solusi", class = "explore-btn", target = "_blank")),
                  div(class = "news-card",
                      div(class = "news-title", "Pendidikan Kesehatan Mental dalam Kurikulum Sekolah"),
                      div(class = "news-body", "Pendidikan mengenai kesehatan mental mulai dimasukkan ke dalam kurikulum sekolah dan perguruan tinggi."),
                      tags$a("Informasi Lengkap", href = "https://kesmas-id.com/pentingnya-pendidikan-kesehatan-mental-di-sekolah/", class = "explore-btn", target = "_blank")),
                  div(class = "news-card",
                      div(class = "news-title", "Peningkatan Gangguan Mental di Kalangan Terpelajar"),
                      div(class = "news-body", "Studi menunjukkan bahwa individu dengan tingkat pendidikan tinggi semakin rentan mengalami gangguan mental."),
                      tags$a("Selengkapnya", href = "https://nasional.kompas.com/read/2025/01/16/14263091/menkes-perkirakan-30-persen-dari-280-juta-jiwa-di-indonesia-miliki-penyakit", class = "explore-btn", target = "_blank")),
                  div(class = "news-card",
                      div(class = "news-title", "Retret Mindfulness di Indonesia"),
                      div(class = "news-body", "Retret mindfulness dan meditasi semakin populer di Indonesia, menawarkan kesempatan bagi individu untuk menenangkan pikiran."),
                      tags$a("Daftar Sekarang", href = "https://bookretreats.com/s/meditation-retreats/mindfulness-retreats/indonesia", class = "explore-btn", target = "_blank"))
                )
              ),
              div(
                class = "notion-card",
                style = "margin-top: 30px; padding: 40px 24px; text-align: center; background: linear-gradient(90deg, #F0F4FF 60%, #F8FAFC 100%); border-radius: 18px;",
                icon("route", class = "fa-2x", style = "color:#2F5CFA; margin-bottom: 12px;"),
                h3("Peta Jalan Dukungan Interaktif"),
                p("Ikuti langkah demi langkah cara memberikan dan menerima dukungan emosional."),
                actionButton("open_roadmap", "Mulai Roadmap", class = "btn-notion", style = "margin-top: 24px; font-size: 1.14rem; border-radius: 10px;")
              ),
              
              # Peduli Mendukungmu
              fluidRow(
                column(12, align = "center",
                       div(
                         style = "margin-top: 30px;",
                         tags$h4("Butuh bantuan segera?"),
                         tags$a(
                           "📞 Hotline Konseling 24 Jam",
                           href = "tel:+62895352525",
                           class = "btn hotline-btn"
                         )
                       )
                )
              ),
      ),
      # Tes 
      tabItem(tabName = "tes",
              fluidPage(uiOutput("tesUI"))
      ),
      # Tentang Kami
      tabItem(
        tabName = "tentang",
        fluidPage(
          div(class = "notion-card", style = "max-width: 850px; margin-top: 40px;",
              
              div(style = "display:flex; align-items:center; gap:16px; margin-bottom:18px;",
                  icon("users", class = "fa-2x", style = "color: #2F5CFA;"),
                  tags$h2("Tentang Reach-Me", style = "margin:0; color:#2F5CFA; font-weight:700;")),
              
              div(class = "sdg-card", style = "margin-bottom: 20px;",
                  tags$h4(icon("bullseye"), "Visi", style = "color: #2F5CFA; font-weight: bold; margin-top:0;"),
                  tags$p("Menjadi platform kesehatan mental terdepan di Indonesia yang memberdayakan masyarakat untuk lebih sadar, peduli, dan mendukung satu sama lain melalui inovasi digital.", style = "font-size: 12px; color: #374151; margin-bottom: 14px;"),
                  tags$h4(icon("flag"), "Misi", style = "color: #2F5CFA; font-weight: bold;"),
                  tags$ul(
                    tags$li("Memberikan akses tes kesehatan mental mandiri yang mudah, aman, dan privasi terjaga.", style = "font-size: 12px;"),
                    tags$li("Menyediakan edukasi dan rekomendasi berbasis bukti ilmiah tentang kesehatan mental.", style = "font-size: 12px;"),
                    tags$li("Mendorong kolaborasi antara profesional, komunitas, dan pengguna untuk menciptakan lingkungan yang suportif.", style = "font-size: 12px;"),
                    tags$li("Memperluas jangkauan layanan ke seluruh lapisan masyarakat, tanpa diskriminasi.", style = "font-size: 12px;")
                  )
              ),
              
              tags$h4("Nilai-Nilai Inti", style="color: #4F46E5; margin: 28px 0 18px 0; font-weight: bold;"),
              div(style="display:flex; flex-wrap:wrap; gap:14px; margin-bottom:30px;",
                  div(class="benefit-card", style="flex:1 1 100px; min-width:80px; align-items:center; display:flex; justify-content:center; gap:14px; border-left:6px solid #F472B6;",
                      icon("hand-holding-heart", class="fa-lg", style="color:#F472B6;"), 
                      tags$strong("Empati")
                  ),
                  div(class="benefit-card", style="flex:1 1 100px; min-width:80px; align-items:center; display:flex; justify-content:center; gap:14px; border-left:6px solid #FFD600;",
                      icon("lightbulb", class="fa-lg", style="color:#FFD600;"), 
                      tags$strong("Inovasi")
                  ),
                  div(class="benefit-card", style="flex:1 1 100px; min-width:80px; align-items:center; display:flex; justify-content:center; gap:14px; border-left:6px solid #6366F1;",
                      icon("users", class="fa-lg", style="color:#6366F1;"), 
                      tags$strong("Inklusivitas")
                  ),
                  div(class="benefit-card", style="flex:1 1 100px; min-width:80px; align-items:center; display:flex; justify-content:center; gap:14px; border-left:6px solid #34d399;",
                      icon("shield-alt", class="fa-lg", style="color:#34d399;"), 
                      tags$strong("Privasi & Keamanan")
                  ),
                  div(class="benefit-card", style="flex:1 1 100px; min-width:80px; align-items:center; display:flex; justify-content:center; gap:14px; border-left:6px solid #4F46E5;",
                      icon("handshake", class="fa-lg", style="color:#4F46E5;"), 
                      tags$strong("Kolaborasi")
                  )
              ),
              
              tags$h4("Cerita dan Latar Belakang", style="color:#2F5CFA; font-weight:bold; margin-bottom:16px;"),
              div(class="notion-card",
                  style="max-width: 850px; margin: 0 auto 0 auto; border-radius: 12px; padding: 18px 24px; margin-bottom: 0; margin-top:0;",
                  tags$p("Reach-Me lahir dari keresahan tim muda yang melihat masih banyak masyarakat, khususnya anak muda, yang ragu atau malu untuk berbicara soal kesehatan mental. Kami percaya, setiap orang berhak mendapatkan dukungan dan akses informasi yang akurat, mudah dipahami, dan bisa diakses kapan pun dibutuhkan.", 
                         style="font-size:12px; color:#444; margin-bottom:14px;"),
                  tags$p("Didirikan pada tahun 2024, Reach-Me berkomitmen mengubah stigma menjadi support, lewat teknologi dan edukasi. Kami ingin jadi sahabat digital yang selalu ada, menghubungkan pengguna dengan tes kesehatan mental mandiri, edukasi yang kredibel, hingga rujukan profesional, semuanya dengan privasi yang terjaga.", 
                         style="font-size:12px; color:#444; margin-bottom:16px;"),
                  tags$blockquote(
                    style="background-color:#f0f4ff; padding:16px; border-radius:10px; margin:0; border-left:4px solid #2F5CFA;",
                    tags$span(
                      style="font-size:14px;",
                      tags$em("Kami percaya, membangun generasi yang sehat mental dimulai dari keberanian untuk saling peduli. Reach-Me ada untukmu—kapan pun, di mana pun."),
                      tags$br(), 
                      tags$span(style="font-weight:500; color:#6366F1;", "– Tim Reach-Me")
                    )
                  )
              ),
              
              fluidRow(
                column(
                  width = 6,
                  div(class = "sdg-card",
                      tags$h4(icon("heart"), " Kontribusi SDGs", style = "color: var(--secondary-color); margin-bottom: 12px;"),
                      div(class = "sdg-minicard", style = "display: flex; align-items: center; background-color: #f9f9f9; padding: 12px; border-radius: 10px; margin-bottom: 12px; border-left: 6px solid #e74c3c;",
                          icon("heartbeat", class = "fa-2x", style = "color: #e74c3c; margin-right: 12px;"),
                          div(
                            tags$strong("SDG 3: Kesehatan & Kesejahteraan"),
                            tags$p("Mendukung kesehatan mental melalui akses layanan digital.", style = "margin: 4px 0 0 0; font-size: 1.0rem;")
                          )
                      ),
                      div(class = "sdg-minicard", style = "display: flex; align-items: center; background-color: #f9f9f9; padding: 12px; border-radius: 10px; border-left: 6px solid #2980b9;",
                          icon("graduation-cap", class = "fa-2x", style = "color: #2980b9; margin-right: 12px;"),
                          div(
                            tags$strong("SDG 4: Pendidikan Berkualitas"),
                            tags$p("Mengedukasi kesehatan mental berbasis bukti ilmiah.", style = "margin: 4px 0 0 0; font-size: 1.0rem;")
                          )
                      )
                  )
                ),
                
                column(
                  width = 6,
                  div(class = "sdg-card",
                      tags$h4(icon("envelope"), " Kontak", style = "color: var(--secondary-color); margin-bottom: 12px;"),
                      div(class = "benefit-card",
                          style = "display: flex; align-items: center; margin-bottom: 12px; padding: 10px 10px;",
                          icon("envelope", class = "fa-lg", style = "color: var(--primary-color); margin-right: 14px;"),
                          tags$a(
                            href = "mailto:reachmeanytime@gmail.com",
                            "reachmeanytime@gmail.com",
                            style = "color: var(--text-color); text-decoration: none; font-size: 16px; font-weight: 100;")),
                      div(class = "benefit-card",
                          style = "display: flex; align-items: center; border-left-color: #c13584; margin-bottom: 12px; padding: 10px 10px;",
                          icon("instagram", class = "fa-lg", style = "color: #c13584; margin-right: 14px;"),
                          tags$a(
                            href = "https://www.instagram.com/reachme.id/",
                            "@reachme.id",
                            style = "color: var(--text-color); text-decoration: none; font-size: 16px; font-weight: 100;")),
                      div(class = "benefit-card",
                          style = "display: flex; align-items: center; border-left-color: #25D366; margin-bottom: 0px; padding: 10px 10px;",
                          icon("whatsapp", class = "fa-lg", style = "color: #25D366; margin-right: 14px;"),
                          tags$a(
                            href = "https://wa.me/6282147979113",
                            "WhatsApp Reach-Me",
                            target = "_blank",
                            style = "color: var(--text-color); text-decoration: none; font-size: 16px; font-weight: 100;"))
                  )
                )
              )
          )
        )
      ),
      
      tabItem(tabName = "profil",
              fluidPage(
                tags$div(class = "profil-header-card",
                         icon("user", class = "fa-2x", style = "color: #6B21A8;"),
                         tags$p("Profil Pengguna", class = "profil-header-text")),
                uiOutput("login_ui"),
                conditionalPanel(
                  condition = "output.userLoggedIn == true",
                  fluidRow(
                    column(6,
                           div(class = "profile-section notion-card",
                               tags$h3("Informasi Pribadi", style = "color: var(--primary-color); margin-bottom: 20px;"),
                               textInput("nama", "Nama Lengkap", placeholder = "Nama lengkap...",
                                         width = "100%"),
                               numericInput("usia", "Usia", 20, min = 1, max = 255,
                                            width = "100%"),
                               selectInput("gender", "Jenis Kelamin", 
                                           choices = c("Laki-laki", "Perempuan"),
                                           width = "100%"),
                               textAreaInput("goal", "Tujuan Kamu", rows = 3,
                                             placeholder = "Tuliskan hal-hal positif tentangmu...",
                                             width = "100%"),
                               div(style = "display: flex; justify-content: flex-end; margin-top: 20px;",
                                   actionButton("simpan_profil", "Simpan Informasi",
                                                style = "padding: 10px 18px; font-weight: 600; background-color: #4F46E5; color: white; border: none; border-radius: 10px;")
                                   
                               ))),
                    column(6,
                           div(class = "profile-section notion-card",
                               tags$h3("Riwayat Tes", style = "color: var(--primary-color); margin-bottom: 20px;"),
                               div(class = "metric-badge",
                                   icon("clock"), 
                                   tags$span("Tes Terakhir:"), 
                                   textOutput("waktu_tes_terakhir", inline = TRUE)),
                               div(class = "metric-badge",
                                   icon("brain"), 
                                   tags$span("Skor Kecemasan:"), 
                                   textOutput("riwayat_anxiety", inline = TRUE)),
                               div(class = "metric-badge",
                                   icon("cloud-rain"), 
                                   tags$span("Skor Depresi:"), 
                                   textOutput("riwayat_depresi", inline = TRUE)),
                               div(class = "metric-badge",
                                   icon("comment"), 
                                   tags$span("Skor Overthinking:"), 
                                   textOutput("riwayat_overthinking", inline = TRUE))),
                           div(class = "profile-section notion-card",
                               tags$h3("Progress Kesehatan Mental", style = "color: var(--primary-color); margin-bottom: 20px;"),
                               plotOutput("mentalHealthHistory", height = "250px"))))))),
      
      tabItem(tabName = "emosi",
              fluidPage(
                div(class = "notion-card",
                    h2("6 Emosi Utama Manusia", 
                       style = "color: var(--primary-color); font-weight: 700; margin-bottom: 24px; text-align: center;"),
                    tags$p("Setiap manusia memiliki emosi dasar yang memengaruhi cara kita berpikir, bertindak, dan merespons lingkungan. Kenali dan pahami keenam emosi utama ini untuk membangun kesadaran diri yang lebih baik.", 
                           class = "text-muted", 
                           style = "text-align: center; font-size: 1.1rem; margin-bottom: 32px;"),
                    
                    # Responsive Emosi Cards
                    do.call(fluidRow, lapply(list(
                      list(emoji = "angry", title = "Marah", color = "#FFE5E5", text = "Muncul saat merasa terancam, frustrasi, atau tidak dihargai."),
                      list(emoji = "frown", title = "Sedih", color = "#E3EAF1", text = "Datang ketika mengalami kehilangan, kekecewaan, atau kesepian."),
                      list(emoji = "grin-beam", title = "Senang", color = "#FFF9DB", text = "Mewakili kepuasan, kebahagiaan, atau pencapaian sesuatu."),
                      list(emoji = "meh", title = "Jijik", color = "#E7F6E7", text = "Reaksi terhadap sesuatu yang dianggap tidak menyenangkan atau menjijikkan."),
                      list(emoji = "ghost", title = "Takut", color = "#ECE5F6", text = "Timbul saat menghadapi ancaman, bahaya, atau ketidakpastian."),
                      list(emoji = "surprise", title = "Terkejut", color = "#FFF1E0", text = "Reaksi spontan terhadap hal tak terduga atau mengejutkan.")
                    ), function(item) {
                      column(
                        width = 12, 
                        class = "col-sm-12 col-md-6 col-lg-4",
                        div(
                          class = "emotion-card",
                          style = paste0("
                              background-color: ", item$color, ";
                              color: #212121;
                              padding: 24px;
                              border-radius: 16px;
                              margin-bottom: 20px;
                              text-align: center;
                              transition: all 0.3s ease-in-out;
                              min-height: 220px;
                              display: flex;
                              flex-direction: column;
                              justify-content: center;
                              align-items: center;
                            "),
                          icon(item$emoji, class = "fa-2x", style = "margin-bottom: 10px;"),
                          h3(item$title, style = "font-weight: 600; margin-top: 10px;"),
                          p(item$text, style = "font-size: 1rem; color: #555555;")))}))))),
      tabItem(
        tabName = "roadmap",
        uiOutput("roadmap_ui_page")))))
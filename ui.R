library(shiny)
library(shinydashboard)
library(ggplot2)
library(stringr)
library(shinyjs)

#Code Page
dashboardPage(
  dashboardHeader(
    title = tags$div(
      style = "display: flex; align-items: center; height: 100%; position: relative; top: 50%; transform: translateY(-50%);",
      tags$span(class = "my-toggle", `data-toggle` = "offcanvas", role = "button",
                style = "margin-right: 15px; padding: 10px; cursor: pointer;",
                icon("bars")),
      actionLink("go_dashboard", label = tags$div(
        tags$img(src = "https://drive.google.com/thumbnail?id=1SxJ_KpRwKEMhx54bQy1S07s90DIKy15n"
                 , height = "35px", style = "vertical-align: middle; margin-right: 10px;")
      ), style = "text-decoration: none; background-color: transparent; border: none;")
    ),
    titleWidth = 280
  
  ),
  #Code Sidebar  
  dashboardSidebar(
    width = 280,
    tags$style(".left-side, .main-sidebar {
                  background-color: #ffffff;
                  border-right: 1px solid #ebeced;}"),
    sidebarMenu(
      id = "tabs",
      menuItem("Dashboard", tabName = "dashboard", icon = icon("compass"), badgeColor = "green"),
      menuItem("Mental Health Checkup", tabName = "tes", icon = icon("edit"), badgeColor = "orange"),
      menuItem("Tentang Kami", tabName = "tentang", icon = icon("users"), badgeColor = "purple"),
      menuItem("Profil Pengguna", tabName = "profil", icon = icon("user"), badgeColor = "blue"),
      menuItem("Kenali Emosi", tabName = "emosi", icon = icon("face-smile"), badgeColor = "yellow"),
      tags$div(style = "padding:20px; margin-top:40px;",
               tags$img(src = "https://drive.google.com/thumbnail?id=1tbrw-By734RVt6Pde2xmwI1FfpQ6wFyD",
                        style = "width:100%; opacity:0.4;")))),
  #Code Content
  dashboardBody(
    useShinyjs(),
    tags$head(
      tags$link(href = "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap", rel="stylesheet"),
      tags$style(HTML("
 /* ====================
   1. ROOT & GLOBAL
   ==================== */
:root {
  --primary-color: #2F5CFA;
  --secondary-color: #4F46E5;
  --accent-color: #F472B6;
  --bg-color: #ffffff;
  --text-color: #37352f;
  --border-color: #e5e7eb;
}

body {
  background-color: #f8fafc;
  font-family: 'Inter', sans-serif;
  color: var(--text-color);
}


/* ====================
   2. HEADER & SIDEBAR
   ==================== */
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


/* ====================
   3. TYPOGRAPHY & HEADINGS
   ==================== */
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


/* ====================
   4. BUTTONS
   ==================== */
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


/* ====================
   5. CARDS & COMPONENTS
   ==================== */
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

.contact-card {
  padding: 16px;
  margin: 12px 0;
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

}

.news-body {
color: #7f8c8d;
font-size: 1em;
line-height: 1.6;
margin-bottom: 20px;
height: auto;
word-wrap: break-word;
overflow-wrap: break-word;
max-weight: 100px;
overflow-y: auto;
white-space: normal;
}

    .tentang-kami-card {
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

            .tentang-kami-card:hover {
              background-color: #f4f7ff;
              box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
              transform: translateY(-2px);
              cursor: pointer;
            }

            .tentang-kami-text {
              font-size: 20px;
              font-weight: 600;
              color: #2F5CFA;
              margin: 0;
            }
            
    .profil-header-card {
      display: flex;
      align-items: center;
      gap: 12px;
      background-color: #ffffff;
      border: 1px solid #e0e7ff;
      padding: 14px 20px;
      border-radius: 14px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
      transition: all 0.3s ease;
      max-width: 350px;
      margin-bottom: 30px;
    }

    .profil-header-card:hover {
      background-color: #f4f7ff;
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
      transform: translateY(-2px);
    }

    .profil-header-text {
      font-size: 22px;
      font-weight: 700;
      color: #2F5CFA;
      margin: 0;
    }


/* ====================
   6. OTHERS & UTILITIES
   ==================== */
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

.progress-bar {
  height: 6px;
  border-radius: 3px;
  background-color: #e0e7ff;
}

.progress-bar > div {
  background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
  border-radius: 3px;
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
$(document).ready(function(){
  $('body').addClass('sidebar-collapse');
});"))
      
    ),
    
    #Tampilan Awal
    tabItems(
      # Tab Profil Pengguna
      tabItem(tabName = "dashboard",
              div(class = "notion-card",
                  style = "background: linear-gradient(135deg, #dbeafe, #f8fafc);",
                  h2("Selamat Datang di Reach-Me 👋", style = "margin-bottom: 8px;"),
                  p("Mulai perjalanan kesehatan mentalmu dengan tes sederhana kami", class = "text-muted")),
              fluidRow(
                column(4,
                       div(class = "notion-card",
                           style = "cursor: pointer;",
                           onclick = "Shiny.setInputValue('open_emosi', Math.random());",
                           div(style = "display: flex; align-items: center; gap: 16px;",
                               div(style = "background: #e0e7ff; width: 48px; height: 48px; border-radius: 8px; display: flex; align-items: center; justify-content: center;",
                                   icon("children", class = "fas fa-children", style = "color: var(--primary-color);")),
                               div(h4("Kenali", style = "margin: 0;"),
                                   p("Emosimu", class = "text-muted", style = "margin: 0;"))))),
                column(4,
                       div(class = "notion-card",
                           div(style = "display: flex; align-items: center; gap: 16px;",
                               div(style = "background: #ffe0e7; width: 48px; height: 48px; border-radius: 8px; display: flex; align-items: center; justify-content: center;",
                                   icon("heart", class = "fa-lg", style = "color: #F472B6;")),
                               div(h4("Peduli", style = "margin: 0;"),
                                   p("Mendukungmu", class = "text-muted", style = "margin: 0;"))))),
                column(4,
                       div(class = "notion-card",
                           div(style = "display: flex; align-items: center; gap: 16px;",
                               div(style = "background: #dcfce7; width: 48px; height: 48px; border-radius: 8px; display: flex; align-items: center; justify-content: center;",
                                   icon("smile", class = "fa-lg", style = "color: #34d399;")),
                               div(h4("Positif", style = "margin: 0;"),
                                   p("Mentalmu", class = "text-muted", style = "margin: 0;")))))),
              div(class = "scroll-container",
                  div(class = "scroll-content",
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
              fluidRow(
                column(12, align = "center",
                       div(style = "margin-top: 30px;",
                           tags$h4("Butuh bantuan segera?"),
                           tags$a("📞 Hotline Konseling 24 Jam",
                                  href = "tel:+62895352525",
                                  class = "btn hotline-btn"))))),
      
      tabItem(tabName = "tes",
              fluidPage(
                uiOutput("tesUI"))),
      
      tabItem(tabName = "tentang",
              fluidPage(
                tags$div(class = "tentang-kami-card",
                         tags$img(src = "https://cdn-icons-png.flaticon.com/512/44/44386.png",
                                  width = "32px", height = "32px"),
                         tags$p(class = "tentang-kami-text", "Tentang Kami")),
                
                # Baris horizontal untuk Tim Kami dan Kontribusi SDGs
                fluidRow(
                  column(
                    width = 6,
                    div(class = "sdg-card",
                        tags$h4(icon("users", class = "fa-2x"), " Tim Kami", 
                                style = "color: var(--secondary-color); margin-bottom: 12px;"),
                        tags$p("Kami adalah tim multidisiplin yang berdedikasi untuk meningkatkan kesadaran kesehatan mental melalui platform digital inovatif.",
                               style = "color: var(--text-color); line-height: 1.6;"))
                  ),
                  column(
                    width = 6,
                    div(class = "sdg-card",
                        tags$h4(icon("heart", class = "fa-2x"), " Kontribusi SDGs", 
                                style = "color: var(--secondary-color); margin-bottom: 12px;"),
                        # Kotak SDG 3
                        div(style = "display: flex; align-items: center; background-color: #f9f9f9; padding: 12px; border-radius: 10px; margin-bottom: 12px;",
                            icon("heartbeat", class = "fa-2x", style = "color: #e74c3c; margin-right: 12px;"),
                            div(
                              tags$strong("SDG 3: Kesehatan & Kesejahteraan"),
                              tags$p("Mendukung kesehatan mental melalui akses layanan digital", 
                                     style = "margin: 4px 0 0 0;"))),
                        
                        # Kotak SDG 4
                        div(style = "display: flex; align-items: center; background-color: #f9f9f9; padding: 12px; border-radius: 10px;",
                            icon("graduation-cap", class = "fa-2x", style = "color: #2980b9; margin-right: 12px;"),
                            div(
                              tags$strong("SDG 4: Pendidikan Berkualitas"),
                              tags$p("Menyediakan edukasi kesehatan mental berbasis bukti ilmiah", 
                                     style = "margin: 4px 0 0 0;")))))),
                
                # Baris kontak
                fluidRow(
                  column(
                    width = 12,
                    div(
                      class = "contact-card",
                      tags$h4(
                        icon("envelope", class = "fa-2x"),
                        " Kontak",
                        style = "color: var(--secondary-color); margin: 32px 0 20px 0; font-weight: bold;"
                      ),
                      
                      # Email
                      div(
                        class = "benefit-card",
                        style = "display: flex; align-items: center; margin-bottom: 16px;",
                        icon("envelope", class = "fa-lg", style = "color: var(--primary-color); margin-right: 14px;"),
                        tags$a(
                          href = "mailto:reachmeanytime@gmail.com",
                          "reachmeanytime@gmail.com",
                          style = "color: var(--text-color); text-decoration: none; font-size: 16px; font-weight: 500;"
                        )
                      ),
                      
                      # Instagram
                      div(
                        class = "benefit-card",
                        style = "display: flex; align-items: center; border-left-color: #c13584; margin-bottom: 16px;",
                        icon("instagram", class = "fa-lg", style = "color: #c13584; margin-right: 14px;"),
                        tags$a(
                          href = "https://www.instagram.com/reachme.id/",
                          "@reachme.id",
                          style = "color: var(--text-color); text-decoration: none; font-size: 16px; font-weight: 500;"))))))),
      
      tabItem(tabName = "profil",
              fluidPage(
                tags$div(class = "profil-header-card",
                         icon("user", class = "fa-2x", style = "color: #6B21A8;"),
                         tags$p("Profil Pengguna", class = "profil-header-text")
                ),
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
                          p(item$text, style = "font-size: 1rem; color: #555555;")))}))))))))

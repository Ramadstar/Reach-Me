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
    tags$head(
      # Google Fonts
      tags$link(
        href = "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap", 
        rel = "stylesheet"
      ),
      # Viewport buat responsive
      tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
      # Link ke CSS lokal
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
      # Link ke JS lokal
      tags$script(src = "custom.js")
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
                actionButton("open_roadmap", "Mulai Roadmap", class = "btn-notion",
                             style = "margin-top: 24px; font-size: 1.14rem; border-radius: 10px;")),
              
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
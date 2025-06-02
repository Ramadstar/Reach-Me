akun_path <- "data/akun.csv"

# Buat folder "data/" kalau belum ada
if (!dir.exists("data")) dir.create("data")

# Buat file akun.csv kalau belum ada
if (!file.exists(akun_path)) {
  akun_df <- data.frame(username = character(), password = character(), stringsAsFactors = FALSE)
  write.csv(akun_df, akun_path, row.names = FALSE)
}

#Server Side
# ======= Data Pertanyaan Diperluas =======
pertanyaan <- list(
  anxiety = list(
    q1 = list(
      text = "Seberapa sering Anda merasa cemas tanpa alasan yang jelas?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q2 = list(
      text = "Apakah Anda mengalami gejala fisik saat cemas (jantung berdebar, tangan berkeringat)?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q3 = list(
      text = "Seberapa sering kecemasan mengganggu aktivitas sehari-hari?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q4 = list(
      text = "Apakah Anda menghindari situasi tertentu karena kecemasan?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q5 = list(
      text = "Seberapa sulit Anda mengontrol kekhawatiran?",
      options = c("Sangat Mudah" = 0, "Mudah" = 1, "Netral" = 2, "Sulit" = 3, "Sangat Sulit" = 4)
    )
  ),
  
  depresi = list(
    q1 = list(
      text = "Seberapa sering merasa putus asa atau tidak berharga?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q2 = list(
      text = "Seberapa sering mengalami gangguan tidur?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q3 = list(
      text = "Seberapa besar minat pada aktivitas yang biasa disukai?",
      options = c("Sangat Berminat" = 0, "Berminat" = 1, "Netral" = 2, "Kurang" = 3, "Hilang" = 4)
    ),
    q4 = list(
      text = "Seberapa sering merasa lelah tanpa alasan jelas?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q5 = list(
      text = "Seberapa sering muncul pikiran tentang kematian?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    )
  ),
  
  overthinking = list(
    q1 = list(
      text = "Seberapa sering terjebak dalam pikiran berulang?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q2 = list(
      text = "Seberapa sulit menghentikan kekhawatiran berlebihan?",
      options = c("Sangat Mudah" = 0, "Mudah" = 1, "Netral" = 2, "Sulit" = 3, "Sangat Sulit" = 4)
    ),
    q3 = list(
      text = "Seberapa sering overthinking mengganggu tidur?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q4 = list(
      text = "Seberapa sering menganalisis percakapan masa lalu?",
      options = c("Tidak Pernah" = 0, "Jarang" = 1, "Kadang" = 2, "Sering" = 3, "Selalu" = 4)
    ),
    q5 = list(
      text = "Seberapa sulit membuat keputusan karena overthinking?",
      options = c("Sangat Mudah" = 0, "Mudah" = 1, "Netral" = 2, "Sulit" = 3, "Sangat Sulit" = 4)
    )
  )
)

#Server Side
function(input, output, session) {
  rv <- reactiveValues(
    current_category = 1,
    current_question = 1,
    answers = list(),
    categories = c("anxiety", "depresi", "overthinking"),
    selected_option = NULL,
    mulaiTes= FALSE,
    showWelcome = TRUE
  )
  
  # Reactive untuk simpan status login
  user_login <- reactiveValues(logged_in = FALSE, username = NULL)
  total_questions <- function(category) length(pertanyaan[[category]])
  
  observe({
    session$sendCustomMessage("setDarkMode", input$dark_mode)
  })
  
  current_q <- reactive({
    category <- rv$categories[rv$current_category]
    pertanyaan[[category]][[rv$current_question]]
  })
  
  observe({
    req(current_q())
    lapply(seq_along(current_q()$options), function(i) {
      observeEvent(input[[paste0("opt", i)]], {
        rv$selected_option <- names(current_q()$options)[i]
      }, ignoreInit = TRUE)
      observeEvent(input$mulaiTes, {
        rv$mulaiTes <- TRUE
      })
    })
  })
  
  output$tesUI <- renderUI({
    if (!rv$mulaiTes) {
      # Halaman awal sebelum tes
      tagList(
        div(style = "display: flex; justify-content: center; align-items: center; padding: 40px 16px;",
            div(class = "notion-card",
                style = "background-color: #ffffff; border-radius: 16px; padding: 32px 24px; max-width: 720px; width: 100%; box-shadow: 0 6px 20px rgba(0,0,0,0.05);",
                
                # Judul
                div(style = "text-align: center; margin-bottom: 24px;",
                    tags$h2("Mental Health Checkup", 
                            style = "font-family: 'Inter', sans-serif; font-weight: 700; font-size: 2rem; color: #2F5CFA; margin-bottom: 8px;"),
                    tags$p("Luangkan waktumu sebentar untuk mengenali kondisi mentalmu.", 
                           style = "color: #6b7280; font-size: 1.05rem; margin: 0;")
                ),
                
                # Highlight Tes
                div(style = "display: flex; flex-wrap: wrap; justify-content: space-between; gap: 12px; margin-bottom: 28px;",
                    lapply(
                      list(
                        list(icon = "brain", text = "Tingkat Kecemasan", color = "#6366F1"),
                        list(icon = "heart", text = "Gejala Depresi", color = "#EF4444"),
                        list(icon = "comment", text = "Overthinking", color = "#F59E0B")
                      ),
                      function(item) {
                        div(class = paste("test-badge", 
                                          if (item$text == "Tingkat Kecemasan") "test-kecemasan" else 
                                            if (item$text == "Gejala Depresi") "test-depresi" else 
                                              "test-overthinking"),
                            icon(item$icon, class = "fa-lg", style = paste0("color:", item$color, ";")),
                            tags$span(item$text)
                        )
                      })
                ),
                
                tags$hr(style = "margin: 32px 0; border: none; border-top: 1px solid #e5e7eb;"),
                
                # Manfaat dalam bentuk cards
                tags$h4("Apa manfaat yang akan kamu dapatkan?", 
                        style = "color: #374151; margin-bottom: 20px; font-weight: 600; text-align: center; font-size: 1.15rem;"),
                
                div(style = "display: flex; flex-direction: column; gap: 16px; margin-bottom: 32px;",
                    lapply(
                      list(
                        list(title = "Analisis kondisi mental pribadi", 
                             desc = "Membantu kamu memahami perasaan dan gejala yang mungkin sedang kamu alami."),
                        list(title = "Rekomendasi tindakan sesuai hasil", 
                             desc = "Kami akan memberikan saran dan langkah awal yang bisa kamu lakukan berdasarkan jawabanmu."),
                        list(title = "Akses ke sumber bantuan profesional", 
                             desc = "Jika dibutuhkan, kamu akan diarahkan ke bantuan lebih lanjut yang bisa kamu jangkau.")
                      ),
                      function(card) {
                        div(class = "benefit-card",
                            tags$strong(card$title),
                            tags$p(card$desc, style = "margin-top: 6px; color: #555; font-size: 0.95rem; line-height: 1.5;"))
                      })
                ),
                
                # Tombol Assessment
                div(style = "margin-top: 12px;",
                    actionButton("mulaiTes", "Mulai Assessment", 
                                 class = "btn-notion",
                                 style = "width: 100%; font-size: 1.2rem; padding: 14px; border-radius: 12px; background: linear-gradient(90deg, #4F46E5, #6366F1); color: white; border: none; font-weight: 600;")
                ),
                
                # Catatan privasi
                tags$p("Hasil dan data kamu akan dijaga kerahasiaannya.", 
                       style = "text-align: center; font-size: 1rem; color: #4B5563; margin-top: 24px; font-weight: 500;")
            )
        )
      )
      
    } else {
      # Halaman soal
      tagList(
        titlePanel(tags$h2("Mental Health Meter", style = "color: #2c3e50; font-weight: 700;")),
        div(class = "container",
            uiOutput("questionUI"),
            uiOutput("navigationUI")
        )
      )
    }
  })
  
  
  output$questionUI <- renderUI({
    req(current_q())
    
    category <- rv$categories[rv$current_category]
    question <- current_q()
    
    icon_emosi <- switch(category,
                         "anxiety" = "🧠",
                         "depresi" = "💔",
                         "overthinking" = "💭")
    
    # Progress bar
    progress <- round((rv$current_question / total_questions(category)) * 100)
    
    tagList(
      div(class = "notion-card",
          
          # MINI CARD untuk kategori (dengan warna & deskripsi)
          div(style = "margin-bottom: 20px;",
              div(
                class = "mini-category-card",  # <--- Tambahkan ini!
                style = paste0(
                  "background-color: ",
                  switch(category,
                         "anxiety" = "#E0F2FE",
                         "depresi" = "#FEE2E2",
                         "overthinking" = "#FEF9C3"),
                  "; border-radius: 12px; padding: 14px 20px; max-width: 320px; box-shadow: 0 2px 8px rgba(0,0,0,0.05);"
                ),
                div(style = "display: flex; align-items: center;",
                    span(style = "font-size: 24px; margin-right: 12px;",
                         switch(category,
                                "anxiety" = "🧠",
                                "depresi" = "💔",
                                "overthinking" = "💭")),
                    div(
                      h4(style = "margin: 0; font-weight: 700; font-size: 24px;",
                         switch(category,
                                "anxiety" = "Anxiety",
                                "depresi" = "Depresi",
                                "overthinking" = "Overthinking"))
                    )
                ))
          ),
          
          # Progress bar
          tags$div(class = "progress-bar", style = "margin-bottom: 16px;",
                   tags$div(style = paste0("width:", progress, "%; height: 6px;"),
                            class = "bg-primary")),
          
          # Pertanyaan
          h5(paste("Pertanyaan", rv$current_question, "dari", total_questions(category)), 
             style = "color: #555; margin-bottom: 12px;"),
          h4(question$text, style = "margin-bottom: 24px;"),
          
          # Opsi jawaban
          lapply(seq_along(question$options), function(i) {
            opt_label <- names(question$options)[i]
            actionButton(
              inputId = paste0("opt", i),
              label = opt_label,
              class = paste("btn-option", ifelse(opt_label == rv$selected_option, "selected", "")),
              width = "100%"
            )
          })
      )
    )
  })
  
  # Login UI
  output$login_ui <- renderUI({
    if (!user_login$logged_in) {
      tagList(
        div(class = "login-card", style = "
        max-width: 420px;
        margin: 40px auto;
        padding: 30px;
        border-radius: 16px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.05);",
            
            tags$h3("Silakan Masuk atau Daftar", style = "text-align: center; color: #2F5CFA; font-weight: 700; margin-bottom: 20px;"),
            
            tabsetPanel(id = "auth_tab",
                        tabPanel("Login",
                                 br(),
                                 textInput("login_user", "Username", placeholder = "Masukkan username", width = "100%"),
                                 passwordInput("login_pass", "Password", placeholder = "Masukkan password", width = "100%"),
                                 div(style = "text-align: right; margin-top: 20px;",
                                     actionButton("login_btn", "🔐 Login",
                                                  style = "padding: 10px 20px; font-weight: 600; background-color: #4F46E5; color: white; border: none; border-radius: 10px;")
                                 )
                        ),
                        tabPanel("Sign Up",
                                 br(),
                                 textInput("signup_user", "Buat Username", placeholder = "Username baru", width = "100%"),
                                 passwordInput("signup_pass", "Buat Password", placeholder = "Password baru", width = "100%"),
                                 div(style = "text-align: right; margin-top: 20px;",
                                     actionButton("signup_btn", "✍️ Daftar",
                                                  style = "padding: 10px 20px; font-weight: 600; background-color: #10B981; color: white; border: none; border-radius: 10px;")
                                 )
                        )
            )
        )
      )
    } else {
      h4(paste("Selamat datang,", user_login$username))
    }
  })
  
  # Sign Up Process
  observeEvent(input$signup_btn, {
    req(input$signup_user, input$signup_pass)
    
    akun_df <- if (file.exists(akun_path)) {
      read.csv(akun_path, stringsAsFactors = FALSE)
    } else {
      data.frame(username = character(), password = character(), stringsAsFactors = FALSE)
    }
    
    if (input$signup_user %in% akun_df$username) {
      showModal(modalDialog("Username sudah digunakan.", easyClose = TRUE))
    } else {
      akun_df <- rbind(akun_df, data.frame(username = input$signup_user, password = input$signup_pass))
      write.csv(akun_df, akun_path, row.names = FALSE)
      showModal(modalDialog("Akun berhasil dibuat! Silakan login.", easyClose = TRUE))
    }
  })
  
  # Login Process
  observeEvent(input$login_btn, {
    req(input$login_user, input$login_pass)
    
    if (file.exists(akun_path)) {
      akun_df <- read.csv(akun_path, stringsAsFactors = FALSE)
      user_row <- akun_df[akun_df$username == input$login_user & akun_df$password == input$login_pass, ]
      
      if (nrow(user_row) == 1) {
        user_login$logged_in <- TRUE
        user_login$username <- input$login_user
        
        path_profil <- paste0("data/profil_", input$login_user, ".rds")
        if (!file.exists(path_profil)) {
          profil_default <- list(nama = "", usia = NA, gender = "", goal = "")
          saveRDS(profil_default, path_profil)
        }
        
        profil <- readRDS(path_profil)
        updateTextInput(session, "nama", value = profil$nama)
        updateNumericInput(session, "usia", value = profil$usia)
        updateSelectInput(session, "gender", selected = profil$gender)
        updateTextAreaInput(session, "goal", value = profil$goal)
        
        showModal(modalDialog(
          title = "Login Berhasil",
          paste("Selamat datang,", input$login_user, "!"),
          easyClose = TRUE,
          footer = modalButton("Lanjut")
        ))
      } else {
        showModal(modalDialog("Username atau password salah.", easyClose = TRUE))
      }
    } else {
      showModal(modalDialog("Belum ada akun terdaftar.", easyClose = TRUE))
    }
  })
  
  # Simpan profil
  observeEvent(input$simpan_profil, {
    req(user_login$logged_in)
    
    profil <- list(
      nama = input$nama,
      usia = input$usia,
      gender = input$gender,
      goal = input$goal
    )
    
    path <- paste0("data/profil_", user_login$username, ".rds")
    saveRDS(profil, path)
    
    showModal(modalDialog(
      title = "✅ Data Tersimpan",
      "Informasi pribadi kamu berhasil disimpan.",
      easyClose = TRUE
    ))
  })
  
  # Reactive status untuk conditionalPanel
  output$userLoggedIn <- reactive({
    user_login$logged_in
  })
  outputOptions(output, "userLoggedIn", suspendWhenHidden = FALSE)
  
  output$navigationUI <- renderUI({
    disable_next <- is.null(rv$selected_option)
    is_last_question <- rv$current_category == length(rv$categories) && 
      rv$current_question == total_questions(rv$categories[rv$current_category])
    
    fluidRow(
      column(6,
             actionButton("prevBtn", label = "Sebelumnya",
                          style = "background: #7BD5F5; color: white;",
                          disabled = FALSE)
      ),
      column(6, align = "right",
             if (is_last_question) {
               actionButton("submit", label = "Lihat Hasil 💖",
                            style = "background: #FF6B6B; color: white;",
                            disabled = disable_next)
             } else {
               actionButton("nextBtn", label = "Berikutnya",
                            style = "background: #4ECDC4; color: white;",
                            disabled = disable_next)
             }
      )
    )
  })
  
  save_answer <- function() {
    if (!is.null(rv$selected_option)) {
      category <- rv$categories[rv$current_category]
      question <- current_q()
      rv$answers[[paste0(category, "_q", rv$current_question)]] <- question$options[[rv$selected_option]]
    }
  }
  
  load_previous_answer <- function() {
    category <- rv$categories[rv$current_category]
    key <- paste0(category, "_q", rv$current_question)
    
    if (key %in% names(rv$answers)) {
      options <- pertanyaan[[category]][[rv$current_question]]$options
      rv$selected_option <- names(options)[options == rv$answers[[key]]]
    } else {
      rv$selected_option <- NULL
    }
  }
  
  observeEvent(input$go_dashboard, {
    updateTabItems(session, "tabs", "dashboard")
  })
  
  observeEvent(input$open_emosi, {
    updateTabItems(session, "tabs", "emosi")
  })
  
  observeEvent(input$nextBtn, {
    save_answer()
    
    if (rv$current_question < total_questions(rv$categories[rv$current_category])) {
      rv$current_question <- rv$current_question + 1
    } else if (rv$current_category < length(rv$categories)) {
      rv$current_category <- rv$current_category + 1
      rv$current_question <- 1
    }
    
    load_previous_answer()
  })
  
  observeEvent(input$prevBtn, {
    save_answer()
    
    if (rv$current_category == 1 && rv$current_question == 1) {
      rv$mulaiTes <- FALSE
    } else if (rv$current_question > 1) {
      rv$current_question <- rv$current_question - 1
    } else if (rv$current_category > 1) {
      rv$current_category <- rv$current_category - 1
      rv$current_question <- total_questions(rv$categories[rv$current_category])
    }
    
    load_previous_answer()
  })
  
  observeEvent(input$btn_home, {
    rv$mulaiTes <- FALSE
    updateTabItems(session, "tabs", "dashboard")
  })
  
  observeEvent(input$btn_ulang, {
    removeModal()
    rv$mulaiTes <- TRUE
    rv$current_category <- 1
    rv$current_question <- 1
    rv$answers <- list()
    rv$selected_option <- NULL
  })
  
  observeEvent(input$btn_rekom, {
    removeModal()
    updateTabItems(session, "tabs", "profil")
  })
  
  observeEvent(input$submit, {
    save_answer()
    
    anxiety_score <- sum(unlist(rv$answers[grep("anxiety", names(rv$answers))]))
    depresi_score <- sum(unlist(rv$answers[grep("depresi", names(rv$answers))]))
    overthinking_score <- sum(unlist(rv$answers[grep("overthinking", names(rv$answers))]))
    
    rv$riwayat_anxiety <- anxiety_score
    rv$riwayat_depresi <- depresi_score
    rv$riwayat_overthinking <- overthinking_score
    rv$waktu_tes_terakhir <- Sys.time()
    
    # Simpan hasil ke file berdasarkan akun login
    if (user_login$logged_in)
      isolate({
        username <- user_login$username
        file_path <- paste0("data/riwayat_", username, ".rds")
        
        hasil_baru <- data.frame(
          waktu = rv$waktu_tes_terakhir,
          anxiety = rv$riwayat_anxiety,
          depresi = rv$riwayat_depresi,
          overthinking = rv$riwayat_overthinking,
          stringsAsFactors = FALSE
        )
        
        if (file.exists(file_path)) {
          riwayat_lama <- readRDS(file_path)
          riwayat <- rbind(riwayat_lama, hasil_baru)
        } else {
          riwayat <- hasil_baru
        }
        
        saveRDS(riwayat, file_path)
      })
    
    # ✅ Tampilkan modal hasil & visualisasi
    showModal(modalDialog(
      title = tags$div(icon("heart", class = "fa-lg", style = "color:#F472B6; margin-right:10px;")),
      fluidRow(
        column(12, align = "center",
               tags$h4("Distribusi Skor Mentalmu", style = "color:#2F5CFA; font-weight:700; margin-top:20px;"),
               plotOutput("resultDonut", height = "280px")
        )
      ),
      hr(),
      tags$div(style="padding: 0 20px;",
               tags$h5("📌 Rangkuman & Rekomendasi", style = "font-weight:600; color:#374151;"),
               tags$ul(
                 class = "rekomendasi-list",
                 tags$li("🧘 Cobalah teknik pernapasan dalam saat merasa cemas."),
                 tags$li("📚 Bacalah artikel tentang kesehatan mental yang ringan dan positif."),
                 tags$li("🗣️ Pertimbangkan konsultasi profesional jika keluhan mengganggu keseharian.")
               ),
               tags$p("*Ini bukan diagnosis medis. Jika kamu merasa butuh bantuan segera, hubungi profesional.*",
                      style = "font-size: 0.9rem; color: #9CA3AF; margin-top: 20px; text-align: center;")
      ),
      footer = tagList(
        actionButton("btn_rekom", "Lihat Profil", class = "btn-notion"),
        actionButton("btn_ulang", "Ulangi Tes", class = "btn-notion", style = "background:#4ECDC4;"),
        actionButton("btn_backtes", "Kembali ke Sebelum Tes", class = "btn-notion", style = "background:#9CA3AF;")
      ),
      size = "l",
      easyClose = TRUE
    ))
    
    # Chart dalam modal
    output$resultDonut <- renderPlot({
      is_dark <- isTRUE(input$dark_mode) # deteksi dark mode
      
      bg_col <- if (is_dark) "#222336" else "#fff"
      fg_col <- if (is_dark) "#f4f4f9" else "#222"
      grid_col <- if (is_dark) "#55596c" else "#bbb"
      border_col <- if (is_dark) "#888ea8" else "#333"
      
      df <- data.frame(
        Dimensi = c("Anxiety", "Depresi", "Overthinking"),
        Skor = c(anxiety_score, depresi_score, overthinking_score) * 5,
        Warna = c("#FF6B6B", "#4ECDC4", "#FF9F8E")
      )
      
      par(mfrow = c(1, 3), mar = c(1, 1, 4, 1), bg = bg_col)
      for (i in 1:3) {
        slices <- c(df$Skor[i], 100 - df$Skor[i])
        cols <- c(df$Warna[i], grid_col)
        # Set color judul pakai parameter 'col.main'
        pie(
          slices, labels = NA, col = cols, 
          main = df$Dimensi[i],
          col.main = fg_col, # judul donut
          cex.main = 1.2,
          radius = 1, 
          init.angle = 90, 
          border = NA
        )
        # Outline donut tengah dan text di tengah
        symbols(0, 0, circles = 0.6, inches = FALSE, add = TRUE, bg = bg_col, fg = border_col)
        text(0, 0, df$Skor[i], cex = 1.5, font = 2, col = fg_col)
      }
    })
  })
  
  output$mentalHealthHistory <- renderPlot({
    req(user_login$logged_in)
    
    path <- paste0("data/riwayat_", user_login$username, ".rds")
    if (!file.exists(path)) {
      plot.new()
      title("Belum ada riwayat tes")
      return()
    }
    df <- readRDS(path)
    print(df) # debug
    str(df)   # debug
    
    if (nrow(df) == 0) {
      plot.new()
      title("Belum ada riwayat tes")
      return()
    }
    
    # Cek manual: Apakah semua kolom wajib ada?
    needed <- c("anxiety", "depresi", "overthinking", "waktu")
    if (!all(needed %in% names(df))) {
      plot.new()
      title("Data riwayat tidak valid/kolom hilang")
      return()
    }
    
    # Ubah ke long format untuk ggplot
    library(tidyr)
    library(ggplot2)
    df_long <- tidyr::pivot_longer(
      df,
      cols = c(anxiety, depresi, overthinking),
      names_to = "kategori",
      values_to = "skor"
    )
    print(df_long) # debug
    
    if (nrow(df_long) == 0) {
      plot.new()
      title("Belum ada data tes")
      return()
    }
    
    # Fix: Pastikan waktu bisa diparse
    df_long$waktu <- as.POSIXct(df_long$waktu)
    if (all(is.na(df_long$waktu))) {
      plot.new()
      title("Waktu tidak valid di riwayat")
      return()
    }
    
    # Plot
    ggplot(df_long, aes(x = waktu, y = skor, color = kategori, group = kategori)) +
      geom_line(size = 1.2) +
      geom_point(size = 2) +
      labs(title = "Perkembangan Skor Mental Health",
           x = "Waktu Tes", y = "Skor", color = "Kategori") +
      theme_minimal(base_size = 13) +
      theme(
        plot.background = element_rect(fill = if (isTRUE(input$dark_mode)) "#222336" else "#fff", color = NA),
        panel.background = element_rect(fill = if (isTRUE(input$dark_mode)) "#222336" else "#fff", color = NA),
        text = element_text(color = if (isTRUE(input$dark_mode)) "#f4f4f9" else "#222"),
        axis.text = element_text(color = if (isTRUE(input$dark_mode)) "#f4f4f9" else "#222"),
        axis.title = element_text(color = if (isTRUE(input$dark_mode)) "#f4f4f9" else "#222"),
        plot.title = element_text(color = if (isTRUE(input$dark_mode)) "#f4f4f9" else "#222", face = "bold"),
        legend.background = element_rect(fill = if (isTRUE(input$dark_mode)) "#222336" else "#fff", color = NA),
        legend.text = element_text(color = if (isTRUE(input$dark_mode)) "#f4f4f9" else "#222"),
        legend.title = element_text(color = if (isTRUE(input$dark_mode)) "#f4f4f9" else "#222")
      )
  })
  
  observeEvent(input$btn_backtes, {
    removeModal()
    rv$mulaiTes <- FALSE
    updateTabItems(session, "tabs", "tes")
  })
  
  output$riwayat_anxiety <- renderText({
    req(rv$riwayat_anxiety)
    paste("Skor Anxiety terakhir:", rv$riwayat_anxiety)
  })
  
  output$riwayat_depresi <- renderText({
    req(rv$riwayat_depresi)
    paste("Skor Depresi terakhir:", rv$riwayat_depresi)
  })
  
  output$riwayat_overthinking <- renderText({
    req(rv$riwayat_overthinking)
    paste("Skor Overthinking terakhir:", rv$riwayat_overthinking)
  })
  
  output$waktu_tes_terakhir <- renderText({
    req(rv$waktu_tes_terakhir)
    paste("Tes terakhir dilakukan pada:", format(rv$waktu_tes_terakhir, "%d %B %Y, %H:%M"))
  })
  
  output$rekomendasiUI <- renderUI({
    tagList(
      tags$img(src = "https://i.imgur.com/Qw3PKMm.png", height = "180px", style = "display:block; margin:auto; margin-bottom:20px;"),
      h4("Hasil Evaluasi Mentalmu", style = "text-align:center; color:#2F5CFA; font-weight:bold; margin-bottom:20px;"),
      
      h5("📊 Ringkasan Skor", style = "color:#374151;"),
      plotOutput("resultPlot", height = "250px"),
      
      hr(),
      
      h5("📌 Deskripsi dan Rekomendasi", style = "color:#374151; margin-top:20px;"),
      tags$ul(
        tags$li("🧘 Cobalah teknik relaksasi ringan untuk mengurangi kecemasan."),
        tags$li("📚 Luangkan waktu membaca konten positif setiap hari."),
        tags$li("🗣️ Konsultasi dengan profesional bila gejala berlanjut.")
      ),
      
      hr(),
      
      fluidRow(
        column(4, align = "center",
               actionButton("btn_rekom", "Lihat Rekomendasi", class = "btn-notion")),
        column(4, align = "center",
               actionButton("btn_ulang", "Ulangi Tes", class = "btn-notion", style = "background-color:#4ECDC4;")),
        column(4, align = "center",
               actionButton("btn_home", "Kembali ke Beranda", class = "btn-notion", style = "background-color:#94A3B8;"))
      ),
      
      tags$p("*Ini bukan diagnosis medis. Jika kamu merasa butuh bantuan segera, hubungi profesional.*",
             style = "font-size: 0.9rem; color: #9CA3AF; margin-top: 20px; text-align: center;")
    )
  })
}

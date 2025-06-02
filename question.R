# ======= Data Pertanyaan =======
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
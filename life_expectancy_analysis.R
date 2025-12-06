# ==============================================================================
# PROJE: YAŞAM SÜRESİNİ ETKİLEYEN FAKTÖRLERİN ANALİZİ
# ==============================================================================

# 1. GEREKLİ KÜTÜPHANELERİN YÜKLENMESİ
# ------------------------------------------------------------------------------
library(corrplot) # Korelasyon matrisi görselleştime
library(lmtest)   # Breusch-Pagan ve Durbin-Watson testleri
library(car)      # VIF testi ve diğer diyagnostikler

# ------------------------------------------------------------------------------
# 2. VERİ SETİNİN OLUŞTURULMASI
# ------------------------------------------------------------------------------
# Bağımlı Değişken (Y) : Yasam_Suresi
# Bağımsız Değişken (X1): Saglik_Harcamasi
# Bağımsız Değişken (X2): GSYIH_Kisi_Basi

Veri <- data.frame(
  Yil = 2000:2021,
  Yasam_Suresi = c(71.3, 71.6, 72.0, 72.4, 72.8, 73.2, 73.6, 74.0, 74.3, 74.7, 
                   75.1, 75.5, 75.8, 76.2, 76.5, 76.8, 77.1, 77.4, 77.7, 77.9, 78.1, 78.6),
  Saglik_Harcamasi = c(220, 245, 290, 360, 450, 530, 600, 700, 810, 850, 
                       920, 1050, 1100, 1120, 1090, 1050, 1080, 1110, 1100, 1150, 1200, 1250),
  GSYIH_Kisi_Basi = c(4260, 3140, 3620, 4400, 5800, 7200, 7800, 9300, 10800, 9000, 
                      10700, 12500, 13100, 12600, 12100, 11000, 11200, 10600, 9400, 9600, 8600, 9600)
)

# Verinin ilk 6 satırını kontrol et
head(Veri)

# ------------------------------------------------------------------------------
# 3. BETİMSEL İSTATİSTİKLER VE DAĞILIMLAR
# ------------------------------------------------------------------------------
summary(Veri)

# Grafikleri yan yana çizdirmek için ekranı bölüyoruz (1 satır, 3 grafik)
par(mfrow=c(1,3))

hist(Veri$Yasam_Suresi, 
     main="Yaşam Süresi Dağılımı", xlab="Yıl", col="darkblue", border="white")

hist(Veri$Saglik_Harcamasi, 
     main="Sağlık Harcaması Dağılımı", xlab="ABD Doları", col="darkred", border="white")

hist(Veri$GSYIH_Kisi_Basi, 
     main="GSYİH Dağılımı", xlab="ABD Doları", col="darkgreen", border="white")

# Grafik ayarlarını sıfırla
par(mfrow=c(1,1))

# ------------------------------------------------------------------------------
# 4. KORELASYON ANALİZİ
# ------------------------------------------------------------------------------
# Değişkenler arasındaki ilişkiyi inceliyoruz
korelasyon_matrisi <- cor(Veri[c("Yasam_Suresi", "Saglik_Harcamasi", "GSYIH_Kisi_Basi")])
corrplot(korelasyon_matrisi, method = "number", type = "upper", tl.col = "black")


# ------------------------------------------------------------------------------
# 5. ÇOKLU DOĞRUSAL REGRESYON MODELİ
# ------------------------------------------------------------------------------
# Model: Yaşam Süresi ~ Sağlık Harcaması + GSYİH
model <- lm(Yasam_Suresi ~ Saglik_Harcamasi + GSYIH_Kisi_Basi, data = Veri)

# Model Sonuçları
summary(model)


# ------------------------------------------------------------------------------
# 6. VARSAYIM TESTLERİ (MODEL GÜVENİLİRLİĞİ)
# ------------------------------------------------------------------------------

# --- A) ARTIKLARIN NORMALLİĞİ ---
# H0: Artıklar normal dağılım gösterir.
# Yorum: p-değeri > 0.05 ise H0 reddedilemez (Normallik sağlanır).
print(shapiro.test(model$residuals))

# Normallik Grafiği (Q-Q Plot)
qqnorm(model$residuals, main = "Artıkların Normallik Grafiği (Q-Q Plot)", pch = 19)
qqline(model$residuals, col = "darkred", lwd = 2)


# --- B) DEĞİŞEN VARYANS (HOMOSKEDASTİSİTE) ---
# H0: Değişen varyans sorunu yoktur (Varyans sabittir).
# Yorum: p-değeri > 0.05 ise H0 reddedilemez (Varsayım sağlanır).
print(bptest(model))

# Saçılım Grafiği
plot(model$fitted.values, model$residuals,
     main = "Artıkların Saçılım Grafiği",
     xlab = "Tahmin Edilen Değerler", ylab = "Artıklar", pch = 19, col = "blue")
abline(h=0, col = "red", lwd = 2)


# --- C) OTOKORELASYON (DURBIN-WATSON) ---
# H0: Otokorelasyon yoktur.
# Yorum: DW istatistiği 2'ye yakınsa ve p > 0.05 ise sorun yoktur.
print(dwtest(model))


# --- D) ÇOKLU BAĞLANTI (MULTICOLLINEARITY) ---
# Bağımsız değişkenler arasındaki korelasyona bakıyoruz.
# Yorum: Katsayı 0.80'den büyükse güçlü ilişki vardır (Çoklu bağlantı riski).
print(cor(Veri[c("Saglik_Harcamasi", "GSYIH_Kisi_Basi")]))

# Alternatif: VIF Testi (Variance Inflation Factor)
# car kütüphanesi yüklü olduğu için bunu da kullanabilirsin. 
# Yorum: VIF değeri 10'dan (bazı kaynaklara göre 5'ten) küçük olmalı.
print(vif(model))

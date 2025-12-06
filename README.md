# Life Expectancy Prediction Model 🏥📊

Bu proje, ülkelerin ekonomik ve sağlık harcaması göstergelerinin ortalama yaşam süresi üzerindeki etkisini analiz etmek ve istatistiksel modelleme yapmak amacıyla geliştirilmiştir.

## 📂 Veri Seti ve Değişkenler
Analiz modelinde 2000-2021 yılları arasındaki şu veriler kullanılmıştır:

* **Bağımlı Değişken (Target):** Ortalama Yaşam Süresi (Yıl)
* **Bağımsız Değişkenler (Features):**
  * *Kişi Başı Sağlık Harcaması ($):* Sağlık sistemine yapılan yatırımın etkisi.
  * *Kişi Başı GSYİH ($):* Ekonomik refah düzeyinin etkisi.

## 🛠 Kullanılan Yöntemler
Proje kapsamında aşağıdaki R kütüphaneleri ve istatistiksel yöntemler kullanılmıştır:

* **Veri Görselleştirme:** Histogramlar ve dağılım grafikleri.
* **Korelasyon Analizi:** Değişkenler arası ilişkinin şiddetinin ölçülmesi (Corrplot).
* **Çoklu Doğrusal Regresyon:** `lm()` fonksiyonu ile tahmin modelinin kurulması.
* **Varsayım Testleri (Model Güvenirliği):**
  * *Shapiro-Wilk:* Hataların normallik testi.
  * *Breusch-Pagan:* Değişen varyans testi.
  * *Durbin-Watson:* Otokorelasyon testi.

## 🚀 Sonuç
Model çıktıları, ekonomik refah artışı ve sağlık harcamalarındaki yükselişin, beklenen yaşam süresi üzerinde pozitif ve istatistiksel olarak anlamlı bir etkisi olduğunu kanıtlamaktadır.

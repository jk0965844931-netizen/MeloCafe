# Quick Start - เริ่มต้นอย่างรวดเร็ว (Thai)

เวอร์ชัน iOS ของ MeloCafe พร้อมแล้ว! นี่คือวิธีเริ่มต้น:

## ขั้นตอนการติดตั้ง (Thai)

### 1. ดาวน์โหลด IPA
ไปที่ GitHub Actions: https://github.com/jk0965844931-netizen/MeloCafe/actions
- คลิก build ล่าสุด (ดูที่ด้านล่างสุด)
- ดาวน์โหลดไฟล์ `MeloCafe-iOS-arm64-unsigned.zip`
- แตกไฟล์ zip จะได้ MeloCafe.ipa

### 2. ติดตั้ง LiveContainer (ถ้ายังไม่มี)

**วิธีผ่าน AltStore:**
1. เปิด AltStore บน iPhone
2. แตะ "Browse"
3. ค้นหา "LiveContainer"
4. แตะ "Install" ข้าง LiveContainer
5. รอจนถึงเสร็จ

### 3. นำเข้าไฟล์ IPA
1. เปิด LiveContainer บน iPhone
2. แตะปุ่ม "+"
3. เลือก "Import from Files"
4. ค้นหาไฟล์ MeloCafe.ipa
5. แตะเพื่อเปิด
6. รอจนถึงเสร็จ (ประมาณ 1-2 นาที)

### 4. เริ่มเล่นเกม
1. เปิด MeloCafe จาก LiveContainer
2. คัดลอกไฟล์เกม (.wud, .wux) ไปที่ Documents
3. ใน MeloCafe เปิดไฟล์เกม
4. เล่นได้เลย!

## Quick Start (English)

### 1. Download IPA
Go to GitHub Actions: https://github.com/jk0965844931-netizen/MeloCafe/actions
- Click the latest build (bottom of the list)
- Download `MeloCafe-iOS-arm64-unsigned.zip`
- Extract to get MeloCafe.ipa

### 2. Install LiveContainer (if not already installed)

**Via AltStore:**
1. Open AltStore on iPhone
2. Tap "Browse"
3. Search "LiveContainer"
4. Tap "Install" next to LiveContainer
5. Wait for installation to complete

### 3. Import IPA
1. Open LiveContainer on iPhone
2. Tap the "+" button
3. Select "Import from Files"
4. Locate MeloCafe.ipa
5. Tap to open
6. Wait for installation (1-2 minutes)

### 4. Start Playing
1. Launch MeloCafe from LiveContainer
2. Copy game files (.wud, .wux) to Documents folder
3. Load the game in MeloCafe
4. Enjoy!

## ข้อกำหนด (Requirements / ความต้องการ)

### Minimum / ขั้นต่ำสุด
- **iPhone**: iPhone 8 หรือใหม่กว่า
- **iOS**: 14.0 หรือใหม่กว่า
- **RAM**: 3GB ขึ้นไป
- **พื้นที่**: 2GB ว่างสำหรับ emulator + เกม

### Recommended / แนะนำ
- **iPhone**: iPhone 12 หรือใหม่กว่า (ประสิทธิภาพดีกว่า)
- **iOS**: 15.0 หรือใหม่กว่า
- **RAM**: 4GB ขึ้นไป
- **Controller**: MFi controller (optional / ไม่จำเป็น)

## ปัญหาที่รู้จัก (Known Issues)

⚠️ **ระยะพัฒนาเริ่มต้น** (Early Development / Work in Progress)

- Build อาจล้มเหลวในครั้งแรก (normal)
- เกมบางเกมอาจยังไม่ทำงาน
- Performance แตกต่างกันตาม device

## การแก้ปัญหา (Troubleshooting)

### App ค้าง/ปิดทันที (App Crashes)
- ตรวจสอบว่า LiveContainer ติดตั้งแล้ว
- ตรวจสอบ iOS version (14.0+)
- ลอง install IPA ใหม่

### JIT ไม่ทำงาน (JIT Not Working)
- LiveContainer จะเปิด JIT อัตโนมัติ
- ถ้า emulator ช้ามาก อาจ JIT ไม่ทำงาน
- ลองปิด-เปิด LiveContainer ใหม่

### เกมโหลดไม่ได้ (Games Won't Load)
- ตรวจสอบไฟล์เกม (.wud, .wux)
- ตรวจสอบว่ามีพื้นที่ว่างพอ
- ลองเกมอื่น

### Controller ไม่ตรวจจับ (Controller Not Detected)
- Unpair และ pair controller ใหม่
- ลอง controller อื่น
- ใช้ touch controls แทน

## เอกสารเพิ่มเติม (Additional Docs)

- [คู่มือ LiveContainer ละเอียด](docs/LiveContainer-Guide.md)
- [วิธี build เองบน Mac](docs/MacOS-Build-Guide.md)
- [ปัญหาที่รู้จัก](KNOWN-ISSUES.md)
- [คำถามที่พบบ่อย](README-IOS.md)

## การรับการช่วยเหลือ (Support)

📱 **GitHub Issues**: https://github.com/jk0965844931-netizen/MeloCafe/issues
💬 **Discord**: https://discord.gg/5psYsup

## Game Files (ไฟล์เกม)

รูปแบบที่รองรับ (Supported formats):
- `.wud` - Raw Wii U disc image
- `.wux` - Compressed disc image (แนะนำ)
- `.wua` - Wii U Archive

ไม่รองรับ (Not supported):
- `.iso` - Different format

---

**Status**: 🚧 Early Development (~30% complete / พัฒนาไปแล้ว ~30%)
**Last Updated**: 2026-05-22
**Version**: 0.1 (alpha / เวอร์ชันทดลอง)

💚 **ขอบคุณที่ใช้ MeloCafe iOS!** (Thanks for using MeloCafe iOS!)
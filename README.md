# Daily Win Tracker 🏆

A personal achievement tracker built with **Flutter** and **Firebase**. This project marks my "v1.0" milestone in mobile development, focusing on real-time data synchronization and secure user state management.

---

## 🤖 The "AI-Pair Programming" Journey

For this project, I adopted a **Human-AI Collaboration** model, using **Google Gemini** as a senior thought partner. Rather than simply generating code, I used AI to accelerate my learning curve in the following ways:

* **Architectural Strategy:** We discussed the trade-offs between NoSQL (Firebase) and Relational (Supabase) structures, which led to my current pivot to SQL.
* **Deep-Dive Debugging:** Instead of just fixing bugs, I used AI to explain the "why" behind errors, ensuring I wouldn't repeat them.
* **Code Professionalism:** AI assisted me in refactoring my initial logic into clean, documented, and production-ready code.

**What this taught me:** Mastering AI tools is an engineering skill in itself. I learned that the quality of the output depends entirely on my understanding of Flutter fundamentals and my ability to provide technical context.

---

## 🧠 Key Learnings & Mastery

Through this build, I have moved from "tutorial follower" to "architect." I have gained a solid grasp of:

### 1. Asynchronous Programming
* **Futures:** Understanding how to handle data that arrives after a delay.
* **Async/Await:** Managing non-blocking operations to keep the UI buttery smooth.

### 2. Flutter Internal Mechanics
* **Native Bindings:** Learning why `WidgetsFlutterBinding.ensureInitialized()` is critical for connecting the Flutter framework to native platform plugins.
* **Reactive UI:** Implementing `StreamBuilder` to ensure the interface reflects database changes instantly without manual refreshes.



### 3. Backend & Security
* **NoSQL Design:** Organizing data into collections and documents in Firestore.
* **Auth State:** Managing user sessions and protecting data with Firebase Security Rules.

---

## 🛠️ Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **Backend:** Firebase (Auth & Firestore)
* **AI Tooling:** Google Gemini (Architectural & Debugging Partner)

---

## ⏩ What's Next?

This project was a success, but it revealed the limits of NoSQL for my specific vision. I am currently building **Version 2.0**, migrating the backend to **Supabase** to leverage **PostgreSQL** for advanced habit-tracking statistics and complex relational data.

---
*Developed as part of my journey to becoming a Full-Stack Mobile Developer.*
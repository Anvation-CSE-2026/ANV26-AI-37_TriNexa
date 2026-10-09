# Draftly — AI-Powered Content Creation & Growth Platform

Draftly is a modern, full-stack AI content creation and growth platform designed specifically for brands, creators, influencers, startups, and marketing teams. Rather than generating generic text, Draftly personalizes every piece of content to the user's distinct brand voice, target audience demographics, platform requirements, and strategic marketing goals.

---

## Key Features

### 1. 4-Step Compact Onboarding with AI-Assisted Suggestions
- **Step 1 — About You**: Creator/brand profile, industry/niche, and identity.
- **Step 2 — Your Audience**: Target audience personas with one-click **"✨ Generate Suggestions"** powered by Gemini AI, allowing full manual editing.
- **Step 3 — Content Strategy**: Content goals, primary platforms, and publishing frequency.
- **Step 4 — Review & Complete**: Unified summary review and instant setup.

### 2. Multi-Mode Content Creation Studio
- **✨ Generate from Idea**:
  - Strategic hook generation, body copy, tailored CTAs, and curated hashtags.
  - Transparent "Why This Draft?" rationale explaining how brand voice, audience, platform, and goals shaped the output.
  - Multi-dimensional Content Quality Evaluation (Hook strength, clarity, engagement potential, brand consistency, CTA quality).
  - Cross-platform adaptations for Instagram, LinkedIn, X (Twitter), and YouTube.
- **🖼️ Generate from Image (Multimodal Vision Engine)**:
  - Multimodal photo analysis powered by **Google Gemini 3.8 Flash** with automatic fallback to Google Interactions API.
  - Visual extraction: main subjects, environment, mood, aesthetic tones, colors, and key attributes.
  - Generates 3 distinct personalized caption variations: **Casual & Conversational**, **Creative & Attention-Grabbing**, and **Promotional / Goal-Oriented**.
  - One-click regeneration with custom refinement instructions.
  - Bounded exponential backoff retries for transient 503/429 spikes, and safe classified error handling.

### 3. Instagram Integration & Publishing
- Secure Meta / Instagram OAuth 2.0 integration via official Graph API.
- Live Instagram account status in Dashboard and Settings.
- Support for direct image/video publishing, caption validation, and publication history logging.
- Fallback assisted workflow and demo connection mode for testing without live credentials.

### 4. Growth & Management Suite
- **Content Planner**: Visual calendar and scheduling queue with status tracking (Draft, Scheduled, Published).
- **Campaigns**: Multi-channel marketing campaign planner.
- **Brand Profile**: Customizable tone, formality, humor, emoji usage, vocabulary, and sample posts.
- **Analytics & Insights**: Performance tracking across impressions, engagement rate, and audience growth.

---

## Tech Stack

- **Framework**: [TanStack Start](https://tanstack.com/start) / React 19 / TypeScript
- **Styling**: Tailwind CSS v4, Lucide Icons, Shadcn UI primitives, Radix UI
- **AI Engine**: Google Gemini API (`@google/genai`) — `gemini-3.8-flash`
- **Database / Auth**: Supabase (`@supabase/supabase-js`)
- **Testing**: Vitest (`vitest run`)
- **Bundler & Server**: Vite 8 / Nitro

---

## Getting Started

### 1. Clone & Install Dependencies
```bash
git clone <repository-url>
cd <repository-folder>
npm install
```

### 2. Configure Environment Variables
Copy `.env.example` to `.env`:
```bash
cp .env.example .env
```

Fill in the appropriate configuration keys:
```env
# Supabase Authentication & Database
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here

# Google Gemini API
GEMINI_API_KEY=your-gemini-api-key-here
GEMINI_MODEL=gemini-3.8-flash

# Meta / Instagram Graph API Configuration (Optional for live publishing)
META_APP_ID=your-meta-app-id
META_APP_SECRET=your-meta-app-secret
META_REDIRECT_URI=http://localhost:8080/auth/instagram/callback
```
*(Note: If `GEMINI_API_KEY` is not set in `.env`, users can also configure their Gemini API key directly in the Draftly browser UI).*

### 3. Run Development Server
```bash
npm run dev
```
Open [http://localhost:8080](http://localhost:8080) in your browser.

---

## Testing & Quality Assurance

Run the automated Vitest test suite:
```bash
npm test
```
The test suite covers:
- Gemini Vision multimodal image analysis and caption generation
- Error classification (401/403, 429, 503, 404, missing configurations)
- Bounded retries with exponential backoff for transient spikes
- Instagram publishing service, character validation, and hashtag limits
- Brand voice analysis and AI generation engines
- Application routing and store persistence

---

## Production Build

To build the project for production:
```bash
npm run build
```

Preview the production build locally:
```bash
npm run preview
```

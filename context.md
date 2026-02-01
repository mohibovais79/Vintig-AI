Gemini 3 Hackathon Project idea:
Welcome to the era of Gemini 3.
Google DeepMind is thrilled to invite you to the Gemini 3 global hackathon. We are pushing the boundaries of what AI can do by enhancing reasoning capabilities, unlocking multimodal experiences and reducing latency. Now, we want to see what you can create with our most capable and intelligent model family to date.

Whether you are a seasoned AI engineer or writing your first line of code, this is your invitation to build the future. We are looking for more than just another chat interface. We want to see fun, creative, next-generation applications built with the Gemini 3 family

Why participate?
Be First: Get hands-on access to the Gemini 3 API before the rest of the world catches up.

Build Something New: This challenge is strictly for new applications. It’s a level playing field for everyone.

Win Big: We have a prize pool of $100,000 + interviews with the AI Futures Fund team for an opportunity to fund your project.

Requirements
What to Build
The prompt is simple: Build a NEW application using the Gemini 3 API. There are no category restrictions. Build a game, a productivity tool, a scientific analyzer, or a robotic controller. If it uses Gemini 3 to do something cool, we want to see it! For inspiration, check out the Resources tab!



context for hackathon: 
Resources:
The free tier is only available in AI Studio. To get started, access the Build tab of AI Studio to easily and quickly build advanced applications. You can also find existing templates to get started in our Gallery.

📄 Docs

Gemini API Docs

Get Started with Antigravity

 

📺 Videos


Gemini 3

Vibe Coding in AI Studio

 
Inspiration: 
Need a spark? Start here. Gemini 3 isn’t just a chatbot—it’s a multimodal reasoning engine. It can see, hear, and understand the world in real-time. Don't just build a text interface; build something that senses and reacts.

The launch of Gemini 3 signals the start of the Action Era, transitioning from static chat to autonomous agents that plan and execute complex, long-running tasks. This global hackathon, hosted by Google DeepMind and Devpost challenges you to build high-fidelity AI-powered applications using the Gemini API.

 

We strongly discourage the following types of projects: 

In the Action Era, if a single prompt can solve it, it is not an application. We are looking for orchestrators building robust systems using the Gemini API in Google AI Studio.


Baseline RAG: Gemini 3 Pro features a verified 1M token context window. It natively reasons over entire codebases and document sets; simple data retrieval is now a baseline feature.
Prompt Only Wrappers: Applications that are merely system prompts in a basic UI.
Simple Vision Analyzers: Basic object identification is obsolete. We want to see spatial-temporal video understanding that recognizes cause and effect.
Generic Chatbots: Standard bots for nutrition, job screening, or personality analysis.
Medical Advice: No projects generating medical or mental health diagnostic advice.
 

Strategic Tracks:
These tracks focus on market potential and technical depth. We encourage you to innovate beyond these prompts to showcase the full potential of Gemini 3 Pro.

🧠 The Marathon Agent: Build autonomous systems for tasks spanning hours or days. Use Thought Signatures and Thinking Levels to maintain continuity and self-correct across multi-step tool calls without human supervision.

☯️ Vibe Engineering: Leverage the Google AI Studio Build tab and Google Antigravity. Build agents that do not just write code but verify it through autonomous testing loops and browser-based verification artifacts.

👨‍🏫 The Real-Time Teacher: Use the Gemini Live API to synthesize live video and audio for adaptive learning.

🎨 Creative Autopilot: Combine Gemini 3 reasoning with Nano Banana Pro for high-precision multimodal creation. Use higher resolution and localized Paint-to-Edit controls to generate professional, brand-consistent assets with legible text

 

FAQs
How does Access to the free tier of Gemini 3 work?

Here is how the Gemini API pricing (free tier with quota limits in AI Studio) works
Rate Limits
2. Can I share a test login with the judges? 
Yes! There is a submission form question: Testing Instructions. This question is only shown to the judges and Devpost managers and will not be shown publicly. Please note that judges are not required to test the Project and may choose to judge based solely on the text description, images, and video provided in the Submission. Your project still must include either a public AI Studio link or a public code repo. Be sure to review the full rules carefully. 





1. Core Concept
What it is: A visual commerce agent that "sees" a room, understands the user's local context (Karachi), and generates realistic redesigns using real, purchasable inventory found via Google Search. Key Differentiator: It does not hallucinate fake furniture. It finds a real product (e.g., from Habitt/OLX), grabs the image, and uses AI to place that exact item into the user's room.

2. Technical Stack
Frontend (Mobile): Flutter (iOS/Android)

Backend (Brain): Python FastAPI (Hosted locally or Cloud Run)

Database & Auth: Firebase (Firestore + Authentication)

Storage: Firebase Cloud Storage (Images)

AI Orchestration:

Reasoning: Gemini 3 (Layout & Style Analysis)

Safety: Gemini  3 (Blur/Obscenity Check)

Sourcing: Google Search Grounding (Live Inventory)

Visualization: Nano Banana (Reference-Guided Inpainting)

3. User Experience Flow (Frontend)
Phase 1: Onboarding (The Setup)
Login: Simple Google/Email sign-in via Firebase.

Style Profile: User selects 1 of 4 visual cards (Modern, Boho, Industrial, Classical).

Constraints:

Budget Dial: Slider input (e.g., 20k PKR - 500k PKR).

Location: Auto-detect or manual entry (e.g., "Karachi").

Action: Save profile to Firestore users/{uid}.

Phase 2: The "Lens" (The Core Action)
Capture: Full-screen camera UI. User takes a photo of a room or corner.

Processing State: Show a dynamic overlay steps list to manage latency (10-15s):

“Analyzing Room Geometry...”

“Searching Local Inventory...”

“Visualizing Upgrade...”

The Reveal:

Before/After Slider: An interactive widget allowing the user to slide between the original and the new design.

Product Card: A bottom sheet showing the exact item used: Thumbnail | Name | Price | "Buy Now" Button (Links to external store).

Phase 3: History & Persistence
Gallery: Grid view of past designs stored in Firestore.

Interaction Limit: Hardcoded limit of 5 designs per user (MVP constraint).

4. Backend Logic & AI Pipeline (FastAPI)
Endpoint: POST /design-room Input: image_file, user_id, style_preference, budget

Step 1: The Guardrail (Safety)
Model: Gemini 3

Task: fast check for blur, darkness, or explicit content.

Output: Pass/Fail. If Fail, return specific error to UI.

Step 2: The Architect (Reasoning & Search)
Model: Gemini 3 with search tool

Prompt Logic: "Analyze the room. Identify one missing high-impact item based on user style. Search Google for [Item + 'buy online Karachi']. Return valid JSON with Product Name, Price, and High-Res Image URL."

Step 3: The Visualizer (Generation)
Model: Nano Banana

Technique: Reference-Guided Inpainting.

Logic: Create a mask based on floor plane analysis -> Insert the Product Image found in Step 2 into the User Room Image.

Step 4: Response
Return JSON: { "result_image_url": "...", "product_data": { ... } }

Save transaction to Firestore history/{id}.
# ProofIt MVP

ProofIt is a fact-checking practice app where users can submit a claim and get a quick credibility estimate using plain rule-based logic (no AI yet).  
It is built like a real student project: clean and usable, but still simple enough to extend.

## What it does

- User signup/login with JWT auth
- Claim input from:
  - typed text
  - pasted URL
  - voice-to-text (Flutter speech recognition)
- Rule-based claim scoring (0-100)
- Short explanation and compact summary per claim
- Personal claim history
- Trending claims based on views

## Tech stack

- **Frontend:** Flutter (Dart), Provider, Dio, flutter_secure_storage, speech_to_text
- **Backend:** Node.js, Express.js, Mongoose
- **Database:** MongoDB
- **Auth:** JWT + bcrypt password hashing

## Project structure

```txt
proofit/
  backend/
    src/
      config/
      controllers/
      middleware/
      models/
      routes/
      services/
  frontend/
    lib/
      models/
      providers/
      screens/
      services/
      widgets/
```

## Backend setup

1. Go to backend folder:
   - `cd backend`
2. Install dependencies:
   - `npm install`
3. Create env file:
   - copy `backend/.env.example` to `backend/.env`
4. Run backend:
   - dev: `npm run dev`
   - prod-ish: `npm start`

The API will run on `http://localhost:5000` by default.

### Backend env vars

- `PORT`: API port
- `MONGO_URI`: MongoDB connection string
- `JWT_SECRET`: secret used to sign JWT
- `JWT_EXPIRES_IN`: token expiry (example: `7d`)

## Flutter setup

1. Go to frontend folder:
   - `cd frontend`
2. Install Dart/Flutter packages:
   - `flutter pub get`
3. Run app:
   - `flutter run`

### API base URL notes

Current app uses:
- `http://10.0.2.2:5000/api` (Android emulator default for localhost)

If you run on a physical device, update `baseUrl` in `frontend/lib/services/api_service.dart` to your machine IP.

## API endpoints

- `POST /api/auth/signup`
- `POST /api/auth/login`
- `POST /api/claim/verify` (protected)
- `GET /api/claim/history` (protected)
- `GET /api/claim/trending` (protected)

## Claim scoring rules (no AI)

Inside backend claim analyzer:

- base score starts at `50`
- extreme words => `-20`
- numbers/stats present => `+10`
- very short claim (<5 words) => `-10`
- balanced sentence => `+10`
- suspicious promo phrases may reduce score further
- final score clamped between `0` and `100`

The service also returns:
- a short explanation list (2-3 lines)
- a condensed summary (1-2 lines)

## Future scope

- Add optional AI-assisted explanation quality
- Pull citations from trusted sources automatically
- Smarter trend ranking and topic clusters
- Real-time collaborative verification mode

---

Built as a clean MVP first, with room to plug in AI safely later.

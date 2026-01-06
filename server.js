const express = require('express');
const app = express();

const PORT = process.env.PORT || 3000;

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: "OK",
    message: "DevTrack API is running"
  });
});

app.listen(PORT, () => {
  console.log(`DevTrack API listening on port ${PORT}`);
});

import MyAppBar from "@/components/common/MyAppBar";
import { CustomCard } from "@/styles/mui/customComponents";
import { Cookies } from "react-cookie"; // npm i react-cookie

import { darkTheme, lightTheme } from "@/styles/mui/theme";
import {
  Avatar,
  Box,
  Button,
  Container,
  CssBaseline,
  Grid,
  TextField,
  ThemeProvider,
  Typography,
} from "@mui/material";
import axios from "axios"; // npm i axios
import Head from "next/head";
import { useEffect, useState } from "react";

const cookies = new Cookies();

export default function Home() {
  const [email, setEmail] = useState("");
  const [otp, setOtp] = useState("");
  const [showOtp, setShowOtp] = useState(false);

  // SEND OTP
  const sendOTP = async () => {
    const response = await axios.post("/api/v1/send/email/otp", {
      email,
    });

    if (response.status === 201) {
      setShowOtp(true);
    }
  };

  // VERIFY OTP
  const verifyOtp = async () => {
    const response = await axios.post("/api/v1/verify/email/otp", {
      email,
      otp,
    });
    console.log("TOKEN", response);
    if (response.status === 200) {
      setShowOtp(false);

      cookies.set("token", response.data.token);
      window.location.href = "/";
    }
  };

  return (
    <Box sx={{ marginTop: "100px" }}>
      <Container maxWidth="sm">
        <Typography variant="h4" gutterBottom>
          Login
        </Typography>
        {showOtp ? (
          <Box sx={{ display: "flex", flexDirection: "column", gap: 2 }}>
            {/* <TextField fullWidth id="email" label="Email" variant="outlined" value="email" /> */}

            <TextField
              fullWidth
              id="otp"
              label="Enter OTP"
              variant="outlined"
              onChange={(event) => {
                setOtp(event.target.value);
              }}
              value={otp}
            />

            <Button variant="contained" onClick={verifyOtp}>
              Login
            </Button>
          </Box>
        ) : (
          <Box sx={{ display: "flex", flexDirection: "column", gap: 2 }}>
            <TextField
              fullWidth
              label="Email"
              variant="outlined"
              onChange={(event) => {
                setEmail(event.target.value);
              }}
              value={email}
            />

            <Button variant="contained" onClick={sendOTP}>
              Send OTP
            </Button>
          </Box>
        )}
      </Container>
    </Box>
  );
}

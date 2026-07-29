import {
  AppBar,
  Box,
  IconButton,
  Toolbar,
  Typography,
  Button,
} from "@mui/material";
import MenuIcon from "@mui/icons-material/Menu";
import Link from "next/link";
import { Cookies } from "react-cookie";
import { useEffect, useState } from "react";

const cookies = new Cookies();

export default function MyAppBar() {
  const [token, setToken] = useState();

  useEffect(() => {
    const token = cookies.get("token");
    setToken(token);
  }, []);

  const handleLogout = () => {
    cookies.remove("token");
    window.location.href = "/login";
  };

  return (
    <Box sx={{ flexGrow: 1 }}>
      <AppBar position="static">
        <Toolbar>
          <IconButton
            size="large"
            edge="start"
            color="inherit"
            aria-label="menu"
            sx={{ mr: 2 }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            My Favourite Movies
          </Typography>
          <Link href="/">
            <Button color="inherit">Home</Button>
          </Link>
          <Link href="/blog">
            <Button color="inherit">Blog</Button>
          </Link>

          {token ? (
            <Button color="inherit" onClick={handleLogout}>
              Log Out
            </Button>
          ) : (
            <Button color="inherit" href="/login">
              Login
            </Button>
          )}
        </Toolbar>
      </AppBar>
    </Box>
  );
}

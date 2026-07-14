import {
  Button,
  Card,
  CardActions,
  CardContent,
  CardMedia,
  styled,
  Typography,
} from "@mui/material";

export const MyCard = styled(Card)(({ theme }) => ({
  borderRadius: "25px",
  background: theme.palette.background.paper,
  boxShadow: "rgba(0, 0, 0, 0.35) 0px 5px 15px",
  height: "100%",
  display: "flex",
  flexDirection: "column",
}));

export const CustomCard = (props) => (
  <MyCard sx={{ maxWidth: "100%" }}>
    <CardMedia
      sx={{ height: 430, objectFit: "cover" }}
      image={props.imageUrl}
      title={props.title}
    />
    <CardContent sx={{ flexGrow: 1 }}>
      <Typography gutterBottom variant="h6" component="div">
        {props.name}
      </Typography>
      <Typography
        variant="body2"
        sx={{
          color: "text.secondary",
          textOverflow: "ellipsis",
          display: "-webkit-box",
          WebkitLineClamp: "3",
          WebkitBoxOrient: "vertical",
          overflow: "hidden",
        }}
      >
        {props.description}
      </Typography>
    </CardContent>
    <CardActions>
      <Button size="small">Share</Button>
      <Button size="small">Learn More</Button>
    </CardActions>
  </MyCard>
);

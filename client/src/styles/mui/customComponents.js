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
}));

export const CustomCard = (props) => (
  <MyCard sx={{ maxWidth: "100%" }}>
    <CardMedia sx={{ height: 240 }} image={props.img} title={props.name} />
    <CardContent>
      <Typography gutterBottom variant="h5" component="div">
        {props.name}
      </Typography>
      <Typography variant="body2" sx={{ color: "text.secondary" }}>
        {props.desc}
      </Typography>
    </CardContent>
    <CardActions>
      <Button size="small">Share</Button>
      <Button size="small">Learn More</Button>
    </CardActions>
  </MyCard>
);

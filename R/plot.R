# Function to generate plots

generatePlots <- function (){

fittedProfile <- data.frame(Z, TKEzInlet_4fit(z = Z, C1_new, C2_new))
names(fittedProfile) <- c("Z", "fittedProfile")
vars <- c("k", "Ux", "epsilon")

plots <- lapply(vars, function(v) {
  p <- ggplot(data = fieldsInOut, aes(y = z)) +
    geom_path(aes(x = .data[[paste0(v, "Inlet")]], colour = "Inlet")) +
    geom_point(aes(x = .data[[paste0(v, "Outlet")]], colour = "Outlet")) +
    scale_colour_manual(name = "", values = c("Inlet" = "black", "Outlet" = "black", "Fitted profile" = "blue")) +labs(x = v, y = "z(m)")
  
  # Add fitted profile line only for k
  if (v == "k") {
    p <- p + geom_path(data = fittedProfile, aes(x = fittedProfile, y = Z, colour = "Fitted profile"))
  } else {
    p <- p + geom_line(data = data.frame(x = NA, y = NA), aes(x = x, y = y, colour = "Fitted profile"), na.rm = TRUE)
    p <- p + theme(axis.title.y = element_blank(),axis.text.y = element_blank(), axis.ticks.y = element_blank())
  }
  return(p)
  return(plots)
}
)
}

#  Function to save plots

savePlots <- function(plots){
allPlots <- wrap_plots(plots, nrow = 1) + 
  plot_layout(guides = "collect")

# first plot - initial condition - only if figInOutLast does not exist
if (!file.exists(figInOutLast)){ 
  allPlots <- allPlots + plot_annotation(title = "Initial Inlet-Outlet")
  ggsave(filename = figInOut0, plot = allPlots,width = 14, height = 4) 
}
# last plot - final condition - overwritten @ each iteration
allPlots <- allPlots + plot_annotation(title = "Final Inlet-Outlet")
ggsave(filename = figInOutLast, plot = allPlots,width = 14, height = 4) 
}

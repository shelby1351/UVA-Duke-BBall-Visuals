draw_court <- function() {
  circle_fun <- function(center=c(0,0), diameter=1, npoints=500, start=0, end=2){
    tt <- seq(start*pi, end*pi, length.out=npoints)
    data.frame(
      x = center[1] + diameter / 2 * cos(tt),
      y = center[2] + diameter / 2 * sin(tt)
    )
  }
  rev_y <- function(y) 94-y
  new_coords <- function(x, y, group, descri){
    new_coords_df <- data.frame(x = x, y = y)
    new_coords_df$group <- group
    new_coords_df$side <- 1
    group <- group + 1
    
    # The same thing for the opposite side
    new_coords_df2 <- data.frame(x = x, y = rev_y(y))
    new_coords_df2$group <- group
    new_coords_df2$side <- 2
    group <<- group + 1
    
    # On reunit les donnees
    new_coords_df <- rbind(new_coords_df, new_coords_df2)
    new_coords_df$descri <- descri
    
    return(new_coords_df)
  }
  # Restricted area
  cercle_np_out <- circle_fun(center = c(25,5+3/12), diameter = (4+1/6)*2)
  cercle_np_in <- circle_fun(center = c(25,5+3/12), diameter = 4*2)
  # Three point
  cercle_3pts_out <- circle_fun(center = c(25,5+3/12), diameter = (23+9/12)*2)
  cercle_3pts_in <- circle_fun(center = c(25,5+3/12), diameter = (23+7/12)*2)
  # Hoop
  cercle_ce <- circle_fun(center = c(25,5+3/12), diameter = 1.5)
  # Free Throws
  cercle_lf_out <- circle_fun(center = c(25,19), diameter = 6*2)
  cercle_lf_in <- circle_fun(center = c(25,19), diameter = (6-1/6)*2)
  # Center Circle
  cercle_mil_out <- circle_fun(center = c(25,47), diameter = 6*2)
  cercle_mil_in <- circle_fun(center = c(25,47), diameter = (6-1/6)*2)
  # Small Center Circle
  cercle_mil_petit_out <- circle_fun(center = c(25,47), diameter = 2*2)
  cercle_mil_petit_in <- circle_fun(center = c(25,47), diameter = (2-1/6)*2)
  group <- 1
  court <- new_coords(c(0-1/6,0-1/6,50 + 1/6,50 + 1/6), c(0 - 1/6,0,0,0 - 1/6), group = group, descri = "ligne de fond")
  court <- rbind(court, new_coords(x = c(0-1/6,0-1/6,0,0), y = c(0,47-1/12,47-1/12,0), group = group, descri = "ligne gauche"))
  court <- rbind(court, new_coords(x = c(50,50,50+1/6,50+1/6), y = c(0,47-1/12,47-1/12,0), group = group, descri = "ligne droite"))
  court <- rbind(court, new_coords(x = c(0,0,3,3), y = c(28,28+1/6,28+1/6,28), group = group, descri = "marque entraineur gauche"))
  court <- rbind(court, new_coords(x = c(47,47,50,50), y = c(28,28+1/6,28+1/6,28), group = group, descri = "marque entraineur droite"))
  court <- rbind(court, new_coords(x = c(3,3,3+1/6,3+1/6), y = c(0,14,14,0), group = group, descri = "3pts bas gauche"))
  court <- rbind(court, new_coords(x = c(47-1/6,47-1/6,47,47), y = c(0,14,14,0), group = group, descri = "3pts bas droit"))
  court <- rbind(court, new_coords(x = c(17,17,17+1/6,17+1/6), y = c(0,19,19,0), group = group, descri = "LF bas gauche"))
  court <- rbind(court, new_coords(x = c(33-1/6,33-1/6,33,33), y = c(0,19,19,0), group = group, descri = "LF bas droit"))
  court <- rbind(court, new_coords(x = c(17,17,33,33), y = c(19-1/6,19,19,19-1/6), group = group, descri = "LF tireur"))
  court <- rbind(court, new_coords(x = c(14-1/6,14-1/6,14,14), y = c(0,1/2,1/2,0), group = group, descri = "marque fond gauche"))
  court <- rbind(court, new_coords(x = c(36,36,36+1/6,36+1/6), y = c(0,1/2,1/2,0), group = group, descri = "marque fond droit"))
  court <- rbind(court, new_coords(x = c(19,19,19+1/6,19+1/6), y = c(0,19,19,0), group = group, descri = "LF gauche interieur"))
  court <- rbind(court, new_coords(x = c(31-1/6,31-1/6,31,31), y = c(0,19,19,0), group = group, descri = "LF droite interieur"))
  court <- rbind(court, new_coords(x = c(22, 22, 28, 28), y = c(4-1/6,4,4,4-1/6), group = group, descri = "planche"))
  court <- rbind(court, new_coords(x = c(cercle_3pts_out[31:220,"x"], rev(cercle_3pts_in[31:220,"x"])),
                                   y = c(cercle_3pts_out[31:220,"y"], rev(cercle_3pts_in[31:220,"y"])), group = group, descri = "cercle 3pts"))
  court <- rbind(court, new_coords(x = c(cercle_np_out[1:250,"x"], rev(cercle_np_in[1:250,"x"])),
                                   y = c(cercle_np_out[1:250,"y"], rev(cercle_np_in[1:250,"y"])), group = group, descri = "cercle non passage en force"))
  court <- rbind(court, new_coords(x = c(20+1/6,20+1/6,20+8/12,20+8/12), y = c(13,13+1/6,13+1/6,13), group = group, descri = "marque bas gauche cercle LF"))
  court <- rbind(court, new_coords(x = c(30-8/12,30-8/12,30-1/6,30-1/6), y = c(13,13+1/6,13+1/6,13), group = group, descri = "marque bas droite cercle LF"))
  court <- rbind(court, new_coords(x = c(cercle_lf_out[1:250,"x"], rev(cercle_lf_in[1:250,"x"])),
                                   y = c(cercle_lf_out[1:250,"y"], rev(cercle_lf_in[1:250,"y"])), group = group, descri = "cercle LF haut"))
  court <- rbind(court, new_coords(x = c(cercle_lf_out[250:269,"x"], rev(cercle_lf_in[250:269,"x"])),
                                   y = c(cercle_lf_out[250:269,"y"], rev(cercle_lf_in[250:269,"y"])), group = group, descri = "cercle LF partie 1"))
  court <- rbind(court, new_coords(x = c(cercle_lf_out[288:308,"x"], rev(cercle_lf_in[288:308,"x"])),
                                   y = c(cercle_lf_out[288:308,"y"], rev(cercle_lf_in[288:308,"y"])), group = group, descri = "cercle LF partie 2"))
  court <- rbind(court, new_coords(x = c(cercle_lf_out[327:346,"x"], rev(cercle_lf_in[327:346,"x"])),
                                   y = c(cercle_lf_out[327:346,"y"], rev(cercle_lf_in[327:346,"y"])), group = group, descri = "cercle LF partie 3"))
  court <- rbind(court, new_coords(x = c(cercle_lf_out[365:385,"x"], rev(cercle_lf_in[365:385,"x"])),
                                   y = c(cercle_lf_out[365:385,"y"], rev(cercle_lf_in[365:385,"y"])), group = group, descri = "cercle LF partie 4"))
  court <- rbind(court, new_coords(x = c(cercle_lf_out[404:423,"x"], rev(cercle_lf_in[404:423,"x"])),
                                   y = c(cercle_lf_out[404:423,"y"], rev(cercle_lf_in[404:423,"y"])), group = group, descri = "cercle LF partie 5"))
  court <- rbind(court, new_coords(x = c(cercle_lf_out[442:462,"x"], rev(cercle_lf_in[442:462,"x"])),
                                   y = c(cercle_lf_out[442:462,"y"], rev(cercle_lf_in[442:462,"y"])), group = group, descri = "cercle LF partie 6"))
  court <- rbind(court, new_coords(x = c(cercle_lf_out[481:500,"x"], rev(cercle_lf_in[481:500,"x"])),
                                   y = c(cercle_lf_out[481:500,"y"], rev(cercle_lf_in[481:500,"y"])), group = group, descri = "cercle LF partie 7"))
  court <- rbind(court, new_coords(x = c(17-0.5,17-0.5,17,17), y = c(7,7+1/6,7+1/6,7), group = group, descri = "marque 1 LF gauche"))
  court <- rbind(court, new_coords(x = c(17-0.5,17-0.5,17,17), y = c(8+1/6,8+1/3,8+1/3,8+1/6), group = group, descri = "marque 2 LF gauche"))
  court <- rbind(court, new_coords(x = c(17-0.5,17-0.5,17,17), y = c(11+1/3,11.5,11.5,11+1/3), group = group, descri = "marque 3 LF gauche"))
  court <- rbind(court, new_coords(x = c(17-0.5,17-0.5,17,17), y = c(14.5,14.5+1/6,14.5+1/6,14.5), group = group, descri = "marque 4 LF gauche"))
  court <- rbind(court, new_coords(x = c(33,33,33+0.5,33+0.5), y = c(7,7+1/6,7+1/6,7), group = group, descri = "marque 1 LF droite"))
  court <- rbind(court, new_coords(x = c(33,33,33+0.5,33+0.5), y = c(8+1/6,8+1/3,8+1/3,8+1/6), group = group, descri = "marque 2 LF droite"))
  court <- rbind(court, new_coords(x = c(33,33,33+0.5,33+0.5), y = c(11+1/3,11.5,11.5,11+1/3), group = group, descri = "marque 3 LF droite"))
  court <- rbind(court, new_coords(x = c(33,33,33+0.5,33+0.5), y = c(14.5,14.5+1/6,14.5+1/6,14.5), group = group, descri = "marque 4 LF droite"))
  court <- rbind(court, new_coords(x = c(0-1/6,0-1/6,50+1/6,50+1/6), y = c(94/2-1/12,94/2, 94/2, 94/2-1/12), group = group, descri = "ligne mediane"))
  court <- rbind(court, new_coords(x = c(cercle_mil_out[250:500,"x"], rev(cercle_mil_in[250:500,"x"])),
                                   y = c(cercle_mil_out[250:500,"y"], rev(cercle_mil_in[250:500,"y"])), group = group, descri = "cercle milieu grand"))
  court <- rbind(court, new_coords(x = c(cercle_mil_petit_out[250:500,"x"], rev(cercle_mil_petit_in[250:500,"x"])),
                                   y = c(cercle_mil_petit_out[250:500,"y"], rev(cercle_mil_petit_in[250:500,"y"])), group = group, descri = "cercle milieu petit"))
  court <- rbind(court, new_coords(x = cercle_ce[,"x"], y = cercle_ce[,"y"], group = group, descri = "anneau"))
  library(ggplot2)
  P <- ggplot() + geom_polygon(data = court, aes(x = x, y = y, group = group), col = "gray") +
    coord_equal() +
    scale_x_continuous(breaks = c(0, 12.5, 25, 37.5, 50)) +
    scale_y_continuous(breaks = c(0, 23.5, 47, 70.5, 94)) +
    theme_bw() + 
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(), axis.ticks.x = element_blank(),
          axis.ticks.y = element_blank(), axis.title = element_blank(),
          panel.grid.major = element_blank(), panel.grid.minor = element_blank())
  return(P)
}
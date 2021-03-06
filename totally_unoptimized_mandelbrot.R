options(warn=-1) #Suppress the warning coming from the color pacakge
library(scico)

tokyo <- scico::scico(250, palette= 'grayC') #picked a color scheme
color <- c(tokyo)

# A fractal function
mandelbrot <<- function(i,j){
  
  bound <- 1 #flag/swtich if number has escaped the M-Set
  x <- i-460 # constant c added to x and y
  y <- 240-j 
  
  # A 2d complaix plain
  a <- complex(real = x/200, imaginary = y/200) 
  b <- complex(real = 0, imaginary = 0) 

  for(k in seq(length(color))){
    # Expression to make M-Set
    b <- b*b+a 
    
    if(Mod(b)>2){ #Region color for escaped numbers
      color <- k
      bound <- 0
      break;
    }
  }
  
  return(list(flag= bound, c= color)) #return the bound with associated color
}

png(filename="mandelbrot_bad.png", bg= "lavender",height = 600, width = 600, units = "px", res= 80) 

#plot attributes
plot(c(50, 600), c(50,500), type = 'l', col.axis= "hotpink4", xlab= "", ylab = "")
title(sub = "Input form c(A, Bi)",
      xlab = "Real Axis", ylab = "Imaginary Axis",
      cex.sub = 0.75, font.sub = 3, col.sub = "hotpink4",
      col.lab ="darkblue", main= "the Mandelbrot Set", col.main= "palevioletred4")

# iterations for x and y
for(i in 1:1000){ 
  for(j in 1:1000){
    f_x= mandelbrot(i,j) 
    
    if(f_x$flag){ 
      points(i,j,pch=46) 
    }
    else{
      points(i,j,pch=46,col=color[f_x$c]) #color region if flag is True
    }
  }
}

dev.off()

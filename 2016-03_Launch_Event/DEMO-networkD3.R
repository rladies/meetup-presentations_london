###DEMO###

#Install and load networkD3 package
install.packages("networkD3")
library(networkD3)


# Taylor Swift Social Network ---------------------------------------------

#Make Edge List
from <- c("Taylor Swift","Taylor Swift",  "Taylor Swift","Taylor Swift","Selena Gomez", "Taylor Swift")
to <-   c("Selena Gomez","Ellie Goulding","Karlie Kloss", "Ed Sheeran", "Ellie Goulding","Lady Gaga")

taylor.net <- data.frame(from, to)

#Check Edge List
View(taylor.net)

#Plot Simple Network from Edge List - interactive html widget
simpleNetwork(taylor.net)

#Customise widget
simpleNetwork(taylor.net, 
              fontSize = 30, 
              nodeColour = "chartreuse",
              zoom = TRUE)


# Amazon Product Network Analysis ------------------------------------------------

#Read in Amazon data: product nodes & links between products
nodes <- read.csv(file.choose(), sep = ",", header = TRUE)
links <- read.csv(file.choose(), sep = ",", header = TRUE)

#Check Amazon data: note additional attributes (link values, node groups)
View(nodes)
View(links)

#Plot basic Amazon product network
forceNetwork(Nodes = nodes, Links = links,
             NodeID = "name", Group = "group",
             Source = "from", Target = "to", Value = "weight")

#Customise widget
forceNetwork(Nodes = nodes, Links = links,
             NodeID = "name", Group = "group",
             Source = "from", Target = "to", Value = "weight",
             legend = TRUE, 
             fontSize = 50,
             opacity = 1, 
             charge = -500,
             zoom = TRUE)


# Bigger Network example --------------------------------------------------
data(MisLinks)
data(MisNodes)

View(MisLinks)
View(MisNodes)

forceNetwork(Nodes = MisNodes, Links = MisLinks,
             NodeID = "name", Group = "group",
             Source = "source", Target = "target", Value = "value",
             legend = TRUE, 
             fontSize = 50,
             opacity = 1, 
             charge = -500,
             zoom = TRUE)

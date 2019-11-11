# grid.arrange(p1, arrangeGrob(p2, p3, p4, p5, ncol = 2), nrow=2)
g1 <- arrangeGrob(p1, ncol = 1) #generates g
# ggsave("../output/g1.png", g1)

g2 <- arrangeGrob(p2, p3, p4, p5, ncol = 2)
# ggsave("../output/g2.png", g2)

g3 <- arrangeGrob(p6, p7, p8, p9, ncol = 2)
# ggsave("../output/g3.png", g3)

g4 <- arrangeGrob(p10, p11, p12, p13, ncol = 2)
# ggsave("../output/g4.png", g4)


function att = a_blur(image, factor)
att = imgaussfilt(image,50.*factor+0.000001);


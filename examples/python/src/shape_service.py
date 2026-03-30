import random

from shapes import Circle, Rectangle, Shape, Triangle


def generate_random_shape() -> Shape:
    variant = random.randint(0, 2)
    if variant == 0:
        return Circle(radius=get_random_shape_edge())
    elif variant == 1:
        return Rectangle(width=get_random_shape_edge(), height=get_random_shape_edge())
    else:
        return Triangle(
            edgeA=get_random_shape_edge(),
            edgeB=get_random_shape_edge(),
            edgeC=get_random_shape_edge(),
        )


def get_random_shape_edge() -> int:
    return random.randint(80, 120)

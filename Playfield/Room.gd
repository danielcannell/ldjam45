class_name Room


var _bounds: Rect2
var points: PoolVector2Array = PoolVector2Array()


func add_point(point: Vector2) -> void:
    points.append(point)


func get_bounds() -> Rect2:
    if _bounds == null:
        var minx: float = 1e12
        var miny: float = 1e12
        var maxx: float = -1e12
        var maxy: float = -1e12
        for i in range(points.size()):
            var point = points[i]
            if point.x < minx:
                minx = point.x
            if point.x > maxx:
                maxx = point.x
            if point.y < miny:
                miny = point.y
            if point.y > maxy:
                maxy = point.y

        _bounds = Rect2(minx, miny, maxx - minx, maxy - miny)

    return _bounds


func center() -> Vector2:
    var bounds = get_bounds()
    return Vector2((bounds.position.x + bounds.end.x) / 2, (bounds.position.y + bounds.end.y) / 2)


func size() -> Vector2:
    var bounds = get_bounds()
    return Vector2(bounds.end.x - bounds.position.x, bounds.end.y - bounds.position.y)


func contains(pos: Vector2) -> bool:
    # Taken from https://www.javatips.net/api/mathematorium-master/CommonUtilities/graphicsUtilities/Polygon2D.java
    var bounds = get_bounds()
    if pos.x < bounds.position.x or pos.x > bounds.end.x or pos.y < bounds.position.y or pos.y > bounds.end.y:
        return false

    var hits: int = 0
    var npoints: int = points.size()
    var lastpos: Vector2
    var curpos: Vector2 = points[npoints - 1]

    # Walk the edges of the polygon
    for i in range(npoints):
        lastpos = curpos
        curpos = points[i]

        if curpos.y == lastpos.y:
            continue

        var leftx: float
        if curpos.x < lastpos.x:
            if pos.x >= lastpos.x:
                continue

            leftx = curpos.x
        else:
            if pos.x >= curpos.x:
                continue

            leftx = lastpos.x

        var test1: float
        var test2: float
        if curpos.y < lastpos.y:
            if (pos.y < curpos.y) or (pos.y >= lastpos.y):
                continue

            if pos.x < leftx:
                hits += 1
                continue

            test1 = pos.x - curpos.x
            test2 = pos.y - curpos.y
        else:
            if (pos.y < lastpos.y) or (pos.y >= curpos.y):
                continue

            if pos.x < leftx:
                hits += 1
                continue

            test1 = pos.x - lastpos.x
            test2 = pos.y - lastpos.y

        if test1 < (test2 / (lastpos.y - curpos.y) * (lastpos.x - curpos.x)):
            hits += 1

    return (hits & 1) != 0

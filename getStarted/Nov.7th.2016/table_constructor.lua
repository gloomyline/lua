-- @Author: Alan
-- @Date:   2016-11-07 14:19:39
-- @Last Modified by:   Alan
-- @Last Modified time: 2016-11-07 14:22:45
polyline = {
	color="blue",thickness=2,npoints=4,
	{x=0, y=0},
	{x=-10, y=0},
	{x=-10, y=1},
	{x=0, y=1}
}

print(polyline['color'])
print(polyline[1]['x'], polyline[1]['y'])
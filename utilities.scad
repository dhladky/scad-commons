// From given vector with hole sizes generate starts of all the holes with given sizes. 
// Returns array of touples, where first value is the size of the hole and second value is 
// the position of the hole.
// Parameters:
// - hole_sizes - array of hole sizes
// - distance - uniform distance between holes
// - start - offset of the first hole
function cummulative_vector(hole_sizes, start=0, distance=0) = (len(hole_sizes)==1) ? [[hole_sizes[0], start]] : concat([[hole_sizes[0], start], each cummulative_vector([for(i=[1:len(hole_sizes)-1])hole_sizes[i]], start = start+distance+hole_sizes[0], distance=distance)    ]);
 


// Returns the size of cummulative_vector(...) object 
// Parameters:
// - hole_sizes - array of hole sizes
// - distance - uniform distance between holes
function cummulative_vector_size(hole_sizes, distance=0) = let( vector = cummulative_vector(hole_sizes, distance=distance), last= len(vector)-1) (vector[last][1]+vector[last][0]);




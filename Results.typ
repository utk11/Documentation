== Explicit Static-Dynamic Coupling
The results of the static FEA and dynamic RBD to create a quasi-dynamic simulation are presented here. 
A interesting discovery about the interface modelling is that if kinematic constraints are used to model the interface node on the FEA side, the simulation does not converge until the reaction force is divided by the number of nodes that are constrained to the coupling node. Then is becomes exactly equal to the manual version of interface coupling. Here the results of the manual interface coupling are presented.\
Explicit coupling is explained in @ExplicitCoupling. 
=== Acceleration Comparison
#figure(image("Pictures/SD/Acceleration of Piston in X direction.png", width: 80%), caption: "Acceleration of Piston in X direction")
#figure(image("Pictures/SD/Acceleration of Crank in X direction.png", width: 80%), caption: "Acceleration of Crank in X direction")
#figure(image("Pictures/SD/Acceleration of Crank in Y direction.png", width: 80%), caption: "Acceleration of Crank in Y direction")
#figure(image("Pictures/SD/Angular acceleration of Crank along Z direction.png", width: 80%), caption: "Angular acceleration of Crank along Z direction")




=== Force Comparison
#figure(image("Pictures/SD/Constraint force on piston in x direction.png", width: 80%), caption: "Constraint force on piston in x direction")
#figure(image("Pictures/SD/Constraint force on crank in x direction.png", width: 80%), caption:"Constraint force on crank in x direction")
#figure(image("Pictures/SD/Constraint force on piston in y direction.png", width: 80%), caption: "Constraint force on piston in y direction")
#figure(image("Pictures/SD/Constraint force on crank in y direction.png", width: 80%), caption: "Constraint force on crank in y direction")

=== Position Comparison



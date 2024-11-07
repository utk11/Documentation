== Explicit Static-Dynamic Coupling
The results of the static FEA and dynamic RBD to create a quasi-dynamic simulation are presented here. 
A interesting discovery about the interface modelling is that if kinematic constraints are used to model the interface node on the FEA side, the simulation does not converge until the reaction force is divided by the number of nodes that are constrained to the coupling node. Then is becomes exactly equal to the manual version of interface coupling. Here the results of the manual interface coupling are presented.\
Explicit coupling is explained in @ExplicitCoupling. 
=== Acceleration Comparison





#figure(image("Pictures/SD/Acceleration of Piston in X direction.png", width: 80%), caption: "Acceleration of Piston in X direction")


#grid(columns: 2,
[#figure(image("Pictures/SD/Acceleration of Crank in X direction.png"), caption: "Acceleration of Crank in X direction")],[#figure(image("Pictures/SD/Acceleration of Crank in Y direction.png"), caption: "Acceleration of Crank in Y direction")])

#figure(image("Pictures/SD/Angular acceleration of Crank along Z direction.png", width: 80%), caption: "Angular acceleration of Crank along Z direction")




=== Force Comparison
#figure(grid(columns: 2,
[#figure(image("Pictures/SD/Constraint force on piston in x direction.png"))],
[#figure(image("Pictures/SD/Constraint force on piston in y direction.png"))]), caption: "Constraint force on Piston X and Y directions")


#figure(grid(columns: 2,
[#figure(image("Pictures/SD/Constraint force on Crank in x direction.png"))],
[#figure(image("Pictures/SD/Constraint force on Crank in y direction.png"))]), caption: "Constraint force on Crank X and Y directions")

=== Position Comparison


#figure(caption: "Position of Piston",
  grid(columns: (1fr,1fr),
  [#image("Pictures/SD/Position of Piston along X direction.png")],[#image("Pictures/SD/Position of Piston along Y direction.png")])
 )
#figure(caption: "Position of Crank",
  grid(columns: (1fr,1fr),
  [#image("Pictures/SD/Position of Crank along X direction.png")],[#image("Pictures/SD/Position of Crank along Y direction.png")])
 )


== Explicit Dynamic-Dynamic Coupling
In this case both the codes are performing a dynamic analysis. So the time steps need to be synced and data is shared over every step. In dynamic FEA the consideration of nonlinear behavior becomes crucial. If the nonlinear behavior is ignored as in a linear analysis the rigid body motion of the mesh creates artificial stresses and ultimately artificial reaction forces that are returned to the other code @mullerInteractiveVirtualMaterials. 
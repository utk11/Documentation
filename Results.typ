== Explicit Static-Dynamic Coupling
The results of the static FEA and dynamic RBD to create a quasi-dynamic simulation are presented here. 
An *interesting discovery* about the interface modelling is that if kinematic constraints(using master slave method) are used to model the interface node on the FEA side, the simulation does not converge.
But if the reaction force is divided by the number of nodes that are constrained to the coupling node it does converge and gives exactly same results as that of the manual coupling. 

Here the results of the manual interface coupling are presented.\
Explicit coupling is explained in @ExplicitCoupling. 
=== Acceleration Comparison
Acceleration of piston in Y direction and angular acceleration along the Z direction are not shown as they are zero because their motion is constrained by the prismatic joint.\
Here the acceleration as well as the constraint force as a consequence are continuously increasing as evident from the graphs. This is because a ideal system without any damping or friction (no energy dissipation) is considered. So the external force constantly adds energy to the system without any dissipation.
However the energy in the RBD system is increasing faster than that of the co-sim setup. This is because of the kinematic quantity being transferred to the FEA code. Acceleration is a direct consequence of force , but displacement is integrated from acceleration. This is why it takes time to reflect in the co-simulation methodology
#figure(image("Pictures/SD/Acceleration of Piston in X direction.png", width: 80%), caption: "Acceleration of Piston in X direction")


#grid(columns: 2,
[#figure(image("Pictures/SD/Acceleration of Crank in X direction.png"), caption: "Acceleration of Crank in X direction")],[#figure(image("Pictures/SD/Acceleration of Crank in Y direction.png"), caption: "Acceleration of Crank in Y direction")])

#figure(image("Pictures/SD/Angular acceleration of Crank along Z direction.png", width: 80%), caption: "Angular acceleration of Crank along Z direction")




=== Force Comparison
A constant theme in these figures in that the RBD code is lagging behind the FEA code.

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

#pagebreak()

== Explicit Dynamic-Dynamic Coupling
In this case both the codes are performing a dynamic analysis. So the time steps need to be synced and data is shared over every step. In dynamic FEA the consideration of nonlinear behavior becomes crucial. If the nonlinear behavior is ignored as in a linear analysis the rigid body motion of the mesh creates artificial stresses and ultimately artificial reaction forces that are returned to the other code @mullerInteractiveVirtualMaterials. So it becomes necessary to include the nonlinear effects in FEA code. 
The explicit method is unstable and won't converge as per the findings of this work. 

#figure(image("Pictures/explicit FEA.png", width: 80%), caption: "Dynamic FEA using Abaqus")<eFEA>
@eFEA shows the reaction forces in X direction when a non zero acceleration BC is applied on the right and zero acceleration BC is applied on the left. This is done to understand the first time- step of a co-simulation.\

The reason that this strategy does not converge is, during the very first step the crank moves or is accelerated due to the force applied to it. But the piston is stationary as it is not connected to crank via the connecting rod as explained in @CosimMethod. This means the kinematic quantities sent to the FEA code are zero acceleration on the piston's side and a non zero acceleration on the cranks side. When this boundary condition is applied in the FEA code a reaction force is only generated on one side where the nonzero BC was applied. There is a zero reaction force on the piston's side as seen in the @eFEA. This means that the simulation continues with a zero reaction force on the piston. In the next step a similar thing happens because the piston has not been accelerated due to a lack of force. This continues until the acceleration grows big enough to generate a substantial reaction force on the piston. But until then it is too late.

#pagebreak()
== Implicit Static - Dynamic Coupling
A system is said to be in static equilibrium when the addition of forces and torques equal to zero. In static FEA for the body to be in static equilibrium the forces need to balance out or some kind of constraint is needed to balance the external forces. 
In the coupling method a force
#pagebreak()
== Implicit Dynamic - Dynamic Coupling
Due to time constraint on the thesis this case wasn't tested. 
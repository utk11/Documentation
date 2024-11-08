== Abstract


This thesis investigates the integration of Finite Element Analysis (FEA) and Multi-Body Dynamics (MBD) to create a robust simulation framework for flexible multi-body systems experiencing dynamic interactions. While traditional MBD methods are effective for simulating large, rigid-body motions, they often fail to capture the nuanced deformations of flexible components, a gap that FEA can fill. However, the independent use of each method limits the accuracy of simulations in scenarios requiring an understanding of both rigid and flexible dynamics. This research addresses this limitation by presenting a coupled FEA-MBD approach that enables seamless interaction between flexible and rigid components, specifically applied to a slider-crank mechanism.

The coupling strategy utilizes a co-simulation technique, wherein deformation data from FEA and motion data from MBD are exchanged iteratively to achieve dynamic fidelity. The method’s validity is demonstrated through a case study on a slider-crank mechanism, a system where complex interactions between flexibility and motion are critical. Results from this study illustrate the improved accuracy and computational efficiency of the coupled FEA-MBD approach over conventional methods. The findings underscore the framework’s applicability in engineering contexts requiring precise modeling of flexible structures undergoing dynamic loads, with implications for robotics, automotive engineering, and biomechanical systems. This thesis thus contributes to advancing multi-body simulations, enabling broader applications of FEA-MBD coupling in engineering and research.

== Motivation and Goal 
#set par(
  first-line-indent: 1em,
  spacing: 0.65em,
  justify: true,
)

In the realm of mechanical and structural engineering, accurately predicting the behavior of complex systems under dynamic loads is a fundamental requirement. Traditional analysis methods—Finite Element Analysis (FEA) and Multi-Body Dynamics (MBD)—each offer significant insights into system behavior but also have inherent limitations when used independently. MBD focuses on the motion and interaction of rigid bodies, providing an efficient means to model large-scale mechanical systems with interconnected components. However, MBD treats all bodies as rigid, which limits its capacity to capture the flexible deformations that can occur under load, especially in components experiencing high stresses, vibration, or structural flexibility.

Conversely, FEA is well-suited for modeling stress, strain, and deformation in flexible structures. By discretizing a structure into finite elements, FEA can resolve complex deformations and stress distributions with high accuracy. Yet, when applied to systems with significant rigid-body motion, FEA becomes computationally intensive and less effective in capturing the kinematic constraints and interactions between interconnected bodies in motion. Therefore, solely using FEA for systems involving significant rigid motion is computationally prohibitive and challenging to implement effectively.

If a complex system with many moving parts and kinematic joints like a vehicle suspension or robotic arm needs to be studied. To understand under what loading condition it is likely to fail a RBD simulation of that system can be created and then the dynamic joint loads can be exported to FEA analysis to perform failure analysis.
But this will not affect the RBD simulation as this is only a one way communication. To include the flexibility of a body the equations of elasticity must be integrated in the simulation. Different methods to achieve this are explained in the next section.

One of the ways is co-simulation. In this two different simulations are performed simultaneously and data is exchanged. So the one simulation can affect the results of the other and vice versa. This method if applied correctly can lead to accurate results and less computational effort. The goal of this thesis is to explore this methodology in greater depth.
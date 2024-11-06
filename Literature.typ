== State of the Art (Flexible RBD)
Rigid-flexible multibody dynamics is a critical area of study in mechanical and aerospace engineering, robotics, and biomechanics. It involves the modeling and simulation of systems comprising both rigid and flexible components, capturing the interplay between the rigid body motions and elastic deformations. Accurate modeling of such systems is essential for predicting performance, optimizing design, and ensuring safety in applications ranging from spacecraft and robotic manipulators to automotive suspensions and biomechanical systems.

Over the years, several approaches have been developed to model rigid-flexible multibody systems. These methods vary in their computational efficiency, accuracy, ability to handle large deformations, and ease of implementation. This literature review discusses the state-of-the-art approaches used in rigid-flexible multibody dynamics, highlighting their advantages and disadvantages.

*Floating Frame of reference formulation* \
The Floating Frame of Reference (FFR) formulation is a modeling approach used in flexible multibody dynamics to analyze the behavior of systems comprising both rigid and flexible bodies. In this formulation, each flexible body is associated with a local reference frame—termed the "floating frame"—that captures the body's large overall (rigid-body) motion. Superimposed on this motion are small elastic deformations described relative to the floating frame. This method effectively decouples the large rigid-body motions from the small elastic deformations, allowing for efficient and accurate simulations under certain conditions. This method capture the rigid body motion but is valid only for small strain cases. The calculation of the inertia terms is a complex and tedious task.
@zwolferConciseNodalbasedDerivation2020a
@wasfyComputationalStrategiesFlexible2003a

*Absolute Nodal Coordinate formulation*\
The Absolute Nodal Coordinate Formulation (ANCF) is a finite element-based approach used in flexible multibody dynamics to model large deformations and rotations of flexible bodies. Unlike traditional formulations that separate rigid-body motion from deformation or use incremental rotations, ANCF employs absolute positions and gradients (slopes) of nodes as degrees of freedom. This approach allows for the accurate modeling of complex nonlinear behaviors, including significant bending, twisting, and stretching, without the limitations imposed by small deformation assumptions.
@shabanaOverviewANCFApproach2023 
@diboldDetailedComparisonAbsolute2009

*Nonlinear Finite element method*\
@Bathe1995FiniteEP

*Absolute Coordinate formulation*\
In flexible multibody dynamics, the Absolute Coordinate Formulation (ACF) is a modeling approach that utilizes global Cartesian coordinates to describe the positions and orientations of all bodies within a system. This method contrasts with relative coordinate formulations, which define positions and orientations relative to other bodies or reference frames.\
All positions and orientations are expressed in a single, inertial coordinate system. This global perspective simplifies the formulation of equations of motion and the application of external forces.\
By using absolute coordinates, ACF directly represents the motion of each body without the need for transformations between local and global frames. This directness can simplify the mathematical representation of the system.\
Kinematic constraints, such as joints or prescribed motions, can be more straightforward to implement in ACF since all coordinates are defined in the same global frame. This uniformity can reduce the complexity of constraint equations.
@wasfyComputationalStrategiesFlexible2003a
@gerstmayr3DFiniteElement2006

*Co-simulation or Coupling methods*

@wangGluingAlgorithmDistributed
@ryuIntegrationFiniteElement2009
@font-llagunesECCOMASThematicConference2015
@ortizCOSIMULATIONLARGEMBD
@trommeWeaklyFullyCoupled2016a
@prescottRealTimeSimulationFlexible2016
@inciSystemlevelCosimulationMechatronic
@fernandez-fernandezSymXEnergybasedSimulation2023a

== State of the Art (Flexible RBD)
Rigid-flexible multibody dynamics is a critical area of study in mechanical and aerospace engineering, robotics, and biomechanics. It involves the modeling and simulation of systems comprising both rigid and flexible components, capturing the interplay between the rigid body motions and elastic deformations. Accurate modeling of such systems is essential for predicting performance, optimizing design, and ensuring safety in applications ranging from spacecraft and robotic manipulators to automotive suspensions and biomechanical systems.

Over the years, several approaches have been developed to model rigid-flexible multibody systems. These methods vary in their computational efficiency, accuracy, ability to handle large deformations, and ease of implementation. This literature review discusses the state-of-the-art approaches used in rigid-flexible multibody dynamics, highlighting their advantages and disadvantages.

*Floating Frame of reference formulation (FFR)* \
The Floating Frame of Reference (FFR) formulation is a modeling approach used in flexible multibody dynamics to analyze the behavior of systems comprising both rigid and flexible bodies. In this formulation, each flexible body is associated with a local reference frame—termed the "floating frame"—that captures the body's large overall (rigid-body) motion. Superimposed on this motion are small elastic deformations described relative to the floating frame. This method effectively decouples the large rigid-body motions from the small elastic deformations, allowing for efficient and accurate simulations under certain conditions. This method capture the rigid body motion but is valid only for small strain cases. The calculation of the inertia terms is a complex and tedious task.
@zwolferConciseNodalbasedDerivation2020a
@wasfyComputationalStrategiesFlexible2003a

*Absolute Nodal Coordinate formulation (ANCF)*\
The Absolute Nodal Coordinate Formulation (ANCF) is a finite element-based approach used in flexible multibody dynamics to model large deformations and rotations of flexible bodies. Unlike traditional formulations that separate rigid-body motion from deformation or use incremental rotations, ANCF employs absolute positions and gradients (slopes) of nodes as degrees of freedom. This approach allows for the accurate modeling of complex nonlinear behaviors, including significant bending, twisting, and stretching, without the limitations imposed by small deformation assumptions.
@shabanaOverviewANCFApproach2023 
@diboldDetailedComparisonAbsolute2009

*Nonlinear Finite element method*\
FEA is one of the most widely used methods for simulating deformable bodies. It is used to approximate the behavior of physical systems by discretizing them into smaller, simpler parts called finite elements. In dynamic studies, FEA becomes a crucial tool for analyzing systems where time-dependent effects like inertia, damping, and dynamic loading are significant
Explicit FEA is used in low time interval simulations like car crash. FFR, ACF and ANCF are techniques based on FEA. However FEA is not the best option for analyzing complex parts that are joined by some constraints. As the simulation of such systems is computationally expensive. FEA is suited for large strain analysis due to material non-linearity. 
@Bathe1995FiniteEP
@AnsysLSDYNACrash\

*Absolute Coordinate formulation (ACF)*\
In flexible multibody dynamics, the Absolute Coordinate Formulation (ACF) is a modeling approach that utilizes global Cartesian coordinates to describe the positions and orientations of all bodies within a system. This method contrasts with relative coordinate formulations, which define positions and orientations relative to other bodies or reference frames.\
All positions and orientations are expressed in a single, inertial coordinate system. This global perspective simplifies the formulation of equations of motion and the application of external forces.\
By using absolute coordinates, ACF directly represents the motion of each body without the need for transformations between local and global frames. This directness can simplify the mathematical representation of the system.\
Kinematic constraints, such as joints or prescribed motions, can be more straightforward to implement in ACF since all coordinates are defined in the same global frame. This uniformity can reduce the complexity of constraint equations.
@wasfyComputationalStrategiesFlexible2003a
@gerstmayr3DFiniteElement2006

*Co-simulation or Coupling methods*\
RBD is used to simulate rigid bodies and FEA to simulate deformable bodies. Co-simulation creates a bridge between these two methods so one can affect the simulation of the other. This way the effects of a deformable body can be considered in a RBD simulation. MPCCI @mpcci  is a tool built by the *"The Fraunhofer Institute for Algorithms
and Scientific Computing SCAI"* that creates a co-simulation environment by making two softwares "talk" to one another. For eg. Abaqus and Adams two commercial softwares are used to create a FEA-MBD co-simulation to simulate a system with *one* flexible body.
MPCCI provides two ways to couple - implicit and explicit , these are further explained in @ExplicitCoupling. 
\

@busch2010mbs explains the different coupling techniques like explicit, implicit and semi-implicit.
In @wangGluingAlgorithmDistributed a algorithm to couple such simulations is proposed along with the implementation details. A implicit approach is used where error function is defined based on the quantities at the interface. The idea is iterate until the error is minimized over every time-step. @ryuIntegrationFiniteElement2009 used this approach to couple FEA and flexible - MBD where the flexible body is modelled using the FFR approach. A similar method is proposed in @prescottRealTimeSimulationFlexible2016.\
@fernandez-fernandezSymXEnergybasedSimulation2023a @sicklingerInterfaceJacobianbasedCoSimulation2014 focus more on the coupling side methodology using symbolic or numeric computation.\
@trommeWeaklyFullyCoupled2016a
@inciSystemlevelCosimulationMechatronic



*incomplete *
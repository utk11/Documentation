
== MBD Setup
To simulate the rigid body dynamics of the system a custom code was written from ground up using the Julia programming language @bezanson2017julia. The code uses the Newmark's Integration method as shown in @Newmark which solves the index 3 differential algebraic equations.
To make sure that the code is performing correctly the solution of this code was compared with a commercial software called Adams developed by Hexagon @Adams. 

=== Test simulation
A slider crank mechanism was selected to test the validity of the code. This mechanism is made up of 3 bodies and ground : 
#figure(image("Pictures/2.svg", width: auto), caption: "Slider Crank Mechanism - CAD model")

+ piston
+ connecting rod
+ crank
and four joints
+ translational joint between the ground and piston (J4)
+ revolute joint between piston and connecting rod (J3)
+ revolute joint between connecting rod and crank (J2)
+ revolute joint between crank and ground (J1)

These joints are modelled using kinematic constraints explained in @DAEcons .\ *A body attached force on the crank provides motion to the system. This force causes the crank to rotate and hence the interconnected bodies move together*.
\

=== Code Implementation 
The RBD code is implemented in Julia. The implementation details are discussed here. 
+ System Container\
  A struct that holds the system information like number of rigid bodies and joint is created. It has to be initialized whenever a simulation is to be run. This struct also holds the vectors of rigid bodies and joints.
  ```Julia
mutable struct MBSystem
    bodies::Vector
    joints::Vector
    function MBSystem() #constructor
        global nbs = 0 #number of bodies
        global jts = 0 #number of joints
        bds = []
        joints = []
        return new(bds,joints)
    end
end
```
+ Rigid Bodies\
 This container holds the information about the rigid body like its mass, Inertia , position, orientation and initial velocity.
 ```jl
 mutable struct Rigidbody
    id::Int64
    m::Float64
    Iz::Float64
    initial_position::Vector{Float64}
    initial_velocity::Vector{Float64}
    function Rigidbody(sys::MBSystem,   #constructor
    M::Real,I::Real,IP::Vector,IV::Vector)

        global nbs+=1
        push!(sys.bodies,new(nbs,M,I,IP,IV))
        return new(nbs,M,I,IP,IV)
    end
end
 ```
 Every time a body is created the system container is updated to include it inside the container.
+ Joints\
 This struct as the name suggests creates joints, an example of the translational joint attached to the ground is presented below.
 ```Julia
 struct Prismatic_G
    jid::Int64
    Body::Rigidbody
    marker_in_body_coor::Vector #body marker for translational joint
    gp_in_abs_coor::Vector #ground point 
    function Prismatic_G(sys::MBSystem,
    B::Rigidbody,Marker1::Vector,Marker2::Vector)

        global jts+=1
        push!(sys.joints,new(jts,B,Marker1,Marker2))
        return new(jts,B,Marker1,Marker2)
    end
end
 ```
A function takes these structs and returns a function "F". This function "F" takes in the vector of generalized coordinates as a input. If the constraint is satisfied a vector of zeros is returned else the joint error as a vector is returned.\
A functional programming approach is used so the gap between theory and implementation is less.

#pagebreak()
=== Code Validation
Custom code and MSC Adams comparison:
#figure(image("/Pictures/RBD validation/my_code to Adams comparison  CN acc.png",width: auto),caption:"Acceleration of the connecting rod comparison")
#figure(image("Pictures/RBD validation/my_code to Adams comparison  CN force.png",width: auto), caption: "Constraint Force on the connecting rod comparison")


== FEA setup
To perform the FEA simulations a open source library called Ferrite.jl was used @Carlsson_Ferrite_jl. The library provides building blocks to solve the weak form of any partial differential equation. Using this library the equation of motion as explained in @CM and be solved.
=== Code Implementation
+ Creating Mesh\
 An Abaqus input file is imported via the library's built in function that creates a mesh.
 ```jl
grid = FerriteMeshParser.get_ferrite_grid("Job-3.inp")
 ```\

+ Material Modelling
 A linear isotropic model is used in the simulation. The library uses tensor notation instead of the widely used Voigt notation.
 ```jl
 Emod = 207e3 # Young's modulus [MPa]
 ν = 0.29
 E_voigt = Emod * [1.0 ν 0.0; ν 1.0 0.0; 0.0 0.0 (1-ν)/2] / (1 - ν^2)
 C = fromvoigt(SymmetricTensor{4,2}, E_voigt)
 ```\
 
+ Element Stiffness
 The stiffness matrix of each element is evaluated by.
 ```jl
 function assemble_cell!(ke, cellvalues, C)
    for q_point in 1:getnquadpoints(cellvalues)
        # Get the integration weight for the quadrature point
        dΩ = getdetJdV(cellvalues, q_point)
        for i in 1:getnbasefunctions(cellvalues)
            # Gradient of the test function
            ∇Nᵢ = shape_gradient(cellvalues, q_point, i)
            for j in 1:getnbasefunctions(cellvalues)
                # Symmetric gradient of the trial function
                ∇ˢʸᵐNⱼ = shape_symmetric_gradient(cellvalues, q_point, j)
                ke[i, j] += (∇Nᵢ ⊡ C ⊡ ∇ˢʸᵐNⱼ) * dΩ
            end
        end
    end
    return ke
end
 ``` \
 \
+ Assembly of Stiffness Matrix
 Contributions of all the elements is added to get the assembled stiffness matrix.
 ```jl
 function assemble_global!(K, dh, cellvalues, C)
    # Allocate the element stiffness matrix
    n_basefuncs = getnbasefunctions(cellvalues)
    ke = zeros(n_basefuncs, n_basefuncs)
    # Create an assembler
    assembler = start_assemble(K)
    # Loop over all cells
    for cell in CellIterator(dh)
        # Update the shape function gradients based on the cell coordinates
        reinit!(cellvalues, cell)
        # Reset the element stiffness matrix
        fill!(ke, 0.0)
        # Compute element contribution
        assemble_cell!(ke, cellvalues, C)
        # Assemble ke into K
        assemble!(assembler, celldofs(cell), ke)
    end
    return K
end
 ```
#pagebreak()
== Co-simulation Methodology
The simulation setup can be understood from the figure shown below.

#figure(image("Pictures/Simulation setup.png", width: 80%), caption: "Co-simulation Setup")
As seen from the figure the flexible body is separated from the RBD assembly and modelled as a FEA body in the respective code. This creates a void in the RBD code because of the body that was taken out from it. Naturally this would lead to a constraint deficiency in the RBD simulation. This is overcome by adding forces to the bodies to which the FEA body was connected. For eg the connecting rod was attached to the piston and crank. So the connected rod was replaced by a force on each body (piston and crank) at the point where they were connected as seen from the figure.
The table below lists all the different ways this co-simulation can be achieved.

#figure(table(columns:4,rows: auto,
[*Coupling Method*],[*Coupling Type*],[*FEA receives*],[*RBD receives*],
[Explicit],[Static FEA - Dynamic RBD],[displacement vector],[force vector],
[Explicit],[Dynamic FEA - Dynamic RBD],[acceleration vector],[force vector],
[Implicit],[Static FEA - Dynamic RBD],[force vector],[force vector],
[Implicit],[Dynamic FEA - Dynamic RBD],[force vector],[force vector]), caption: "Coupling methods" )<CPtable>

=== Interface Modelling 
This is the most important step in co-simulation. Implicit and explicit coupling is interfaced differently as the quantities that are sent and received are different in explicit while the same in implicit [@CPtable].\
On the side of RBD we have a single point whose information is available whereas on the FEA body there are multiple nodes. To relate a single point in RBD to multiple nodes is FEA is a challenging task.
Thus it is a necessary to model this interaction correctly for a accurate simulation.

+ Explicit Coupling Interface
    + Using kinematic constraints:<Kinematic>
        This method condenses all the FEA nodes at the interface to a single node for ease of modelling. It is achieved by kinematically constraining the neighboring nodes to a single node called the coupling node which is located in the middle. In FEA kinematic constraints are handled by master-slave method, Lagrange multipliers and penalty methods.
        #figure(image("Pictures/Kinematic node.png", width: 50%),caption: "")
    + Manually:<Manually>
        In this case the kinematic quantity coming from RBD is given as a boundary condition to all the interface nodes. And an average of the reaction force coming from all the nodes is calculated to revert back.

+ Implicit Coupling Interface\
    In implicit method a error function is defined that is minimized. For eg:
    $
    "error"(f) = sum^("fea nodes") (u^i_("fea")(f)-u^i_("rbd")(f))^2\ u in "kinematic quantity"
    $
This error function is dependent on the interface force. Starting with a initial guess this force is iterated using a Newton-Raphson technique. The jacobian required for it is calculated using finite differences. 

#pagebreak()
=== Explicit coupling<ExplicitCoupling>
Building on @IE there are two ways to couple FEA and RBD using the explicit method -
#figure(image("Pictures/drawing.svg"),caption: "Explicit Coupling Schematic")

==== Static - Dynamic
Static FEA is coupled with RBD which is a dynamic simulation. The quantity that is sent to FEA is 
$
  delta d^1 = (p_t_n - p_t_(n-1))\
  delta d^2 = (q_t_n - q_t_(n-1))
$
The FEA solver uses them as a boundary conditions and calculates the reaction forces at the nodes for which the boundary condition was prescribed. And revert back these forces. The reason for using 
==== Dynamic - Dynamic
Coupling Dynamic FEA and RBD which is also dynamic in nature is achieved by transferring acceleration and receiving force on the RBD side and vise versa on the FEA side. 

Unlike the static-dynamic coupling the information about the previous time step is not required for the RBD code to calculate the kinematic quantity that has to be sent. However the acceleration, velocity and displacement information from previous time-step of all the nodes is necessary for the FEA code. The FEA time integration uses this information to predict the quantities for the next time-step.

=== Implicit Coupling

#figure(image("Pictures/drawing 2.svg"), caption: "Implicit Coupling Schematic")
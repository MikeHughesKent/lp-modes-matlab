# Fibre LP Mode Solver and Simulator (Matlab)
Version 2.0, June 2020

Michael Hughes
m.r.hughes@kent.ac.uk

http://research.kent.ac.uk/applied-optics/hughes

A Python port of this code, with some additional feature and a GUI is now available at [https://github.com/MikeHughesKent/lpmodes].

## Description
This library solves the eigenvalue equation for a step-index fibre under the weakly-guided, linear polarisation approximation, generating propagation constants and other parameters, including power in core, for each of the supported LP modes. (The solution is only valid for small fibre numerical apertures with step index profiles.) Mode amplitudes and intensities can be plotted, and arbitrary input fields can be coupled into the fibre, allowing the coupling efficiency and power in each mode to be calculated. The fields can be propagated along an arbitrary length of fibre.
Functions are listed below with brief descriptions. Each function is fully documented in the .m files. See the examples for use of the various function.

## Version History
Replaces LP Mode Solver Version 1.2. The mode solver has not changed, but additional functions for simulating fibres have been added.

## Examples
* example_general: Defines a fibre, finds LP modes, plots all LP modes and displays 	example amplitude and intensity plots in figures.
* example_couple_beam:	Generates a Gaussian input beam and couples into fibre.
* example_coupling_angle:	Generates plane waves at a range of angles and calculates coupling efficiency for each, comparing with geometric acceptance angle.
* example_propagate_beam:	Couples a field into a fibre and propagates, displays field and intensity at far end of fibre.
* example_speckle_pattern:	Couples a random field into a fibre, propagates to generate speckle pattern at far end.

## Primary Functions

### Basic Fibre Properties:
* est_num_modes: Estimates the number of modes the fibre will support based on its V number.
* fibre_na:	Returns the fibre NA and geometric acceptance angle based on the core and cladding refractive index.

### Mode Solving:
* find_LP_modes: 	Find all LP modes of a specified fibre and light wavelength.

### Mode Plotting:
* plot_LP_mode_node: Generates a 2D amplitude plot of a specific mode, normalised.
* plot_LP_mode_profile: Generates a radial intensity or amplitude plot of a specific mode.
* plot_all_LP_modes: Plots all the LP modes found by find_LP_modes.
* power_in_core: Returns the power in core for each mode (based on 2D plot)

### Fibre Simulation:
* couple_beam: Simulates coupling of an arbitrary input field into the fibre, calculating amplitude and phase (and power) in each mode.
* tilted_field: Generates a plane wave at a specified angle, for use in coupling into fibre.
* propagate_through_fibre:	Propagates field through fibre. Field is projected onto modal basis, the phase of each mode is propagated according to its propagation constant, and the net field calculated.

### Secondary Functions
* calculate_LP_mismatch: Used by find_LP_modes to find solutions to the characteristic equation.


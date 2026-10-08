# HBAB–TAPA–COF simulation details

This repository contains molecular dynamics, potential of mean force (PMF), and electron density difference (EDD) calculations for HBAB, PSSNa, and ion interactions with HBAB–TAPA–COF.

## Calculation datasets

| Directory | Calculation |
|---|---|
| `pmf_hbab` | Interfacial PMF of HBAB |
| `pmf_pssna` | Interfacial PMF of PSSNa |
| `pmf_ions` | PMFs for Cs, Sr, and La |
| `edd_cations_cof` | COF–Cs, COF–Sr, and COF–La EDD calculations; reference COF geometry optimization |
| `edd_anions_cof` | COF–Cl and COF–SO4 EDD calculations |

## Quantum chemical calculations and parameterization

The initial periodic HBAB–TAPA–COF unit-cell geometry was optimized using CASTEP with the GGA-PBE functional. Atomic partial charges of the periodic framework were derived using the REPEAT method in CP2K.

PSSNa partial charges were assigned using the RESP method. The electrostatic potential was calculated at the B3LYP/6-311G** level with an implicit aqueous solvent model and analyzed using Multiwfn.

## Umbrella sampling and PMF reconstruction

Umbrella sampling was performed using the LAMMPS Colvars interface. The reaction coordinate is the z-position of the selected molecule or ion relative to a fixed reference at z = 0. Harmonic restraint centers are spaced by 1 Å (0.1 nm).

The effective harmonic force constant is 6 kcal mol⁻¹ Å⁻². The Colvars inputs specify `forceConstant 0.06` and `width 0.1`; Colvars scales the force constant by the inverse square of the width, giving `0.06 / 0.1² = 6`. This convention is described in the [Colvars reference manual](https://colvars.github.io/master/colvars-refman-lammps.html).

### Sampling parameters

| System | Restraint centers (Å) | Number of windows | Simulation per window | Equilibration excluded per window | Sampling used per window |
|---|---|---|---|---|---|
| HBAB | 30–83 | 54 | 5 ns | 1 ns | 4 ns |
| PSSNa | 30–83 | 54 | 5 ns | 1 ns | 4 ns |
| Cs, Sr, and La, each | 38–57 | 20 | 10 ns | 2 ns | 8 ns |

The `windows_*` directories group successive sampling windows. Each HBAB or PSSNa segment samples six centers over 30 ns; each ion segment samples five centers over 50 ns. The staged harmonic restraints are defined in the system-specific `.colvars` file.

Reaction-coordinate data are recorded every 100 MD steps. The `divide/divide.f90` programs exclude the initial equilibration records and extract window-specific trajectories, with filenames defined in `divide/window_files.txt`. The `his/his.f90` programs calculate window histograms. PMFs are reconstructed using the weighted histogram analysis method (WHAM), with trajectory paths, restraint centers, and force constants specified in `wham/input.dat`.

### Calculation files

| System directory | LAMMPS input | Colvars configuration | Structure and force-field data | PMF result |
|---|---|---|---|---|
| `pmf_hbab` | `hbab.in` | `hbab.colvars` | `hbab.data` | `wham/hbab.pmf` |
| `pmf_pssna` | `pssna.in` | `pssna.colvars` | `pssna.data` | `wham/pssna.pmf` |
| `pmf_ions/cs` | `cs.in` | `cs.colvars` | `cs.data` | `wham/cscl.pmf` |
| `pmf_ions/sr` | `sr.in` | `sr.colvars` | `sr.data` | `wham/srcl2.pmf` |
| `pmf_ions/la` | `la.in` | `la.colvars` | `la.data` | `wham/lacl3.pmf` |

LAMMPS inputs, Colvars configurations, and data files are located in the corresponding `windows_*` directories. `out.colvars.traj` contains reaction-coordinate data, `log.lammps` contains simulation and thermodynamic output, and `restart.1` and `restart.2` are LAMMPS restart files.

## Electron density difference calculations

EDD calculations evaluate charge redistribution upon combined system containing the ion and HBAB–TAPA–COF. Geometry optimization and density calculations were performed using CP2K/Quickstep.

### Geometry optimization

The reference COF and cation–COF complexes were optimized using PBE-D3(BJ), DZVP-MOLOPT-SR-GTH basis sets, and GTH-PBE pseudopotentials, with a plane-wave cutoff of 400 Ry and an SCF threshold of 1 × 10⁻⁶. The Cl and SO4 complexes were optimized using the CP2K xTB method with the BFGS optimizer and an SCF threshold of 1 × 10⁻⁶.

### Electron-density calculations

Single-point electron-density calculations used the Gaussian and plane waves (GPW) formalism, the PBE functional, DFT-D3(BJ) dispersion correction, DZVP-MOLOPT-SR-GTH basis sets, and GTH-PBE pseudopotentials. The plane-wave cutoff was 350 Ry and the SCF threshold was 5 × 10⁻⁶.

Electrostatics used XY periodicity and the Martyna–Tuckerman Poisson solver. Total charge and spin multiplicity are specified in each input. For each ion–COF system, the complex, COF component, and ion component were evaluated in the same simulation cell and on the same real-space grid. Component coordinates correspond to those in the optimized complex.

The electron density difference is defined as:

```text
Delta rho(r) = rho_complex(r) - rho_cof(r) - rho_ion(r)
```

The electron-density CUBE files were processed using Multiwfn. Electron accumulation and depletion are displayed using different colors; the Cs, Sr.

### Calculation structure

| Directory within each ion–COF system | Calculation |
|---|---|
| `01_geometry_optimization` | Optimization of the ion–COF complex |
| `02_density_calculation/01_complex` | Electron density of the ion–COF complex |
| `02_density_calculation/02_cof` | Electron density of the COF component |
| `02_density_calculation/03_ion` | Electron density of the ion component |

The reference COF optimization is located in `edd_cations_cof/cof_reference`. Component electron densities are stored as `.cub` or `.cube` files in the corresponding density-calculation subdirectories. The EDD result for each system is `02_density_calculation/edd.cub`.

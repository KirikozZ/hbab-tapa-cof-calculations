# HBAB–TAPA–COF calculation details

Cleaned PMF and electron density difference (EDD) calculation files for HBAB–TAPA–COF.

**Complete dataset:** [download the ZIP from Release v1.0.0](https://github.com/KirikozZ/hbab-tapa-cof-calculations/releases/tag/v1.0.0). The release includes a SHA-256 checksum file.

**Browse the data:** the five calculation directories below contain the same 544 calculation files as the release archive. Large scientific files are tracked with Git LFS.

Prepared: 2026-10-07. Updated: 2026-10-07. 当前包保留五类计算目录中的 544 个计算文件；源文件夹未修改。

## Contents

| Directory | Calculation |
|---|---|
| pmf_hbab | HBAB interfacial PMF |
| pmf_pssna | PSSNa interfacial PMF; final PMF corresponds to the PSS3 worksheet previously checked |
| pmf_ions | Cs, Sr and La ion PMF |
| edd_cations_cof | Cs, Sr and La EDD; upstream reference COF optimization |
| edd_anions_cof | Cl and SO4 EDD |

This ZIP follows the current edited package, omits the previously listed optional files, and additionally removes output.log and template.sh from all 30 PMF windows directories. Retained calculation data are approximately 4.959 GB before compression.

## Naming and file integrity

Directory and file names use lowercase ASCII and underscores. Sampling ranges use windows_<first>_<last>. EDD stages use 01_geometry_optimization and 02_density_calculation; density subcalculations use 01_complex, 02_cof and 03_ion. WHAM metadata INPUT is named input.dat; filename.txt is named window_files.txt.

Input/script file references and CP2K project labels have been updated to the packaged names. Configuration files use LF line endings. Scientific parameters, coordinate values and raw numerical results are preserved. Original output-log contents retain their historical names and project labels. External CP2K library identifiers (BASIS_MOLOPT, BASIS_MOLOPT_UCL, POTENTIAL and dftd3.dat) retain their case and must be supplied by the running environment.


## PMF workflow

Each PMF sampling directory uses system-specific LAMMPS filenames:

| System | Input | Data |
|---|---|---|
| HBAB | hbab.in | hbab.data |
| PSSNa | pssna.in | pssna.data |
| Cs | cs.in | cs.data |
| Sr | sr.in | sr.data |
| La | la.in | la.data |

The read_data command in every input points to its corresponding system data file. Run within a sampling directory, for example `lmp -in hbab.in` or `lmp -in cs.in`, using a suitable LAMMPS installation and launch options. The mix.colvars bias file remains referenced by the input. Each windows directory retains log.lammps; output.log and template.sh are omitted.


The WHAM directory retains every required window trajectory and input.dat. Use the actual WHAM command/version for the dataset, with input.dat in place of INPUT and the normalized PMF output filename. The command comment's historical bin count does not by itself establish the command that produced the current result.

The divide/window_files.txt and divide/divide.f90 are retained. The duplicate divide/outNN.colvars.traj outputs are omitted; they can be regenerated from divide/out.colvars.traj. The his/out.colvars.traj and histogram source/output are retained. The merged root-level trajectory copies are omitted. Original trajectories for each sampling segment are retained.

The optional local a.exe executables are omitted. For example, compile and run within each directory with `gfortran divide.f90 -o divide` followed by `./divide`, or `gfortran his.f90 -o his` followed by `./his`. Choose a suitable compiler and verify the analysis outputs. The existing WHAM binary is a Windows executable; running on another platform requires a compatible WHAM installation. Full atomic trajectories requested as equilibrium.lammpstrj are not present in the supplied folders; reaction-coordinate trajectories are not a replacement.

## EDD workflow

Each density task retains its input, output, structure where supplied, and one original electron-density CUBE. The 15 summary-level density copies are omitted. Final edd.cub files are retained. Use the task-level density paths below for subtraction/visualization; analysis/plotting scripts were not supplied in the source folders.

| Former summary density path | Retained archive path |
|---|---|
| `EDD-cation--COF/Cs/2_energy/Cs.cub` | `edd_cations_cof/cs/02_density_calculation/03_ion/cs.cub` |
| `EDD-cation--COF/Cs/2_energy/HBAB-TAPA-COF.cub` | `edd_cations_cof/cs/02_density_calculation/02_cof/hbab_tapa_cof.cub` |
| `EDD-cation--COF/Cs/2_energy/HBAB-TAPA-COF_Cs.cub` | `edd_cations_cof/cs/02_density_calculation/01_complex/hbab_tapa_cof_cs.cub` |
| `EDD-cation--COF/La/2_energy/HBAB-TAPA-COF.cub` | `edd_cations_cof/la/02_density_calculation/02_cof/hbab_tapa_cof.cub` |
| `EDD-cation--COF/La/2_energy/HBAB-TAPA-COF_La.cub` | `edd_cations_cof/la/02_density_calculation/01_complex/hbab_tapa_cof_la.cub` |
| `EDD-cation--COF/La/2_energy/La.cub` | `edd_cations_cof/la/02_density_calculation/03_ion/la.cub` |
| `EDD-cation--COF/Sr/2_energy/HBAB-TAPA-COF.cub` | `edd_cations_cof/sr/02_density_calculation/02_cof/hbab_tapa_cof.cub` |
| `EDD-cation--COF/Sr/2_energy/HBAB-TAPA-COF_Sr.cub` | `edd_cations_cof/sr/02_density_calculation/01_complex/hbab_tapa_cof_sr.cub` |
| `EDD-cation--COF/Sr/2_energy/Sr.cub` | `edd_cations_cof/sr/02_density_calculation/03_ion/sr.cub` |
| `EDD-anion--COF/Cl/2-energy/Cl.cub` | `edd_anions_cof/cl/02_density_calculation/03_ion/hbab_tapa_cof_2layer_cl_electron_density_1_0.cube` |
| `EDD-anion--COF/Cl/2-energy/HBAB-TAPA-COF-2layer-Cl.cub` | `edd_anions_cof/cl/02_density_calculation/01_complex/hbab_tapa_cof_2layer_cl_electron_density_1_0.cube` |
| `EDD-anion--COF/Cl/2-energy/HBAB-TAPA-COF-2layer.cub` | `edd_anions_cof/cl/02_density_calculation/02_cof/hbab_tapa_cof_2layer_cl_electron_density_1_0.cube` |
| `EDD-anion--COF/SO4/2-energy/HBAB-TAPA-COF-2layer-SO4.cub` | `edd_anions_cof/so4/02_density_calculation/01_complex/hbab_tapa_cof_2layer_so4_electron_density_1_0.cube` |
| `EDD-anion--COF/SO4/2-energy/HBAB-TAPA-COF-2layer.cub` | `edd_anions_cof/so4/02_density_calculation/02_cof/hbab_tapa_cof_2layer_so4_electron_density_1_0.cube` |
| `EDD-anion--COF/SO4/2-energy/SO4.cub` | `edd_anions_cof/so4/02_density_calculation/03_ion/hbab_tapa_cof_2layer_so4_electron_density_1_0.cube` |

Wavefunction restart files, BFGS Hessians, local Fortran executables and the three Cl spin-density CUBEs are omitted as requested; they remain in the original source folders. PMF restart.1/restart.2 files are retained. This package has not been validated by rerunning the full simulations.

## Downloading this repository

Install Git LFS, then clone and download the large data files:

```sh
git lfs install
git clone https://github.com/KirikozZ/hbab-tapa-cof-calculations.git
cd hbab-tapa-cof-calculations
git lfs pull
```

Alternatively, download the complete ZIP and checksum from [Release v1.0.0](https://github.com/KirikozZ/hbab-tapa-cof-calculations/releases/tag/v1.0.0); Git LFS is not required to use that ZIP. SHA256SUMS.txt contains checksums for the 544 calculation files in the repository.

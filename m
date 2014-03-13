From: m silverstri <michael.j.silverstri@gmail.com>
Subject: How to run sparse tool?
Date: Thu, 13 Mar 2014 09:49:48 -0700
Message-ID: <CABMudhRd=YmZbPURf27cKiJKYLswZCGoMqoxvXqu3DeGT7k_7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:41042 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbaCMQtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Mar 2014 12:49:49 -0400
Received: by mail-ob0-f172.google.com with SMTP id wm4so1322862obc.31
        for <linux-sparse@vger.kernel.org>; Thu, 13 Mar 2014 09:49:48 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I read http://kernelnewbies.org/Sparse and try to run sparse tool.

As a test, I run it on raspberry-pi/linux code base, by doing " make
C=3D2 drivers/staging/wlan-ng/", what I get is it asks me a list of
configuration question and it does not run sparse for me. How can I
bypass this setting up configuration and run sparse for the code?

Thank you.


 $ make C=3D2 drivers/staging/wlan-ng/
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf --silentoldconfig Kconfig
*
* Restart config...
*
*
* Linux/x86 3.10.33 Kernel Configuration
*
64-bit kernel (64BIT) [Y/n/?] (NEW)
*
* General setup
*
Cross-compiler tool prefix (CROSS_COMPILE) []
Local version - append to kernel release (LOCALVERSION) []
Automatically append version information to the version string
(LOCALVERSION_AUTO) [N/y/?] n
Kernel compression mode
  1. Gzip (KERNEL_GZIP)
  2. Bzip2 (KERNEL_BZIP2) (NEW)
  3. LZMA (KERNEL_LZMA)
  4. XZ (KERNEL_XZ)
> 5. LZO (KERNEL_LZO)
choice[1-5?]:
Default hostname (DEFAULT_HOSTNAME) [(none)] (none)
Support for paging of anonymous memory (swap) (SWAP) [Y/n/?] y
System V IPC (SYSVIPC) [Y/n/?] y
POSIX Message Queues (POSIX_MQUEUE) [N/y/?] n
open by fhandle syscalls (FHANDLE) [N/y/?] n
Auditing support (AUDIT) [N/y/?] n
*
* Timers subsystem
*
Timer tick handling
  1. Periodic timer ticks (constant rate, no dynticks) (HZ_PERIODIC)
> 2. Idle dynticks system (tickless idle) (NO_HZ_IDLE)
  3. Full dynticks system (tickless) (NO_HZ_FULL) (NEW)
choice[1-3]:
Old Idle dynticks config (NO_HZ) [Y/n/?] y
High Resolution Timer Support (HIGH_RES_TIMERS) [Y/n/?] y
*
* CPU/Task time and stats accounting
*
Cputime accounting
> 1. Simple tick based cputime accounting (TICK_CPU_ACCOUNTING)
  2. Full dynticks CPU time accounting (VIRT_CPU_ACCOUNTING_GEN) (NEW)
  3. Fine granularity task level IRQ time accounting (IRQ_TIME_ACCOUNTI=
NG)
choice[1-3]:
BSD Process Accounting (BSD_PROCESS_ACCT) [N/y/?] n
Export task/process statistics through netlink (TASKSTATS) [N/y/?] n
Kernel .config support (IKCONFIG) [N/m/y/?] n
Kernel log buffer size (16 =3D> 64KB, 17 =3D> 128KB) (LOG_BUF_SHIFT) [1=
8] 18
Checkpoint/restore support (CHECKPOINT_RESTORE) [N/y/?] n
Require conversions between uid/gids and their internal representation
(UIDGID_STRICT_TYPE_CHECKS) [N/y/?] n
Automatic process group scheduling (SCHED_AUTOGROUP) [N/y/?] n
Enable deprecated sysfs features to support old userspace tools
(SYSFS_DEPRECATED) [N/y/?] n
Kernel->user space relay support (formerly relayfs) (RELAY) [Y/n/?] y
Initial RAM filesystem and RAM disk (initramfs/initrd) support
(BLK_DEV_INITRD) [Y/n/?] y
  Initramfs source file(s) (INITRAMFS_SOURCE) []
  Support initial ramdisks compressed using gzip (RD_GZIP) [Y/n/?] y
  Support initial ramdisks compressed using bzip2 (RD_BZIP2) [N/y/?] n
  Support initial ramdisks compressed using LZMA (RD_LZMA) [N/y/?] n
  Support initial ramdisks compressed using XZ (RD_XZ) [N/y/?] n
  Support initial ramdisks compressed using LZO (RD_LZO) [N/y/?] n
Optimize for size (CC_OPTIMIZE_FOR_SIZE) [N/y/?] n
*
* Configure standard kernel features (expert users)
*
Configure standard kernel features (expert users) (EXPERT) [Y/n/?] y
  Sysctl syscall support (SYSCTL_SYSCALL) [N/y/?] n
  Load all symbols for debugging/ksymoops (KALLSYMS) [Y/?] y
    Include all symbols in kallsyms (KALLSYMS_ALL) [Y/?] y
  Enable support for printk (PRINTK) [Y/n/?] y
  BUG() support (BUG) [Y/n/?] y
  Enable ELF core dumps (ELF_CORE) [Y/n/?] y
  Enable PC-Speaker support (PCSPKR_PLATFORM) [Y/n/?] (NEW)
  Enable full-sized data structures for core (BASE_FULL) [Y/n/?] y
  Enable futex support (FUTEX) [Y/n/?] y
  Enable eventpoll support (EPOLL) [Y/n/?] y
  Enable signalfd() system call (SIGNALFD) [Y/n/?] y
  Enable timerfd() system call (TIMERFD) [Y/n/?] y
  Enable eventfd() system call (EVENTFD) [Y/n/?] y
  Use full shmem filesystem (SHMEM) [Y/n/?] y
  Enable AIO support (AIO) [Y/n/?] y
  Enable PCI quirk workarounds (PCI_QUIRKS) [Y/n/?] (NEW)
Embedded system (EMBEDDED) [N/y/?] n
Enable VM event counters for /proc/vmstat (VM_EVENT_COUNTERS) [Y/n/?] y
Enable SLUB debugging support (SLUB_DEBUG) [N/y/?] n
Disable heap randomization (COMPAT_BRK) [N/y/?] n
Choose SLAB allocator
  1. SLAB (SLAB)
> 2. SLUB (Unqueued Allocator) (SLUB)
  3. SLOB (Simple Allocator) (SLOB)
choice[1-3?]: 2
Profiling support (PROFILING) [N/y/?] n
Kprobes (KPROBES) [N/y/?] n
Optimize very unlikely/likely branches (JUMP_LABEL) [N/y/?] n
*
* Processor type and features
*
DMA memory allocation support (ZONE_DMA) [Y/n/?] (NEW)
Symmetric multi-processing support (SMP) [Y/n/?] y
Enable MPS table (X86_MPPARSE) [Y/n/?] (NEW)
Support for extended (non-PC) x86 platforms (X86_EXTENDED_PLATFORM)
[Y/n/?] (NEW)
ScaleMP vSMP (X86_VSMP) [N/y/?] (NEW)
Intel Low Power Subsystem Support (X86_INTEL_LPSS) [N/y/?] (NEW)
Single-depth WCHAN output (SCHED_OMIT_FRAME_POINTER) [Y/n/?] (NEW)
*
* Linux guest support
*
Linux guest support (HYPERVISOR_GUEST) [N/y/?] (NEW)
Memtest (MEMTEST) [N/y/?] (NEW)
Processor family
  1. Opteron/Athlon64/Hammer/K8 (MK8) (NEW)
  2. Intel P4 / older Netburst based Xeon (MPSC) (NEW)
  3. Core 2/newer Xeon (MCORE2) (NEW)
  4. Intel Atom (MATOM) (NEW)
> 5. Generic-x86-64 (GENERIC_CPU) (NEW)
choice[1-5]:
*
* Supported processor vendors
*
Supported processor vendors (PROCESSOR_SELECT) [N/y/?] (NEW)
Enable DMI scanning (DMI) [Y/n/?] (NEW)
GART IOMMU support (GART_IOMMU) [Y/n/?] (NEW)
IBM Calgary IOMMU support (CALGARY_IOMMU) [N/y/?] (NEW)
Enable Maximum number of SMP Processors and NUMA Nodes (MAXSMP) [N/y/?]=
 (NEW)
Maximum number of CPUs (NR_CPUS) [4] 4
SMT (Hyperthreading) scheduler support (SCHED_SMT) [N/y/?] n
Multi-core scheduler support (SCHED_MC) [N/y/?] n
Preemption Model
  1. No Forced Preemption (Server) (PREEMPT_NONE)
> 2. Voluntary Kernel Preemption (Desktop) (PREEMPT_VOLUNTARY)
  3. Preemptible Kernel (Low-Latency Desktop) (PREEMPT)
choice[1-3]: 2
Reroute for broken boot IRQs (X86_REROUTE_FOR_BROKEN_BOOT_IRQS) [N/y/?]=
 (NEW)
Machine Check / overheating reporting (X86_MCE) [Y/n/?] (NEW)
  Intel MCE features (X86_MCE_INTEL) [Y/n/?] (NEW)
  AMD MCE features (X86_MCE_AMD) [Y/n/?] (NEW)
Machine check injector support (X86_MCE_INJECT) [N/m/y/?] (NEW)
Dell laptop support (I8K) [N/m/y/?] (NEW)
CPU microcode loading support (MICROCODE) [N/m/y/?] (NEW)
/dev/cpu/*/msr - Model-specific register support (X86_MSR) [N/m/y/?] (N=
EW)
/dev/cpu/*/cpuid - CPU information support (X86_CPUID) [N/m/y/?] (NEW)
Enable 1GB pages for kernel pagetables (DIRECT_GBPAGES) [Y/n/?] (NEW)
Numa Memory Allocation and Scheduler Support (NUMA) [N/y/?] (NEW)
Memory model
> 1. Sparse Memory (SPARSEMEM_MANUAL) (NEW)
choice[1]: 1
Sparse Memory virtual memmap (SPARSEMEM_VMEMMAP) [Y/n/?] (NEW)
Allow for memory hot-add (MEMORY_HOTPLUG) [N/y] (NEW)
Allow for memory compaction (COMPACTION) [Y/n/?] y
Page migration (MIGRATION) [Y/?] y
Enable bounce buffers (BOUNCE) [Y/n/?] (NEW)
Enable KSM for page merging (KSM) [N/y/?] n
Low address space to protect from user allocation
(DEFAULT_MMAP_MIN_ADDR) [4096] 4096
Enable recovery from hardware memory errors (MEMORY_FAILURE) [N/y/?] (N=
EW)
Transparent Hugepage Support (TRANSPARENT_HUGEPAGE) [N/y/?] (NEW)
Cross Memory Support (CROSS_MEMORY_ATTACH) [Y/n/?] y
Enable cleancache driver to cache clean pages if tmem is present
(CLEANCACHE) [N/y/?] n
Enable frontswap to cache swap pages if tmem is present (FRONTSWAP) [N/=
y/?] n
Check for low memory corruption (X86_CHECK_BIOS_CORRUPTION) [N/y/?] (NE=
W)
Amount of low memory, in kilobytes, to reserve for the BIOS
(X86_RESERVE_LOW) [64] (NEW)
MTRR (Memory Type Range Register) support (MTRR) [Y/n/?] (NEW)
  MTRR cleanup support (MTRR_SANITIZER) [Y/n/?] (NEW)
    MTRR cleanup enable value (0-1) (MTRR_SANITIZER_ENABLE_DEFAULT) [0]=
 (NEW)
    MTRR cleanup spare reg num (0-7)
(MTRR_SANITIZER_SPARE_REG_NR_DEFAULT) [1] (NEW)
  x86 PAT support (X86_PAT) [Y/n/?] (NEW)
x86 architectural random number generator (ARCH_RANDOM) [Y/n/?] (NEW)
Supervisor Mode Access Prevention (X86_SMAP) [Y/n/?] (NEW)
EFI runtime service support (EFI) [N/y/?] (NEW)
Enable seccomp to safely compute untrusted bytecode (SECCOMP) [N/y/?] n
Enable -fstack-protector buffer overflow detection (CC_STACKPROTECTOR) =
[N/y/?] n
Timer frequency
  1. 100 HZ (HZ_100) (NEW)
> 2. 250 HZ (HZ_250) (NEW)
  3. 300 HZ (HZ_300) (NEW)
  4. 1000 HZ (HZ_1000) (NEW)
choice[1-4?]:
kexec system call (KEXEC) [N/y/?] n
kernel crash dumps (CRASH_DUMP) [N/y/?] n
Physical address where the kernel is loaded (PHYSICAL_START) [0x1000000=
] (NEW)
Build a relocatable kernel (RELOCATABLE) [Y/n/?] (NEW)
Support for hot-pluggable CPUs (HOTPLUG_CPU) [Y/?] y
  Set default setting of cpu0_hotpluggable (BOOTPARAM_HOTPLUG_CPU0)
[N/y/?] (NEW)
  Debug CPU0 hotplug (DEBUG_HOTPLUG_CPU0) [N/y/?] (NEW)
Built-in kernel command line (CMDLINE_BOOL) [N/y/?] (NEW)
*
* Power management and ACPI options
*
Suspend to RAM and standby (SUSPEND) [Y/n/?] y
Hibernation (aka 'suspend to disk') (HIBERNATION) [N/y/?] (NEW)
Opportunistic sleep (PM_AUTOSLEEP) [N/y/?] n
User space wakeup sources interface (PM_WAKELOCKS) [N/y/?] n
Run-time PM core functionality (PM_RUNTIME) [Y/n/?] y
Power Management Debug Support (PM_DEBUG) [Y/n/?] y
  Extra PM attributes in sysfs for low-level debugging/testing
(PM_ADVANCED_DEBUG) [N/y/?] n
  Test suspend/resume and wakealarm during bootup (PM_TEST_SUSPEND) [Y/=
n/?] y
Suspend/resume event tracing (PM_TRACE_RTC) [N/y/?] (NEW)
*
* ACPI (Advanced Configuration and Power Interface) Support
*
ACPI (Advanced Configuration and Power Interface) Support (ACPI) [Y/n/?=
] (NEW)
  Deprecated /proc/acpi files (ACPI_PROCFS) [N/y/?] (NEW)
  Deprecated power /proc/acpi directories (ACPI_PROCFS_POWER) [N/y/?] (=
NEW)
  EC read/write access through /sys/kernel/debug/ec (ACPI_EC_DEBUGFS)
[N/m/y/?] (NEW)
  Deprecated /proc/acpi/event support (ACPI_PROC_EVENT) [Y/n/?] (NEW)
  AC Adapter (ACPI_AC) [Y/n/m/?] (NEW)
  Battery (ACPI_BATTERY) [Y/n/m/?] (NEW)
  Button (ACPI_BUTTON) [Y/n/m/?] (NEW)
  Fan (ACPI_FAN) [Y/n/m/?] (NEW)
  Dock (ACPI_DOCK) [N/y/?] (NEW)
  Processor (ACPI_PROCESSOR) [Y/n/m/?] (NEW)
  Processor Aggregator (ACPI_PROCESSOR_AGGREGATOR) [N/m/y/?] (NEW)
  Thermal Zone (ACPI_THERMAL) [Y/n/m/?] (NEW)
  Custom DSDT Table file to include (ACPI_CUSTOM_DSDT_FILE) [] (NEW)
  ACPI tables override via initrd (ACPI_INITRD_TABLE_OVERRIDE) [N/y/?] =
(NEW)
  Debug Statements (ACPI_DEBUG) [N/y/?] (NEW)
  PCI slot detection driver (ACPI_PCI_SLOT) [N/y/?] (NEW)
  Power Management Timer Support (X86_PM_TIMER) [Y/n/?] (NEW)
  Container and Module Devices (ACPI_CONTAINER) [Y/?] (NEW) y
  Smart Battery System (ACPI_SBS) [N/m/y/?] (NEW)
  Hardware Error Device (ACPI_HED) [N/m/y/?] (NEW)
  Allow ACPI methods to be inserted/replaced at run time
(ACPI_CUSTOM_METHOD) [N/m/y/?] (NEW)
  ACPI Platform Error Interface (APEI) (ACPI_APEI) [N/y/?] (NEW)
*
* SFI (Simple Firmware Interface) Support
*
SFI (Simple Firmware Interface) Support (SFI) [N/y/?] (NEW)
CPU idle PM support (CPU_IDLE) [Y/?] y
  Support multiple cpuidle drivers (CPU_IDLE_MULTIPLE_DRIVERS) [N/y/?] =
(NEW)
Cpuidle Driver for Intel Processors (INTEL_IDLE) [N/y/?] (NEW)
*
* Memory power savings
*
Intel chipset idle memory power saving driver (I7300_IDLE) [N/m/y/?] (N=
EW)
*
* Bus options (PCI etc.)
*
PCI support (PCI) [Y/n/?] (NEW)
  Support mmconfig PCI config space access (PCI_MMCONFIG) [N/y] (NEW)
  Read CNB20LE Host Bridge Windows (PCI_CNB20LE_QUIRK) [N/y/?] (NEW)
  PCI Express support (PCIEPORTBUS) [N/y/?] (NEW)
Message Signaled Interrupts (MSI and MSI-X) (PCI_MSI) [N/y/?] (NEW)
PCI Debugging (PCI_DEBUG) [N/y/?] (NEW)
Enable PCI resource re-allocation detection (PCI_REALLOC_ENABLE_AUTO)
[N/y/?] (NEW)
PCI Stub driver (PCI_STUB) [N/m/y/?] (NEW)
Interrupts on hypertransport devices (HT_IRQ) [Y/n/?] (NEW)
PCI IOV support (PCI_IOV) [N/y/?] (NEW)
PCI PRI support (PCI_PRI) [N/y/?] (NEW)
PCI PASID support (PCI_PASID) [N/y/?] (NEW)
PCI IO-APIC hotplug support (PCI_IOAPIC) [N/m/y] (NEW)
ISA-style DMA support (ISA_DMA_API) [Y/n/?] (NEW)
*
* Support for PCI Hotplug
*
Support for PCI Hotplug (HOTPLUG_PCI) [N/m/y/?] (NEW)
RapidIO support (RAPIDIO) [N/y/?] (NEW)
*
* Executable file formats / Emulations
*
Kernel support for ELF binaries (BINFMT_ELF) [Y/n/?] y
Write ELF core dumps with partial segments
(CORE_DUMP_DEFAULT_ELF_HEADERS) [Y/n/?] y
Kernel support for scripts starting with #! (BINFMT_SCRIPT) [Y/n/m/?] y
Kernel support for MISC binaries (BINFMT_MISC) [M/n/y/?] m
Enable core dump support (COREDUMP) [Y/n/?] y
IA32 Emulation (IA32_EMULATION) [N/y/?] (NEW)
*
* Mapping drivers for chip access
*
Support non-linear mappings of flash chips (MTD_COMPLEX_MAPPINGS) [N/y/=
?] n
=46lash device in physical memory map (MTD_PHYSMAP) [N/m/y/?] n
CFI Flash device mapped on AMD SC520 CDP (MTD_SC520CDP) [N/m/y/?] (NEW)
CFI Flash device mapped on AMD NetSc520 (MTD_NETSC520) [N/m/y/?] (NEW)
JEDEC Flash device mapped on Technologic Systems TS-5500 (MTD_TS5500)
[N/m/y/?] (NEW)
BIOS flash chip on AMD76x southbridge (MTD_AMD76XROM) [N/m/y/?] (NEW)
BIOS flash chip on Intel Controller Hub 2/3/4/5 (MTD_ICHXROM) [N/m/y/?]=
 (NEW)
BIOS flash chip on Intel ESB Controller Hub 2 (MTD_ESB2ROM) [N/m/y/?] (=
NEW)
BIOS flash chip on Nvidia CK804 (MTD_CK804XROM) [N/m/y/?] (NEW)
BIOS flash chip on Intel SCB2 boards (MTD_SCB2_FLASH) [N/m/y/?] (NEW)
CFI flash device on SnapGear/SecureEdge (MTD_NETtel) [N/m/y/?] (NEW)
BIOS flash chip on Intel L440GX boards (MTD_L440GX) [N/m/y/?] (NEW)
NOR flash on Intel Vermilion Range Expansion Bus CS0
(MTD_INTEL_VR_NOR) [N/m/y/?] (NEW)
Map driver for platform device RAM (mtd-ram) (MTD_PLATRAM) [N/m/y/?] n
*
* Self-contained MTD device drivers
*
Ramix PMC551 PCI Mezzanine RAM card support (MTD_PMC551) [N/m/y/?] (NEW=
)
Support for AT45xxx DataFlash (MTD_DATAFLASH) [Y/n/m/?] y
  Verify DataFlash page writes (MTD_DATAFLASH_WRITE_VERIFY) [N/y/?] n
  DataFlash OTP support (Security Register) (MTD_DATAFLASH_OTP) [N/y/?]=
 n
Support most SPI Flash chips (AT26DF, M25P, W25X, ...) (MTD_M25P80) [Y/=
n/m/?] y
  Use FAST_READ OPCode allowing SPI CLK >=3D 50MHz
(M25PXX_USE_FAST_READ) [Y/n/?] y
Support SST25L (non JEDEC) SPI Flash chips (MTD_SST25L) [Y/n/m/?] y
Uncached system RAM (MTD_SLRAM) [N/m/y/?] n
Physical system RAM (MTD_PHRAM) [N/m/y/?] n
Test driver using RAM (MTD_MTDRAM) [N/m/y/?] n
MTD using block device (MTD_BLOCK2MTD) [N/m/y/?] n
*
* Disk-On-Chip Device Drivers
*
M-Systems Disk-On-Chip G3 (MTD_DOCG3) [N/m/y/?] n
*
* NAND Device Support
*
NAND Device Support (MTD_NAND) [Y/n/m/?] y
  Support software BCH ECC (MTD_NAND_ECC_BCH) [N/y/?] n
  Support Denali NAND controller (MTD_NAND_DENALI) [N/m/y/?] n
  Ricoh xD card reader (MTD_NAND_RICOH) [N/m/y/?] (NEW)
  DiskOnChip 2000, Millennium and Millennium Plus (NAND
reimplementation) (MTD_NAND_DISKONCHIP) [N/m/y/?] n
  Support for DiskOnChip G4 (MTD_NAND_DOCG4) [N/m/y/?] n
  NAND support for OLPC CAF=C9 chip (MTD_NAND_CAFE) [N/m/y/?] (NEW)
  Support for NAND Flash Simulator (MTD_NAND_NANDSIM) [N/m/y/?] n
  Support for generic platform NAND driver (MTD_NAND_PLATFORM) [N/m/y/?=
] n
  MTD driver for Olympus MAUSB-10 and Fujifilm DPC-R1 (MTD_ALAUDA) [N/m=
/y/?] n
*
* Plug and Play support
*
Plug and Play support (PNP) [Y/?] (NEW) y

  PNP debugging messages (PNP_DEBUG_MESSAGES) [Y/n/?] (NEW)   *
  * Protocols
  *
*
* Block devices
*
Block devices (BLK_DEV) [Y/n/?] y
  Normal floppy disk support (BLK_DEV_FD) [N/m/y/?] (NEW)
  Block Device Driver for Micron PCIe SSDs (BLK_DEV_PCIESSD_MTIP32XX)
[N/m/y/?] (NEW)
  Compaq SMART2 support (BLK_CPQ_DA) [N/m/y/?] (NEW)
  Compaq Smart Array 5xxx support (BLK_CPQ_CISS_DA) [N/m/y/?] (NEW)
  Mylex DAC960/DAC1100 PCI RAID Controller support (BLK_DEV_DAC960)
[N/m/y/?] (NEW)
  Micro Memory MM5415 Battery Backed RAM support (BLK_DEV_UMEM) [N/m/y/=
?] (NEW)
  Loopback device support (BLK_DEV_LOOP) [Y/n/m/?] y
    Number of loop devices to pre-create at init time
(BLK_DEV_LOOP_MIN_COUNT) [8] 8
    Cryptoloop Support (BLK_DEV_CRYPTOLOOP) [N/m/y/?] n
  DRBD Distributed Replicated Block Device support (BLK_DEV_DRBD) [N/m/=
y/?] n
  Network block device support (BLK_DEV_NBD) [N/m/y/?] n
  NVM Express block device (BLK_DEV_NVME) [N/m/y/?] (NEW)
  Promise SATA SX8 support (BLK_DEV_SX8) [N/m/y/?] (NEW)
  RAM block device support (BLK_DEV_RAM) [Y/n/m/?] y
    Default number of RAM disks (BLK_DEV_RAM_COUNT) [16] 16
    Default RAM disk size (kbytes) (BLK_DEV_RAM_SIZE) [65536] 65536
    Support XIP filesystems on RAM block device (BLK_DEV_XIP) [N/y/?] n
  Packet writing on CD/DVD media (CDROM_PKTCDVD) [N/m/y/?] n
  ATA over Ethernet support (ATA_OVER_ETH) [N/m/y/?] n
  Very old hard disk (MFM/RLL/IDE) driver (BLK_DEV_HD) [N/y/?] (NEW)
  Rados block device (RBD) (BLK_DEV_RBD) [N/m/y/?] n
  IBM FlashSystem 70/80 PCIe SSD Device Driver (BLK_DEV_RSXX) [N/m/y/?]=
 (NEW)
*
* Misc devices
*
Analog Devices Digital Potentiometers (AD525X_DPOT) [N/m/y/?] n
Dummy IRQ handler (DUMMY_IRQ) [N/m/y/?] n
Device driver for IBM RSA service processor (IBM_ASM) [N/m/y/?] (NEW)
Sensable PHANToM (PCI) (PHANTOM) [N/m/y/?] (NEW)
Parallel Trace Interface for MIPI P1149.7 cJTAG standard
(INTEL_MID_PTI) [N/m/y/?] (NEW)
SGI IOC4 Base IO support (SGI_IOC4) [N/m/y/?] (NEW)
TI Flash Media interface support (TIFM_CORE) [N/m/y/?] (NEW)
Integrated Circuits ICS932S401 (ICS932S401) [N/m/y/?] n
Device driver for Atmel SSC peripheral (ATMEL_SSC) [N/m/y/?] n
Enclosure Services (ENCLOSURE_SERVICES) [N/m/y/?] n
Channel interface driver for the HP iLO processor (HP_ILO) [N/m/y/?] (N=
EW)
Medfield Avago APDS9802 ALS Sensor module (APDS9802ALS) [N/m/y/?] n
Intersil ISL29003 ambient light sensor (ISL29003) [N/m/y/?] n
Intersil ISL29020 ambient light sensor (ISL29020) [N/m/y/?] n
Taos TSL2550 ambient light sensor (SENSORS_TSL2550) [N/m/y/?] n
ROHM BH1780GLI ambient light sensor (SENSORS_BH1780) [N/m/y/?] n
BH1770GLC / SFH7770 combined ALS - Proximity sensor (SENSORS_BH1770) [N=
/m/y/?] n
APDS990X combined als and proximity sensors (SENSORS_APDS990X) [N/m/y/?=
] n
Honeywell HMC6352 compass (HMC6352) [N/m/y/?] n
Dallas DS1682 Total Elapsed Time Recorder with Alarm (DS1682) [N/m/y/?]=
 n
Texas Instruments DAC7512 (TI_DAC7512) [N/m/y/?] n
BMP085 digital pressure sensor on I2C (BMP085_I2C) [N/m/y/?] n
BMP085 digital pressure sensor on SPI (BMP085_SPI) [N/m/y/?] n
Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) PHUB
(PCH_PHUB) [N/m/y/?] (NEW)
=46SA9480 USB Switch (USB_SWITCH_FSA9480) [N/m/y/?] n
Lattice ECP3 FPGA bitstream configuration via SPI
(LATTICE_ECP3_CONFIG) [N/m/y/?] n
Generic on-chip SRAM driver (SRAM) [Y/n/?] y
ENE CB710/720 Flash memory card reader support (CB710_CORE) [N/m/y/?] (=
NEW)
STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (I2C)
(SENSORS_LIS3_I2C) [N/m/y/?] n
*
* Altera FPGA firmware download module
*
Altera FPGA firmware download module (ALTERA_STAPL) [N/m/y/?] n
VMware VMCI Driver (VMWARE_VMCI) [N/m/y/?] (NEW)
*
* ATA/ATAPI/MFM/RLL support (DEPRECATED)
*
ATA/ATAPI/MFM/RLL support (DEPRECATED) (IDE) [N/m/y/?] (NEW)
*
* Serial ATA and Parallel ATA drivers
*
Serial ATA and Parallel ATA drivers (ATA) [Y/n/m/?] y
  Verbose ATA error reporting (ATA_VERBOSE_ERROR) [Y/n/?] y
  ATA ACPI Support (ATA_ACPI) [Y/n/?] (NEW)
    SATA Zero Power Optical Disc Drive (ZPODD) support (SATA_ZPODD)
[N/y/?] (NEW)
  SATA Port Multiplier support (SATA_PMP) [Y/n/?] y
  *
  * Controllers with non-SFF native interface
  *
  AHCI SATA support (SATA_AHCI) [N/m/y/?] (NEW)
  Platform AHCI SATA support (SATA_AHCI_PLATFORM) [Y/n/m/?] y
  Initio 162x SATA support (Very Experimental) (SATA_INIC162X) [N/m/y/?=
] (NEW)
  ACard AHCI variant (ATP 8620) (SATA_ACARD_AHCI) [N/m/y/?] (NEW)
  Silicon Image 3124/3132 SATA support (SATA_SIL24) [N/m/y/?] (NEW)
  ATA SFF support (for legacy IDE and PATA) (ATA_SFF) [Y/n/?] y
    *
    * SFF controllers with custom DMA interface
    *
    Pacific Digital ADMA support (PDC_ADMA) [N/m/y/?] (NEW)
    Pacific Digital SATA QStor support (SATA_QSTOR) [N/m/y/?] (NEW)
    Promise SATA SX4 support (Experimental) (SATA_SX4) [N/m/y/?] (NEW)
    ATA BMDMA support (ATA_BMDMA) [Y/n/?] y
      *
      * SATA SFF controllers with BMDMA
      *
      Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support (ATA_PIIX) [N/m/y/=
?] (NEW)
      Calxeda Highbank SATA support (SATA_HIGHBANK) [N/m/y/?] n
      Marvell SATA support (SATA_MV) [N/m/y/?] n
      NVIDIA SATA support (SATA_NV) [N/m/y/?] (NEW)
      Promise SATA TX2/TX4 support (SATA_PROMISE) [N/m/y/?] (NEW)
      Silicon Image SATA support (SATA_SIL) [N/m/y/?] (NEW)
      SiS 964/965/966/180 SATA support (SATA_SIS) [N/m/y/?] (NEW)
      ServerWorks Frodo / Apple K2 SATA support (SATA_SVW) [N/m/y/?] (N=
EW)
      ULi Electronics SATA support (SATA_ULI) [N/m/y/?] (NEW)
      VIA SATA support (SATA_VIA) [N/m/y/?] (NEW)
      VITESSE VSC-7174 / INTEL 31244 SATA support (SATA_VITESSE) [N/m/y=
/?] (NEW)
      *
      * PATA SFF controllers with BMDMA
      *
      ALi PATA support (PATA_ALI) [N/m/y/?] (NEW)
      AMD/NVidia PATA support (PATA_AMD) [N/m/y/?] (NEW)
      ARASAN CompactFlash PATA Controller Support (PATA_ARASAN_CF) [N/m=
/y/?] n
      ARTOP 6210/6260 PATA support (PATA_ARTOP) [N/m/y/?] (NEW)
      ATI PATA support (PATA_ATIIXP) [N/m/y/?] (NEW)
      ARTOP/Acard ATP867X PATA support (PATA_ATP867X) [N/m/y/?] (NEW)
      CMD64x PATA support (PATA_CMD64X) [N/m/y/?] (NEW)
      CS5510/5520 PATA support (PATA_CS5520) [N/m/y/?] (NEW)
      CS5530 PATA support (PATA_CS5530) [N/m/y/?] (NEW)
      CS5536 PATA support (PATA_CS5536) [N/m/y/?] (NEW)
      Cypress CY82C693 PATA support (Very Experimental) (PATA_CYPRESS)
[N/m/y/?] (NEW)
      EFAR SLC90E66 support (PATA_EFAR) [N/m/y/?] (NEW)
      HPT 366/368 PATA support (PATA_HPT366) [N/m/y/?] (NEW)
      HPT 370/370A/371/372/374/302 PATA support (PATA_HPT37X) [N/m/y/?]=
 (NEW)
      HPT 371N/372N/302N PATA support (PATA_HPT3X2N) [N/m/y/?] (NEW)
      HPT 343/363 PATA support (PATA_HPT3X3) [N/m/y/?] (NEW)
      IT8213 PATA support (Experimental) (PATA_IT8213) [N/m/y/?] (NEW)
      IT8211/2 PATA support (PATA_IT821X) [N/m/y/?] (NEW)
      JMicron PATA support (PATA_JMICRON) [N/m/y/?] (NEW)
      Marvell PATA support via legacy mode (PATA_MARVELL) [N/m/y/?] (NE=
W)
      NETCELL Revolution RAID support (PATA_NETCELL) [N/m/y/?] (NEW)
      Ninja32/Delkin Cardbus ATA support (PATA_NINJA32) [N/m/y/?] (NEW)
      Nat Semi NS87415 PATA support (PATA_NS87415) [N/m/y/?] (NEW)
      Intel PATA old PIIX support (PATA_OLDPIIX) [N/m/y/?] (NEW)
      OPTI FireStar PATA support (Very Experimental) (PATA_OPTIDMA)
[N/m/y/?] (NEW)
      Promise PATA 2027x support (PATA_PDC2027X) [N/m/y/?] (NEW)
      Older Promise PATA controller support (PATA_PDC_OLD) [N/m/y/?] (N=
EW)
      RADISYS 82600 PATA support (Experimental) (PATA_RADISYS) [N/m/y/?=
] (NEW)
      RDC PATA support (PATA_RDC) [N/m/y/?] (NEW)
      SC1200 PATA support (PATA_SC1200) [N/m/y/?] (NEW)
      Intel SCH PATA support (PATA_SCH) [N/m/y/?] (NEW)
      SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support
(PATA_SERVERWORKS) [N/m/y/?] (NEW)
      CMD / Silicon Image 680 PATA support (PATA_SIL680) [N/m/y/?] (NEW=
)
      SiS PATA support (PATA_SIS) [N/m/y/?] (NEW)
      Toshiba Piccolo support (Experimental) (PATA_TOSHIBA) [N/m/y/?] (=
NEW)
      Compaq Triflex PATA support (PATA_TRIFLEX) [N/m/y/?] (NEW)
      VIA PATA support (PATA_VIA) [N/m/y/?] (NEW)
      Winbond SL82C105 PATA support (PATA_WINBOND) [N/m/y/?] (NEW)
    *
    * PIO-only SFF controllers
    *
    CMD640 PCI PATA support (Experimental) (PATA_CMD640_PCI) [N/m/y/?] =
(NEW)
    Intel PATA MPIIX support (PATA_MPIIX) [N/m/y/?] (NEW)
    Nat Semi NS87410 PATA support (PATA_NS87410) [N/m/y/?] (NEW)
    OPTI621/6215 PATA support (Very Experimental) (PATA_OPTI) [N/m/y/?]=
 (NEW)
    Generic platform device PATA support (PATA_PLATFORM) [N/m/y/?] n
    PC Tech RZ1000 PATA support (PATA_RZ1000) [N/m/y/?] (NEW)
    *
    * Generic fallback / legacy drivers
    *
    ACPI firmware driver for PATA (PATA_ACPI) [N/m/y/?] (NEW)
    Generic ATA support (ATA_GENERIC) [N/m/y/?] (NEW)
    Legacy ISA PATA support (Experimental) (PATA_LEGACY) [N/m/y/?] (NEW=
)
*
* Fusion MPT device support
*
=46usion MPT device support (FUSION) [N/y/?] (NEW)
*
* IEEE 1394 (FireWire) support
*
=46ireWire driver stack (FIREWIRE) [N/m/y/?] (NEW)
Nosy - a FireWire traffic sniffer for PCILynx cards (FIREWIRE_NOSY)
[N/m/y/?] (NEW)
*
* I2O device support
*
I2O device support (I2O) [N/m/y/?] (NEW)
*
* Macintosh device drivers
*
Macintosh device drivers (MACINTOSH_DRIVERS) [N/y/?] (NEW)
*
* Network device support
*
Network device support (NETDEVICES) [Y/n/?] y
  Network core driver support (NET_CORE) [Y/n/?] y
    Bonding driver support (BONDING) [N/m/y/?] n
    Dummy net driver support (DUMMY) [N/m/y/?] n
    EQL (serial line load balancing) support (EQUALIZER) [N/m/y/?] n
    Fibre Channel driver support (NET_FC) [N/y/?] (NEW)
    Generic Media Independent Interface device support (MII) [Y/n/m/?] =
y
    MAC-VLAN support (MACVLAN) [N/m/y/?] n
    Virtual eXtensible Local Area Network (VXLAN) (VXLAN) [N/m/y/?] n
    Network console logging support (NETCONSOLE) [N/m/y/?] n
    Universal TUN/TAP device driver support (TUN) [N/m/y/?] n
    Virtual ethernet pair device (VETH) [N/m/y/?] n
  *
  * ARCnet support
  *
  ARCnet support (ARCNET) [N/m/y/?] (NEW)
  *
  * CAIF transport drivers
  *
  *
  * Ethernet driver support
  *
  Ethernet driver support (ETHERNET) [Y/n/?] y
    3Com devices (NET_VENDOR_3COM) [Y/n/?] (NEW)
      3c590/3c900 series (592/595/597) "Vortex/Boomerang" support
(VORTEX) [N/m/y/?] (NEW)
      3cr990 series "Typhoon" support (TYPHOON) [N/m/y/?] (NEW)
    Adaptec devices (NET_VENDOR_ADAPTEC) [Y/n/?] (NEW)
      Adaptec Starfire/DuraLAN support (ADAPTEC_STARFIRE) [N/m/y/?] (NE=
W)
    Alteon devices (NET_VENDOR_ALTEON) [Y/n/?] (NEW)
      Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support (ACENIC)
[N/m/y/?] (NEW)
    AMD devices (NET_VENDOR_AMD) [Y/n/?] (NEW)
      AMD 8111 (new PCI LANCE) support (AMD8111_ETH) [N/m/y/?] (NEW)
      AMD PCnet32 PCI support (PCNET32) [N/m/y/?] (NEW)
    Atheros devices (NET_VENDOR_ATHEROS) [Y/n/?] (NEW)
      Atheros L2 Fast Ethernet support (ATL2) [N/m/y/?] (NEW)
      Atheros/Attansic L1 Gigabit Ethernet support (ATL1) [N/m/y/?] (NE=
W)
      Atheros L1E Gigabit Ethernet support (ATL1E) [N/m/y/?] (NEW)
      Atheros L1C Gigabit Ethernet support (ATL1C) [N/m/y/?] (NEW)
      Qualcomm Atheros AR816x/AR817x support (ALX) [N/m/y/?] (NEW)
    Cadence devices (NET_CADENCE) [Y/n/?] y
      AT91RM9200 Ethernet support (ARM_AT91_ETHER) [N/m/y/?] n
      Cadence MACB/GEM support (MACB) [N/m/y/?] n
    Broadcom devices (NET_VENDOR_BROADCOM) [N/y/?] n
    Brocade devices (NET_VENDOR_BROCADE) [Y/n/?] (NEW)
      Brocade 1010/1020 10Gb Ethernet Driver support (BNA) [N/m/y/?] (N=
EW)
    Calxeda 1G/10G XGMAC Ethernet driver (NET_CALXEDA_XGMAC) [N/m/y/?] =
n
    Chelsio devices (NET_VENDOR_CHELSIO) [Y/n/?] (NEW)
      Chelsio 10Gb Ethernet support (CHELSIO_T1) [N/m/y/?] (NEW)
      Chelsio Communications T3 10Gb Ethernet support (CHELSIO_T3)
[N/m/y/?] (NEW)
      Chelsio Communications T4 Ethernet support (CHELSIO_T4) [N/m/y/?]=
 (NEW)
      Chelsio Communications T4 Virtual Function Ethernet support
(CHELSIO_T4VF) [N/m/y/?] (NEW)
    Cisco devices (NET_VENDOR_CISCO) [Y/n/?] (NEW)
      Cisco VIC Ethernet NIC Support (ENIC) [N/m/y/?] (NEW)
    Dave ethernet support (DNET) (DNET) [N/m/y/?] n
    Digital Equipment devices (NET_VENDOR_DEC) [Y/n/?] (NEW)
      DEC - Tulip devices (NET_TULIP) [N/y/?] (NEW)
    D-Link devices (NET_VENDOR_DLINK) [Y/n/?] (NEW)
      DL2000/TC902x-based Gigabit Ethernet support (DL2K) [N/m/y/?] (NE=
W)
      Sundance Alta support (SUNDANCE) [N/m/y/?] (NEW)
    Emulex devices (NET_VENDOR_EMULEX) [Y/n/?] (NEW)
      ServerEngines' 10Gbps NIC - BladeEngine (BE2NET) [N/m/y/?] (NEW)
    Exar devices (NET_VENDOR_EXAR) [Y/n/?] (NEW)
      Exar Xframe 10Gb Ethernet Adapter (S2IO) [N/m/y/?] (NEW)
      Exar X3100 Series 10GbE PCIe Server Adapter (VXGE) [N/m/y/?] (NEW=
)
    HP devices (NET_VENDOR_HP) [Y/n/?] (NEW)
      HP 10/100VG PCLAN (ISA, EISA, PCI) support (HP100) [N/m/y/?] (NEW=
)
    Intel devices (NET_VENDOR_INTEL) [N/y/?] n
    IP1000 Gigabit Ethernet support (IP1000) [N/m/y/?] (NEW)
    JMicron(R) PCI-Express Gigabit Ethernet support (JME) [N/m/y/?] (NE=
W)
    Marvell devices (NET_VENDOR_MARVELL) [N/y/?] n
    Mellanox devices (NET_VENDOR_MELLANOX) [Y/n/?] (NEW)
      Mellanox Technologies 10Gbit Ethernet support (MLX4_EN) [N/m/y/?]=
 (NEW)
    Micrel devices (NET_VENDOR_MICREL) [N/y/?] n
    Microchip devices (NET_VENDOR_MICROCHIP) [N/y/?] n
    Myricom devices (NET_VENDOR_MYRI) [Y/n/?] (NEW)
      Myricom Myri-10G Ethernet support (MYRI10GE) [N/m/y/?] (NEW)
    Myson MTD-8xx PCI Ethernet support (FEALNX) [N/m/y/?] (NEW)
    National Semi-conductor devices (NET_VENDOR_NATSEMI) [N/y/?] n
    NVIDIA devices (NET_VENDOR_NVIDIA) [Y/n/?] (NEW)
      nForce Ethernet support (FORCEDETH) [N/m/y/?] (NEW)
    OKI Semiconductor devices (NET_VENDOR_OKI) [Y/n/?] (NEW)
      OKI SEMICONDUCTOR IOH(ML7223/ML7831) GbE (PCH_GBE) [N/m/y/?] (NEW=
)
    OpenCores 10/100 Mbps Ethernet MAC support (ETHOC) [N/m/y/?] n
    Packet Engine devices (NET_PACKET_ENGINE) [Y/n/?] (NEW)
      Packet Engines Hamachi GNIC-II support (HAMACHI) [N/m/y/?] (NEW)
      Packet Engines Yellowfin Gigabit-NIC support (YELLOWFIN) [N/m/y/?=
] (NEW)
    QLogic devices (NET_VENDOR_QLOGIC) [Y/n/?] (NEW)
      QLogic QLA3XXX Network Driver Support (QLA3XXX) [N/m/y/?] (NEW)
      QLOGIC QLCNIC 1/10Gb Converged Ethernet NIC Support (QLCNIC)
[N/m/y/?] (NEW)
      QLogic QLGE 10Gb Ethernet Driver Support (QLGE) [N/m/y/?] (NEW)
      NetXen Multi port (1/10) Gigabit Ethernet NIC (NETXEN_NIC) [N/m/y=
/?] (NEW)
    Realtek devices (NET_VENDOR_REALTEK) [Y/n/?] (NEW)
      RealTek RTL-8139 C+ PCI Fast Ethernet Adapter support (8139CP)
[N/m/y/?] (NEW)
      RealTek RTL-8129/8130/8139 PCI Fast Ethernet Adapter support
(8139TOO) [N/m/y/?] (NEW)
      Realtek 8169 gigabit ethernet support (R8169) [N/m/y/?] (NEW)
    RDC devices (NET_VENDOR_RDC) [Y/n/?] (NEW)
      RDC R6040 Fast Ethernet Adapter support (R6040) [N/m/y/?] (NEW)
    SEEQ devices (NET_VENDOR_SEEQ) [N/y/?] n
    Silan devices (NET_VENDOR_SILAN) [Y/n/?] (NEW)
      Silan SC92031 PCI Fast Ethernet Adapter driver (SC92031) [N/m/y/?=
] (NEW)
    Silicon Integrated Systems (SiS) devices (NET_VENDOR_SIS) [Y/n/?] (=
NEW)
      SiS 900/7016 PCI Fast Ethernet Adapter support (SIS900) [N/m/y/?]=
 (NEW)
      SiS190/SiS191 gigabit ethernet support (SIS190) [N/m/y/?] (NEW)
    Solarflare SFC4000/SFC9000-family support (SFC) [N/m/y/?] (NEW)
    SMC (SMSC)/Western Digital devices (NET_VENDOR_SMSC) [Y/n/?] y
      SMC EtherPower II (EPIC100) [N/m/y/?] (NEW)
      SMSC LAN9420 PCI ethernet adapter support (SMSC9420) [N/m/y/?] (N=
EW)
    STMicroelectronics devices (NET_VENDOR_STMICRO) [N/y/?] n
    Sun devices (NET_VENDOR_SUN) [Y/n/?] (NEW)
      Sun Happy Meal 10/100baseT support (HAPPYMEAL) [N/m/y/?] (NEW)
      Sun GEM support (SUNGEM) [N/m/y/?] (NEW)
      Sun Cassini support (CASSINI) [N/m/y/?] (NEW)
      Sun Neptune 10Gbit Ethernet support (NIU) [N/m/y/?] (NEW)
    Tehuti devices (NET_VENDOR_TEHUTI) [Y/n/?] (NEW)
      Tehuti Networks 10G Ethernet (TEHUTI) [N/m/y/?] (NEW)
    Texas Instruments (TI) devices (NET_VENDOR_TI) [Y/n/?] (NEW)
      TI ThunderLAN support (TLAN) [N/m/y/?] (NEW)
    VIA devices (NET_VENDOR_VIA) [Y/n/?] (NEW)
      VIA Rhine support (VIA_RHINE) [N/m/y/?] (NEW)
      VIA Velocity support (VIA_VELOCITY) [N/m/y/?] (NEW)
    WIZnet devices (NET_VENDOR_WIZNET) [Y/n/?] y
      WIZnet W5100 Ethernet support (WIZNET_W5100) [N/m/y/?] n
      WIZnet W5300 Ethernet support (WIZNET_W5300) [N/m/y/?] n
  FDDI driver support (FDDI) [N/m/y/?] (NEW)
  HIPPI driver support (HIPPI) [N/y/?] (NEW)
  General Instruments Surfboard 1000 (NET_SB1000) [N/m/y/?] (NEW)
  Micrel KS8995MA 5-ports 10/100 managed Ethernet switch
(MICREL_KS8995MA) [N/m/y] n
  PPP (point-to-point protocol) support (PPP) [N/m/y/?] n
  SLIP (serial line) support (SLIP) [N/m/y/?] n
  *
  * Wireless LAN
  *
  Wireless LAN (WLAN) [Y/n/?] y
    Marvell 8xxx Libertas WLAN driver support with thin firmware
(LIBERTAS_THINFIRM) [N/m/y/?] n
    Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards (AIRO) [N/m/y/?] =
(NEW)
    Atmel at76c50x chipset  802.11b support (ATMEL) [N/m/y/?] (NEW)
    Atmel at76c503/at76c505/at76c505a USB cards (AT76C50X_USB) [N/m/y/?=
] n
    Intersil Prism GT/Duette/Indigo PCI/Cardbus (DEPRECATED) (PRISM54)
[N/m/y/?] (NEW)
    USB ZD1201 based Wireless device support (USB_ZD1201) [N/m/y/?] n
    Wireless RNDIS USB support (USB_NET_RNDIS_WLAN) [N/m/y/?] n
    Realtek 8180/8185 PCI support (RTL8180) [N/m/y/?] (NEW)
    Realtek 8187 and 8187B USB support (RTL8187) [N/m/y/?] n
    ADMtek ADM8211 support (ADM8211) [N/m/y/?] (NEW)
    Simulated radio testing tool for mac80211 (MAC80211_HWSIM) [N/m/y/?=
] n
    Marvell 88W8xxx PCI/PCIe Wireless support (MWL8K) [N/m/y/?] (NEW)
    Broadcom 43xx wireless support (mac80211 stack) (B43) [N/m/y/?] n
    Broadcom 43xx-legacy wireless support (mac80211 stack) (B43LEGACY)
[N/m/y/?] n
    Broadcom IEEE802.11n embedded FullMAC WLAN driver (BRCMFMAC) [M/n/y=
/?] m
      SDIO bus interface support for FullMAC driver (BRCMFMAC_SDIO) [Y/=
n/?] y
      USB bus interface support for FullMAC driver (BRCMFMAC_USB) [N/y/=
?] n
    Broadcom device tracing (BRCM_TRACING) [N/y/?] n
    Broadcom driver debug functions (BRCMDBG) [N/y/?] n
    IEEE 802.11 for Host AP (Prism2/2.5/3 and WEP/TKIP/CCMP) (HOSTAP)
[N/m/y/?] n
    Intel PRO/Wireless 2100 Network Connection (IPW2100) [N/m/y/?] (NEW=
)
    Intel Wireless WiFi Next Gen AGN -
Wireless-N/Advanced-N/Ultimate-N (iwlwifi)  (IWLWIFI) [N/m/y/?] (NEW)
    Intel Wireless WiFi 4965AGN (iwl4965) (IWL4965) [N/m/y/?] (NEW)
    Intel PRO/Wireless 3945ABG/BG Network Connection (iwl3945)
(IWL3945) [N/m/y/?] (NEW)
    Marvell 8xxx Libertas WLAN driver support (LIBERTAS) [N/m/y/?] n
    Softmac Prism54 support (P54_COMMON) [N/m/y/?] n
    ZyDAS ZD1211/ZD1211B USB-wireless support (ZD1211RW) [N/m/y/?] n
    Marvell WiFi-Ex Driver (MWIFIEX) [N/m/y/?] n
    Realtek 8192C USB WiFi (RTL8192CU) [N/m/y/?] n
  *
  * Enable WiMAX (Networking options) to see the WiMAX drivers
  *
  VMware VMXNET3 ethernet driver (VMXNET3) [N/m/y/?] (NEW)
*
* Mice
*
Mice (INPUT_MOUSE) [Y/n/?] y
  PS/2 mouse (MOUSE_PS2) [M/n/y/?] m
    ALPS PS/2 mouse protocol extension (MOUSE_PS2_ALPS) [Y/n/?] y
    Logitech PS/2++ mouse protocol extension (MOUSE_PS2_LOGIPS2PP) [Y/n=
/?] y
    Synaptics PS/2 mouse protocol extension (MOUSE_PS2_SYNAPTICS) [Y/n/=
?] y
    Cypress PS/2 mouse protocol extension (MOUSE_PS2_CYPRESS) [Y/n/?] y
    Fujitsu Lifebook PS/2 mouse protocol extension
(MOUSE_PS2_LIFEBOOK) [Y/n/?] (NEW)
    IBM Trackpoint PS/2 mouse protocol extension
(MOUSE_PS2_TRACKPOINT) [Y/n/?] y
    Elantech PS/2 protocol extension (MOUSE_PS2_ELANTECH) [Y/n/?] y
    Sentelic Finger Sensing Pad PS/2 protocol extension
(MOUSE_PS2_SENTELIC) [N/y/?] n
    eGalax TouchKit PS/2 protocol extension (MOUSE_PS2_TOUCHKIT) [N/y/?=
] n
  Serial mouse (MOUSE_SERIAL) [N/m/y/?] n
  Apple USB Touchpad support (MOUSE_APPLETOUCH) [N/m/y/?] n
  Apple USB BCM5974 Multitouch trackpad support (MOUSE_BCM5974) [N/m/y/=
?] n
  Cypress APA I2C Trackpad support (MOUSE_CYAPA) [N/m/y/?] n
  DEC VSXXX-AA/GA mouse and VSXXX-AB tablet (MOUSE_VSXXXAA) [N/m/y/?] n
  GPIO mouse (MOUSE_GPIO) [N/m/y/?] n
  Synaptics I2C Touchpad support (MOUSE_SYNAPTICS_I2C) [N/m/y/?] n
  Synaptics USB device support (MOUSE_SYNAPTICS_USB) [N/m/y/?] n
*
* Miscellaneous devices
*
Miscellaneous devices (INPUT_MISC) [Y/n/?] y
  Analog Devices AD714x Capacitance Touch Sensor (INPUT_AD714X) [N/m/y/=
?] n
  BMA150/SMB380 acceleration sensor support (INPUT_BMA150) [N/m/y/?] n
  PC Speaker support (INPUT_PCSPKR) [N/m/y/?] (NEW)
  MC13783 ON buttons (INPUT_MC13783_PWRBUTTON) [N/m/y/?] n
  MMA8450 - Freescale's 3-Axis, 8/12-bit Digital Accelerometer
(INPUT_MMA8450) [Y/n/m/?] y
  MPU3050 Triaxial gyroscope sensor (INPUT_MPU3050) [N/m/y/?] n
  Fujitsu Lifebook Application Panel buttons (INPUT_APANEL) [N/m/y/?] (=
NEW)
  Sharp GP2AP002A00F I2C Proximity/Opto sensor driver (INPUT_GP2A) [N/m=
/y/?] n
  Polled GPIO tilt switch (INPUT_GPIO_TILT_POLLED) [N/m/y/?] n
  x86 Atlas button interface (INPUT_ATLAS_BTNS) [N/m/y/?] (NEW)
  ATI / Philips USB RF remote control (INPUT_ATI_REMOTE2) [N/m/y/?] n
  Keyspan DMR USB remote control (INPUT_KEYSPAN_REMOTE) [N/m/y/?] n
  Kionix KXTJ9 tri-axis digital accelerometer (INPUT_KXTJ9) [N/m/y/?] n
  Griffin PowerMate and Contour Jog support (INPUT_POWERMATE) [N/m/y/?]=
 n
  Yealink usb-p1k voip phone (INPUT_YEALINK) [N/m/y/?] n
  C-Media CM109 USB I/O Controller (INPUT_CM109) [N/m/y/?] n
  User level driver support (INPUT_UINPUT) [N/m/y/?] n
  PCF8574 Keypad input device (INPUT_PCF8574) [N/m/y/?] n
  PWM beeper support (INPUT_PWM_BEEPER) [N/m/y/?] n
  Rotary encoders connected to GPIO pins (INPUT_GPIO_ROTARY_ENCODER) [N=
/m/y/?] n
  Dialog DA9052/DA9053 Onkey (INPUT_DA9052_ONKEY) [N/m/y/?] n
  Analog Devices ADXL34x Three-Axis Digital Accelerometer
(INPUT_ADXL34X) [N/m/y/?] n
  IMS Passenger Control Unit driver (INPUT_IMS_PCU) [N/m/y/?] n
  VTI CMA3000 Tri-axis accelerometer (INPUT_CMA3000) [N/m/y/?] n
*
* Hardware I/O ports
*
Serial I/O support (SERIO) [Y/?] y
  i8042 PC Keyboard controller (SERIO_I8042) [Y/?] (NEW) y
  Serial port line discipline (SERIO_SERPORT) [M/n/y/?] m
  ct82c710 Aux port controller (SERIO_CT82C710) [N/m/y/?] (NEW)
  PCI PS/2 keyboard and PS/2 mouse controller (SERIO_PCIPS2) [N/m/y/?] =
(NEW)
  PS/2 driver library (SERIO_LIBPS2) [Y/?] y
  Raw access to serio ports (SERIO_RAW) [N/m/y/?] n
  Altera UP PS/2 controller (SERIO_ALTERA_PS2) [N/m/y/?] n
  TQC PS/2 multiplexer (SERIO_PS2MULT) [N/m/y/?] n
  ARC PS/2 support (SERIO_ARC_PS2) [N/m/y/?] n
Gameport support (GAMEPORT) [N/m/y/?] n
*
* Character devices
*
Enable TTY (TTY) [Y/n/?] y
  Virtual terminal (VT) [Y/n/?] y
    Enable character translations in console (CONSOLE_TRANSLATIONS) [Y/=
n/?] y
    Support for console on virtual terminal (VT_CONSOLE) [Y/n/?] y
    Support for binding and unbinding console drivers
(VT_HW_CONSOLE_BINDING) [N/y/?] n
  Unix98 PTY support (UNIX98_PTYS) [Y/n/?] y
    Support multiple instances of devpts (DEVPTS_MULTIPLE_INSTANCES) [N=
/y/?] n
  Legacy (BSD) PTY support (LEGACY_PTYS) [N/y/?] n
  Non-standard serial port support (SERIAL_NONSTANDARD) [N/y/?] n
  HSDPA Broadband Wireless Data Card - Globe Trotter (NOZOMI) [N/m/y/?]=
 (NEW)
  GSM MUX line discipline support (EXPERIMENTAL) (N_GSM) [N/m/y/?] n
  Trace data sink for MIPI P1149.7 cJTAG standard (TRACE_SINK) [N/m/y/?=
] n
/dev/kmem virtual device support (DEVKMEM) [N/y/?] n
*
* Serial drivers
*
8250/16550 and compatible serial support (SERIAL_8250) [N/m/y/?] n
*
* Non-8250 serial port support
*
MAX3100 support (SERIAL_MAX3100) [N/m/y/?] n
MAX310X support (SERIAL_MAX310X) [N/y/?] n
Medfield High Speed UART support (SERIAL_MFD_HSU) [N/m/y] (NEW)
Digi International NEO PCI Support (SERIAL_JSM) [N/m/y/?] (NEW)
SCCNXP serial port support (SERIAL_SCCNXP) [N/m/y/?] n
Support for timberdale UART (SERIAL_TIMBERDALE) [N/m/y/?] n
Altera JTAG UART support (SERIAL_ALTERA_JTAGUART) [N/m/y/?] n
Altera UART support (SERIAL_ALTERA_UART) [N/m/y/?] n
SPI protocol driver for Infineon 6x60 modem (EXPERIMENTAL)
(SERIAL_IFX6X60) [N/m/y/?] n
Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) UART
(SERIAL_PCH_UART) [N/m/y/?] (NEW)
ARC UART driver support (SERIAL_ARC) [N/m/y/?] n
Comtrol RocketPort EXPRESS/INFINITY support (SERIAL_RP2) [N/m/y/?] (NEW=
)
TTY driver to output user messages via printk (TTY_PRINTK) [N/y/?] n
Hardware Random Number Generator Core support (HW_RANDOM) [Y/n/m/?] y
  Timer IOMEM HW Random Number Generator support
(HW_RANDOM_TIMERIOMEM) [N/m/y/?] n
  Intel HW Random Number Generator support (HW_RANDOM_INTEL) [Y/n/m/?] =
(NEW)
  AMD HW Random Number Generator support (HW_RANDOM_AMD) [Y/n/m/?] (NEW=
)
  VIA HW Random Number Generator support (HW_RANDOM_VIA) [Y/n/m/?] (NEW=
)
/dev/nvram support (NVRAM) [N/m/y/?] (NEW)
Siemens R3964 line discipline (R3964) [N/m/y/?] n
Applicom intelligent fieldbus card support (APPLICOM) [N/m/y/?] (NEW)
ACP Modem (Mwave) support (MWAVE) [N/m/y/?] (NEW)
RAW driver (/dev/raw/rawN) (RAW_DRIVER) [N/m/y/?] n
HPET - High Precision Event Timer (HPET) [N/y/?] (NEW)
Hangcheck timer (HANGCHECK_TIMER) [N/m/y/?] (NEW)
Telecom clock driver for ATCA SBC (TELCLOCK) [N/m/y/?] (NEW)
*
* I2C Hardware Bus support
*
*
* PC SMBus host controller drivers
*
ALI 1535 (I2C_ALI1535) [N/m/y/?] (NEW)
ALI 1563 (I2C_ALI1563) [N/m/y/?] (NEW)
ALI 15x3 (I2C_ALI15X3) [N/m/y/?] (NEW)
AMD 756/766/768/8111 and nVidia nForce (I2C_AMD756) [N/m/y/?] (NEW)
AMD 8111 (I2C_AMD8111) [N/m/y/?] (NEW)
Intel 82801 (ICH/PCH) (I2C_I801) [N/m/y/?] (NEW)
Intel SCH SMBus 1.0 (I2C_ISCH) [N/m/y/?] (NEW)
Intel iSMT SMBus Controller (I2C_ISMT) [N/m/y/?] (NEW)
Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)
(I2C_PIIX4) [N/m/y/?] (NEW)
Nvidia nForce2, nForce3 and nForce4 (I2C_NFORCE2) [N/m/y/?] (NEW)
SiS 5595 (I2C_SIS5595) [N/m/y/?] (NEW)
SiS 630/730/964 (I2C_SIS630) [N/m/y/?] (NEW)
SiS 96x (I2C_SIS96X) [N/m/y/?] (NEW)
VIA VT82C586B (I2C_VIA) [N/m/y/?] (NEW)
VIA VT82C596/82C686/82xx and CX700/VX8xx/VX900 (I2C_VIAPRO) [N/m/y/?] (=
NEW)
*
* ACPI drivers
*
SMBus Control Method Interface (I2C_SCMI) [N/m/y/?] (NEW)
*
* I2C system bus drivers (mostly embedded / system-on-chip)
*
CBUS I2C driver (I2C_CBUS_GPIO) [N/m/y/?] n
Synopsys DesignWare PCI (I2C_DESIGNWARE_PCI) [N/m/y/?] (NEW)
Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) I2C
(I2C_EG20T) [N/m/y/?] (NEW)
GPIO-based bitbanging I2C (I2C_GPIO) [N/m/y/?] n
Intel Moorestown/Medfield Platform I2C controller (I2C_INTEL_MID)
[N/m/y/?] (NEW)
OpenCores I2C Controller (I2C_OCORES) [N/m/y/?] n
PCA9564/PCA9665 as platform device (I2C_PCA_PLATFORM) [N/m/y/?] n
Simtec Generic I2C interface (I2C_SIMTEC) [N/m/y/?] n
Xilinx I2C Controller (I2C_XILINX) [N/m/y/?] n
*
* External I2C/SMBus adapter drivers
*
Diolan U2C-12 USB adapter (I2C_DIOLAN_U2C) [N/m/y/?] n
Parallel port adapter (light) (I2C_PARPORT_LIGHT) [N/m/y/?] n
TAOS evaluation module (I2C_TAOS_EVM) [N/m/y/?] n
Tiny-USB adapter (I2C_TINY_USB) [N/m/y/?] n
*
* Other I2C/SMBus bus drivers
*
*
* SPI support
*
SPI support (SPI) [Y/n/?] y
  Debug support for SPI drivers (SPI_DEBUG) [N/y/?] n
  *
  * SPI Master Controller Drivers
  *
  Altera SPI Controller (SPI_ALTERA) [N/m/y/?] n
  Utilities for Bitbanging SPI masters (SPI_BITBANG) [Y/n/m/?] y
  GPIO-based bitbanging SPI Master (SPI_GPIO) [N/m/y/?] n
  OpenCores tiny SPI (SPI_OC_TINY) [N/m/y/?] n
  PXA2xx SSP SPI master (SPI_PXA2XX) [N/m/y/?] (NEW)
  NXP SC18IS602/602B/603 I2C to SPI bridge (SPI_SC18IS602) [N/m/y/?] n
  Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) SPI
(SPI_TOPCLIFF_PCH) [N/m/y/?] (NEW)
  Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver (SPI_XCOMM) [N/m=
/y/?] n
  Xilinx SPI controller common module (SPI_XILINX) [N/m/y/?] n
  DesignWare SPI controller core support (SPI_DESIGNWARE) [N/m/y/?] n
  *
  * SPI Protocol Masters
  *
  User mode SPI device driver support (SPI_SPIDEV) [N/m/y/?] n
  Infineon TLE62X0 (for power switching) (SPI_TLE62X0) [N/m/y/?] n
*
* GPIO Support
*
GPIO Support (GPIOLIB) [Y/n/?] y
  Debug GPIO calls (DEBUG_GPIO) [N/y/?] n
  /sys/class/gpio/... (sysfs interface) (GPIO_SYSFS) [Y/n/?] y
  Dialog DA9052 GPIO (GPIO_DA9052) [N/m/y/?] n
  *
  * Memory mapped GPIO drivers:
  *
  Generic memory-mapped GPIO controller support (MMIO platform device)
(GPIO_GENERIC_PLATFORM) [N/m/y/?] n
  IT8761E GPIO support (GPIO_IT8761E) [N/m/y/?] (NEW)
  TS-5500 DIO blocks and compatibles (GPIO_TS5500) [N/m/y/?] n
  Intel SCH/TunnelCreek/Centerton GPIO (GPIO_SCH) [N/m/y/?] (NEW)
  Intel ICH GPIO (GPIO_ICH) [N/m/y/?] (NEW)
  VIA VX855/VX875 GPIO (GPIO_VX855) [N/m/y/?] (NEW)
  Intel Lynxpoint GPIO support (GPIO_LYNXPOINT) [N/y/?] (NEW)
  *
  * I2C GPIO expanders:
  *
  Maxim MAX7300 GPIO expander (GPIO_MAX7300) [N/m/y/?] n
  MAX7319, MAX7320-7327 I2C Port Expanders (GPIO_MAX732X) [N/m/y/?] n
  PCA953x, PCA955x, PCA957x, TCA64xx, and MAX7310 I/O ports
(GPIO_PCA953X) [N/m/y/?] n
  PCF857x, PCA{85,96}7x, and MAX732[89] I2C GPIO expanders
(GPIO_PCF857X) [N/m/y/?] n
  Semtech SX150x I2C GPIO expander (GPIO_SX150X) [N/y/?] n
  ADP5588 I2C GPIO expander (GPIO_ADP5588) [N/m/y/?] n
  *
  * PCI GPIO expanders:
  *
  BT8XX GPIO abuser (GPIO_BT8XX) [N/m/y/?] (NEW)
  AMD 8111 GPIO driver (GPIO_AMD8111) [N/m/y/?] (NEW)
  Intel Langwell/Penwell GPIO support (GPIO_LANGWELL) [N/y/?] (NEW)
  Intel EG20T PCH/LAPIS Semiconductor IOH(ML7223/ML7831) GPIO
(GPIO_PCH) [N/m/y/?] (NEW)
  OKI SEMICONDUCTOR ML7213 IOH GPIO support (GPIO_ML_IOH) [N/m/y/?] (NE=
W)
  RDC R-321x GPIO support (GPIO_RDC321X) [N/m/y/?] (NEW)
  *
  * SPI GPIO expanders:
  *
  Maxim MAX7301 GPIO expander (GPIO_MAX7301) [N/m/y/?] n
  Microchip MCP23xxx I/O expander (GPIO_MCP23S08) [N/m/y/?] n
  Freescale MC33880 high-side/low-side switch (GPIO_MC33880) [N/m/y/?] =
n
  74x164 serial-in/parallel-out 8-bits shift register (GPIO_74X164) [N/=
m/y/?] n
  *
  * AC97 GPIO expanders:
  *
  *
  * MODULbus GPIO expanders:
  *
  *
  * USB GPIO expanders:
  *
*
* Power supply class support
*
Power supply class support (POWER_SUPPLY) [Y/?] y
  Power supply debug (POWER_SUPPLY_DEBUG) [N/y/?] (NEW)
  Generic PDA/phone power driver (PDA_POWER) [N/m/y/?] (NEW)
  Test power driver (TEST_POWER) [N/m/y/?] (NEW)
  DS2780 battery driver (BATTERY_DS2780) [N/m/y/?] (NEW)
  DS2781 battery driver (BATTERY_DS2781) [N/m/y/?] (NEW)
  DS2782/DS2786 standalone gas-gauge (BATTERY_DS2782) [N/m/y/?] (NEW)
  SBS Compliant gas gauge (BATTERY_SBS) [N/m/y/?] (NEW)
  BQ27x00 battery driver (BATTERY_BQ27x00) [N/m/y/?] (NEW)
  Dialog DA9052 Battery (BATTERY_DA9052) [N/m/y/?] (NEW)
  Maxim MAX17040 Fuel Gauge (BATTERY_MAX17040) [N/m/y/?] (NEW)
  Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge (BATTERY_MAX17042)
[N/m/y/?] (NEW)
  MAX8903 Battery DC-DC Charger for USB and Adapter Power
(CHARGER_MAX8903) [N/m/y/?] (NEW)
  TI/National Semiconductor LP8727 charger driver (CHARGER_LP8727)
[N/m/y/?] (NEW)
  GPIO charger (CHARGER_GPIO) [N/m/y/?] (NEW)
  Battery charger manager for multiple chargers (CHARGER_MANAGER) [N/y/=
?] (NEW)
  TI BQ2415x battery charger driver (CHARGER_BQ2415X) [N/m/y/?] (NEW)
  Summit Microelectronics SMB347 Battery Charger (CHARGER_SMB347)
[N/m/y/?] (NEW)
  Goldfish battery driver (BATTERY_GOLDFISH) [N/m/y/?] (NEW)
  *
  * Board level reset or power off
  *
  Board level reset or power off (POWER_RESET) [N/y/?] (NEW)
*
* Generic Thermal sysfs driver
*
Generic Thermal sysfs driver (THERMAL) [Y/?] y
  Default Thermal governor
  > 1. step_wise (THERMAL_DEFAULT_GOV_STEP_WISE) (NEW)
    2. fair_share (THERMAL_DEFAULT_GOV_FAIR_SHARE) (NEW)
    3. user_space (THERMAL_DEFAULT_GOV_USER_SPACE) (NEW)
  choice[1-3?]:
  Fair-share thermal governor (THERMAL_GOV_FAIR_SHARE) [N/y/?] (NEW)
  Step_wise thermal governor (THERMAL_GOV_STEP_WISE) [Y/?] (NEW) y
  User_space thermal governor (THERMAL_GOV_USER_SPACE) [N/y/?] (NEW)
  Thermal emulation mode support (THERMAL_EMULATION) [N/y/?] (NEW)
  Intel PowerClamp idle injection driver (INTEL_POWERCLAMP) [N/m/y/?] (=
NEW)
  BCM2835 Thermal Driver (THERMAL_BCM2835) [N/m/y/?] (NEW)
*
* Watchdog Timer Support
*
Watchdog Timer Support (WATCHDOG) [Y/n/?] y
  WatchDog Timer Driver Core (WATCHDOG_CORE) [N/y/?] n
  Disable watchdog shutdown on close (WATCHDOG_NOWAYOUT) [N/y/?] n
  *
  * Watchdog Device Drivers
  *
  Software watchdog (SOFT_WATCHDOG) [N/m/y/?] n
  Dialog DA9052 Watchdog (DA9052_WATCHDOG) [N/m/y/?] n
  Acquire SBC Watchdog Timer (ACQUIRE_WDT) [N/m/y/?] (NEW)
  Advantech SBC Watchdog Timer (ADVANTECH_WDT) [N/m/y/?] (NEW)
  ALi M1535 PMU Watchdog Timer (ALIM1535_WDT) [N/m/y/?] (NEW)
  ALi M7101 PMU Computer Watchdog (ALIM7101_WDT) [N/m/y/?] (NEW)
  Fintek F71808E, F71862FG, F71869, F71882FG and F71889FG Watchdog
(F71808E_WDT) [N/m/y/?] (NEW)
  AMD/ATI SP5100 TCO Timer/Watchdog (SP5100_TCO) [N/m/y/?] (NEW)
  AMD Elan SC520 processor Watchdog (SC520_WDT) [N/m/y/?] (NEW)
  Compulab SBC-FITPC2 watchdog (SBC_FITPC2_WATCHDOG) [N/m/y/?] (NEW)
  Eurotech CPU-1220/1410 Watchdog Timer (EUROTECH_WDT) [N/m/y/?] (NEW)
  IB700 SBC Watchdog Timer (IB700_WDT) [N/m/y/?] (NEW)
  IBM Automatic Server Restart (IBMASR) [N/m/y/?] (NEW)
  ICP Single Board Computer Watchdog Timer (WAFER_WDT) [N/m/y/?] (NEW)
  Intel 6300ESB Timer/Watchdog (I6300ESB_WDT) [N/m/y/?] (NEW)
  Intel Atom E6xx Watchdog (IE6XX_WDT) [N/m/y/?] (NEW)
  Intel TCO Timer/Watchdog (ITCO_WDT) [N/m/y/?] (NEW)
  IT8712F (Smart Guardian) Watchdog Timer (IT8712F_WDT) [N/m/y/?] (NEW)
  IT87 Watchdog Timer (IT87_WDT) [N/m/y/?] (NEW)
  HP ProLiant iLO2+ Hardware Watchdog Timer (HP_WATCHDOG) [N/m/y/?] (NE=
W)
  National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog
(SC1200_WDT) [N/m/y/?] (NEW)
  NS PC87413 watchdog (PC87413_WDT) [N/m/y/?] (NEW)
  nVidia TCO Timer/Watchdog (NV_TCO) [N/m/y/?] (NEW)
  SBC-60XX Watchdog Timer (60XX_WDT) [N/m/y/?] (NEW)
  SBC8360 Watchdog Timer (SBC8360_WDT) [N/m/y/?] (NEW)
  SMA CPU5 Watchdog (CPU5_WDT) [N/m/y/?] (NEW)
  SMSC SCH311X Watchdog Timer (SMSC_SCH311X_WDT) [N/m/y/?] (NEW)
  Winbond SMsC37B787 Watchdog Timer (SMSC37B787_WDT) [N/m/y/?] (NEW)
  VIA Watchdog Timer (VIA_WDT) [N/m/y/?] (NEW)
  W83627HF/W83627DHG Watchdog Timer (W83627HF_WDT) [N/m/y/?] (NEW)
  W83697HF/W83697HG Watchdog Timer (W83697HF_WDT) [N/m/y/?] (NEW)
  W83697UG/W83697UF Watchdog Timer (W83697UG_WDT) [N/m/y/?] (NEW)
  W83877F (EMACS) Watchdog Timer (W83877F_WDT) [N/m/y/?] (NEW)
  W83977F (PCM-5335) Watchdog Timer (W83977F_WDT) [N/m/y/?] (NEW)
  ZF MachZ Watchdog (MACHZ_WDT) [N/m/y/?] (NEW)
  Winsystems SBC EPX-C3 watchdog (SBC_EPX_C3_WATCHDOG) [N/m/y/?] (NEW)
  *
  * PCI-based Watchdog Cards
  *
  Berkshire Products PCI-PC Watchdog (PCIPCWATCHDOG) [N/m/y/?] (NEW)
  PCI-WDT500/501 Watchdog timer (WDTPCI) [N/m/y/?] (NEW)
  *
  * USB-based Watchdog Cards
  *
  Berkshire Products USB-PC Watchdog (USBPCWATCHDOG) [N/m/y/?] n
*
* Multifunction device drivers
*
AMD CS5535 and CS5536 southbridge core functions (MFD_CS5535) [N/m/y/?]=
 (NEW)
AMS AS3711 (MFD_AS3711) [N/y/?] n
Analog Devices ADP5520/01 MFD PMIC Core Support (PMIC_ADP5520) [N/y/?] =
n
AnalogicTech AAT2870 (MFD_AAT2870_CORE) [N/y/?] n
ChromeOS Embedded Controller (MFD_CROS_EC) [N/m/y/?] n
Dialog Semiconductor DA9030/DA9034 PMIC Support (PMIC_DA903X) [N/y/?] n
Dialog Semiconductor DA9052/53 PMIC variants with SPI (MFD_DA9052_SPI) =
[N/y/?] n
Dialog Semiconductor DA9052/53 PMIC variants with I2C (MFD_DA9052_I2C) =
[Y/n/?] y
Dialog Semiconductor DA9055 PMIC Support (MFD_DA9055) [N/y/?] n
=46reescale MC13783 and MC13892 SPI interface (MFD_MC13XXX_SPI) [Y/n/m/=
?] y
=46reescale MC13892 I2C interface (MFD_MC13XXX_I2C) [Y/n/m/?] y
HTC PASIC3 LED/DS1WM chip support (HTC_PASIC3) [N/m/y/?] n
HTC I2C PLD chip support (HTC_I2CPLD) [N/y/?] n
Intel ICH LPC (LPC_ICH) [N/m/y/?] (NEW)
Intel SCH LPC (LPC_SCH) [N/m/y/?] (NEW)
Janz CMOD-IO PCI MODULbus Carrier Board (MFD_JANZ_CMODIO) [N/m/y/?] (NE=
W)
Marvell 88PM800 (MFD_88PM800) [N/m/y/?] n
Marvell 88PM805 (MFD_88PM805) [N/m/y/?] n
Marvell 88PM8606/88PM8607 (MFD_88PM860X) [N/y/?] n
Maxim Semiconductor MAX77686 PMIC Support (MFD_MAX77686) [N/y/?] n
Maxim Semiconductor MAX77693 PMIC Support (MFD_MAX77693) [N/y/?] n
Maxim Semiconductor MAX8907 PMIC Support (MFD_MAX8907) [N/m/y/?] n
Maxim Semiconductor MAX8925 PMIC Support (MFD_MAX8925) [N/y/?] n
Maxim Semiconductor MAX8997/8966 PMIC Support (MFD_MAX8997) [N/y/?] n
Maxim Semiconductor MAX8998/National LP3974 PMIC Support (MFD_MAX8998) =
[N/y/?] n
Motorola EZXPCAP Support (EZX_PCAP) [N/y/?] n
Nano River Technologies Viperboard (MFD_VIPERBOARD) [N/m/y/?] n
Nokia Retu and Tahvo multi-function device (MFD_RETU) [N/m/y/?] n
NXP PCF50633 (MFD_PCF50633) [N/m/y/?] n
RDC R-321x southbridge (MFD_RDC321X) [N/m/y/?] (NEW)
Realtek PCI-E card reader (MFD_RTSX_PCI) [N/m/y/?] (NEW)
Ricoh RC5T583 Power Management system device (MFD_RC5T583) [N/y/?] n
SAMSUNG Electronics PMIC Series Support (MFD_SEC_CORE) [N/y/?] n
Silicon Laboratories 4761/64/68 AM/FM radio. (MFD_SI476X_CORE) [N/m/y/?=
] n
Silicon Motion SM501 (MFD_SM501) [N/m/y/?] n
SMSC ECE1099 series chips (MFD_SMSC) [N/y/?] n
ST-Ericsson ABX500 Mixed Signal Circuit register functions
(ABX500_CORE) [N/y/?] n
STMicroelectronics STMPE (MFD_STMPE) [N/y/?] n
System Controller Register R/W Based on Regmap (MFD_SYSCON) [Y/n/?] y
TI ADC / Touch Screen chip support (MFD_TI_AM335X_TSCADC) [N/m/y/?] n
TI LP8788 Power Management Unit Driver (MFD_LP8788) [N/y/?] n
TI Palmas series chips (MFD_PALMAS) [N/y/?] n
TI TPS61050/61052 Boost Converters (TPS6105X) [N/m/y/?] n
TI TPS6501x Power Management chips (TPS65010) [N/m/y/?] n
TI TPS6507x Power Management / Touch Screen chips (TPS6507X) [N/m/y/?] =
n
TI TPS65090 Power Management chips (MFD_TPS65090) [N/y/?] n
TI TPS65217 Power Management / White LED chips (MFD_TPS65217) [N/m/y/?]=
 n
TI TPS6586x Power Management chips (MFD_TPS6586X) [N/y/?] n
TI TPS65910 Power Management chip (MFD_TPS65910) [N/y/?] n
TI TPS65912 Power Management chip (MFD_TPS65912) [N/y/?] n
TI TPS65912 Power Management chip with I2C (MFD_TPS65912_I2C) [N/y/?] n
TI TPS65912 Power Management chip with SPI (MFD_TPS65912_SPI) [N/y/?] n
TI TPS80031/TPS80032 Power Management chips (MFD_TPS80031) [N/y/?] n
TI TWL4030/TWL5030/TWL6030/TPS659x0 Support (TWL4030_CORE) [N/y/?] n
TI TWL6040 audio codec (TWL6040_CORE) [N/y/?] n
TI WL1273 FM radio (MFD_WL1273_CORE) [N/m/y/?] n
TI/National Semiconductor LM3533 Lighting Power chip (MFD_LM3533) [N/m/=
y/?] n
Timberdale FPGA (MFD_TIMBERDALE) [N/m/y/?] (NEW)
Toshiba TC35892 and variants (MFD_TC3589X) [N/y/?] n
VIA VX855/VX875 integrated south bridge (MFD_VX855) [N/m/y/?] (NEW)
Wolfson Microelectronics Arizona platform with I2C (MFD_ARIZONA_I2C) [N=
/m/y/?] n
Wolfson Microelectronics Arizona platform with SPI (MFD_ARIZONA_SPI) [N=
/m/y/?] n
Wolfson Microelectronics WM8400 (MFD_WM8400) [N/y/?] n
Wolfson Microelectronics WM831x/2x PMICs with I2C (MFD_WM831X_I2C) [N/y=
/?] n
Wolfson Microelectronics WM831x/2x PMICs with SPI (MFD_WM831X_SPI) [N/y=
/?] n
Wolfson Microelectronics WM8350 with I2C (MFD_WM8350_I2C) [N/y/?] n
Wolfson Microelectronics WM8994 (MFD_WM8994) [N/y/?] n
*
* Media PCI Adapters
*
Media PCI Adapters (MEDIA_PCI_SUPPORT) [N/y/?] (NEW)
*
* V4L platform devices
*
V4L platform devices (V4L_PLATFORM_DRIVERS) [Y/n/?] y
  Marvell 88ALP01 (Cafe) CMOS Camera Controller support
(VIDEO_CAFE_CCIC) [N/m/y/?] (NEW)
  Support for timberdale Video In/LogiWIN (VIDEO_TIMBERDALE) [N/m/y/?] =
n
  SoC camera support (SOC_CAMERA) [Y/n/m/?] y
    platform camera support (SOC_CAMERA_PLATFORM) [N/m/y/?] n
*
* /dev/agpgart (AGP Support)
*
/dev/agpgart (AGP Support) (AGP) [N/m/y/?] (NEW)
*
* Graphics support
*
VGA Arbitration (VGA_ARB) [Y/n/?] (NEW)
  Maximum number of GPUs (VGA_ARB_MAX_GPUS) [16] (NEW)
Laptop Hybrid Graphics - GPU switching support (VGA_SWITCHEROO) [N/y/?]=
 (NEW)
3dfx Banshee/Voodoo3+ (DRM_TDFX) [N/m/y/?] (NEW)
ATI Rage 128 (DRM_R128) [N/m/y/?] (NEW)
ATI Radeon (DRM_RADEON) [N/m/y/?] (NEW)
Nouveau (nVidia) cards (DRM_NOUVEAU) [N/m/y/?] (NEW)
Matrox g200/g400 (DRM_MGA) [N/m/y/?] (NEW)
Via unichrome video cards (DRM_VIA) [N/m/y/?] (NEW)
Savage video cards (DRM_SAVAGE) [N/m/y/?] (NEW)
DRM driver for VMware Virtual GPU (DRM_VMWGFX) [N/m/y/?] (NEW)
Intel GMA5/600 KMS Framebuffer (DRM_GMA500) [N/m/y/?] (NEW)
DisplayLink (DRM_UDL) [N/m/y/?] n
AST server chips (DRM_AST) [N/m/y/?] (NEW)
Kernel modesetting driver for MGA G200 server engines (DRM_MGAG200)
[N/m/y/?] (NEW)
Cirrus driver for QEMU emulated device (DRM_CIRRUS_QEMU) [N/m/y/?] (NEW=
)
QXL virtual GPU (DRM_QXL) [N/m/y/?] (NEW)
Lowlevel video output switch controls (VIDEO_OUTPUT_CONTROL) [N/m/y/?] =
n
*
* Support for frame buffer devices
*
Support for frame buffer devices (FB) [Y/n/m/?] y
  Enable firmware EDID (FIRMWARE_EDID) [N/y/?] n
  Enable Video Mode Handling Helpers (FB_MODE_HELPERS) [N/y/?] n
  Enable Tile Blitting Support (FB_TILEBLITTING) [N/y/?] n
  *
  * Frame buffer hardware drivers
  *
  Cirrus Logic support (FB_CIRRUS) [N/m/y/?] (NEW)
  Permedia2 support (FB_PM2) [N/m/y/?] (NEW)
  CyberPro 2000/2010/5000 support (FB_CYBER2000) [N/m/y/?] (NEW)
  Arc Monochrome LCD board support (FB_ARC) [N/m/y/?] (NEW)
  Asiliant (Chips) 69000 display support (FB_ASILIANT) [N/y/?] (NEW)
  IMS Twin Turbo display support (FB_IMSTT) [N/y/?] (NEW)
  VGA 16-color graphics support (FB_VGA16) [N/m/y/?] (NEW)
  Userspace VESA VGA graphics support (FB_UVESA) [N/m/y/?] n
  VESA VGA graphics support (FB_VESA) [N/y/?] (NEW)
  N411 Apollo/Hecuba devkit support (FB_N411) [N/m/y/?] (NEW)
  Hercules mono graphics support (FB_HGA) [N/m/y/?] (NEW)
  Epson S1D13XXX framebuffer support (FB_S1D13XXX) [N/m/y/?] n
  nVidia Framebuffer Support (FB_NVIDIA) [N/m/y/?] (NEW)
  nVidia Riva support (FB_RIVA) [N/m/y/?] (NEW)
  Intel740 support (FB_I740) [N/m/y/?] (NEW)
  Intel LE80578 (Vermilion) support (FB_LE80578) [N/m/y/?] (NEW)
  Matrox acceleration (FB_MATROX) [N/m/y/?] (NEW)
  ATI Radeon display support (FB_RADEON) [N/m/y/?] (NEW)
  ATI Rage128 display support (FB_ATY128) [N/m/y/?] (NEW)
  ATI Mach64 display support (FB_ATY) [N/m/y/?] (NEW)
  S3 Trio/Virge support (FB_S3) [N/m/y/?] (NEW)
  S3 Savage support (FB_SAVAGE) [N/m/y/?] (NEW)
  SiS/XGI display support (FB_SIS) [N/m/y/?] (NEW)
  VIA UniChrome (Pro) and Chrome9 display support (FB_VIA) [N/m/y/?] (N=
EW)
  NeoMagic display support (FB_NEOMAGIC) [N/m/y/?] (NEW)
  IMG Kyro support (FB_KYRO) [N/m/y/?] (NEW)
  3Dfx Banshee/Voodoo3/Voodoo5 display support (FB_3DFX) [N/m/y/?] (NEW=
)
  3Dfx Voodoo Graphics (sst1) support (FB_VOODOO1) [N/m/y/?] (NEW)
  VIA VT8623 support (FB_VT8623) [N/m/y/?] (NEW)
  Trident/CyberXXX/CyberBlade support (FB_TRIDENT) [N/m/y/?] (NEW)
  ARK 2000PV support (FB_ARK) [N/m/y/?] (NEW)
  Permedia3 support (FB_PM3) [N/m/y/?] (NEW)
  Fujitsu carmine frame buffer support (FB_CARMINE) [N/m/y/?] (NEW)
  AMD Geode family framebuffer support (FB_GEODE) [N/y/?] (NEW)
  Toshiba Mobile IO FrameBuffer support (FB_TMIO) [N/m/y/?] n
  SMSC UFX6000/7000 USB Framebuffer support (FB_SMSCUFX) [N/m/y/?] n
  Displaylink USB Framebuffer support (FB_UDL) [N/m/y/?] n
  Goldfish Framebuffer (FB_GOLDFISH) [N/m/y/?] n
  Virtual Frame Buffer support (ONLY FOR TESTING!) (FB_VIRTUAL) [N/m/y/=
?] n
  E-Ink Metronome/8track controller support (FB_METRONOME) [N/m/y/?] n
  Fujitsu MB862xx GDC support (FB_MB862XX) [N/m/y/?] (NEW)
  E-Ink Broadsheet/Epson S1D13521 controller support (FB_BROADSHEET) [N=
/m/y/?] n
  AUO-K190X EPD controller support (FB_AUO_K190X) [N/m/y/?] n
*
* Backlight & LCD device support
*
Backlight & LCD device support (BACKLIGHT_LCD_SUPPORT) [Y/n/?] y
  Lowlevel LCD controls (LCD_CLASS_DEVICE) [Y/n/m/?] y
    Epson L4F00242T03 LCD (LCD_L4F00242T03) [Y/n/m/?] y
    Samsung LMS283GF05 LCD (LCD_LMS283GF05) [N/m/y/?] n
    Samsung LTV350QV LCD Panel (LCD_LTV350QV) [N/m/y/?] n
    ILI Technology ILI9221/ILI9222 support (LCD_ILI922X) [N/m/y/?] n
    ILI Technology ILI9320 controller support (LCD_ILI9320) [N/m/y/?] n
    Toppoly TDO24M  and TDO35S LCD Panels support (LCD_TDO24M) [N/m/y/?=
] n
    VGG2432A4 LCM device support (LCD_VGG2432A4) [N/m/y/?] n
    Platform LCD controls (LCD_PLATFORM) [Y/n/m/?] y
    S6E63M0 AMOLED LCD Driver (LCD_S6E63M0) [N/m/y/?] n
    LD9040 AMOLED LCD Driver (LCD_LD9040) [N/m/y/?] n
    AMS369FG06 AMOLED LCD Driver (LCD_AMS369FG06) [N/m/y/?] n
    LMS501KF03 LCD Driver (LCD_LMS501KF03) [N/m/y/?] n
    Himax HX-8357 LCD Driver (LCD_HX8357) [N/m/y/?] n
  Lowlevel Backlight controls (BACKLIGHT_CLASS_DEVICE) [Y/n/m/?] y
    Generic (aka Sharp Corgi) Backlight Driver (BACKLIGHT_GENERIC) [Y/n=
/m/?] y
    Generic PWM based Backlight Driver (BACKLIGHT_PWM) [Y/n/m/?] y
    Dialog DA9052/DA9053 WLED (BACKLIGHT_DA9052) [N/m/y/?] n
    Apple Backlight Driver (BACKLIGHT_APPLE) [N/m/y/?] (NEW)
    Tabletkiosk Sahara Touch-iT Backlight Driver (BACKLIGHT_SAHARA)
[N/m/y/?] (NEW)
    Backlight Driver for ADP8860/ADP8861/ADP8863 using WLED
(BACKLIGHT_ADP8860) [N/m/y/?] n
    Backlight Driver for ADP8870 using WLED (BACKLIGHT_ADP8870) [N/m/y/=
?] n
    Backlight Driver for LM3630 (BACKLIGHT_LM3630) [N/m/y/?] n
    Backlight Driver for LM3639 (BACKLIGHT_LM3639) [N/m/y/?] n
    Backlight driver for TI LP855X (BACKLIGHT_LP855X) [N/m/y/?] n
*
* Console display driver support
*
VGA text console (VGA_CONSOLE) [Y/n/?] (NEW)
  Enable Scrollback Buffer in System RAM (VGACON_SOFT_SCROLLBACK) [N/y/=
?] (NEW)
=46ramebuffer Console support (FRAMEBUFFER_CONSOLE) [Y/n/m/?] y
  Map the console to the primary display device
(FRAMEBUFFER_CONSOLE_DETECT_PRIMARY) [Y/n/?] y
  Framebuffer Console Rotation (FRAMEBUFFER_CONSOLE_ROTATION) [N/y/?] n
Select compiled-in fonts (FONTS) [Y/n/?] y
  VGA 8x8 font (FONT_8x8) [Y/n/?] y
  VGA 8x16 font (FONT_8x16) [Y/n/?] y
  Mac console 6x11 font (not supported by all drivers) (FONT_6x11) [N/y=
/?] n
  console 7x14 font (not supported by all drivers) (FONT_7x14) [N/y/?] =
n
  Pearl (old m68k) console 8x8 font (FONT_PEARL_8x8) [N/y/?] n
  Acorn console 8x8 font (FONT_ACORN_8x8) [N/y/?] n
  Mini 4x6 font (FONT_MINI_4x6) [N/y] n
Sparc console 8x16 font (FONT_SUN8x16) [N/y/?] n
Sparc console 12x22 font (not supported by all drivers)
(FONT_SUN12x22) [N/y/?] n
console 10x18 font (not supported by all drivers) (FONT_10x18) [N/y/?] =
n
*
* Generic sound devices
*
Generic sound devices (SND_DRIVERS) [Y/n/?] y
  PC-Speaker support (READ HELP!) (SND_PCSP) [N/m/y/?] (NEW)
  Dummy (/dev/null) soundcard (SND_DUMMY) [N/m/y/?] n
  Generic loopback driver (PCM) (SND_ALOOP) [N/m/y/?] n
  MOTU MidiTimePiece AV multiport MIDI (SND_MTPAV) [N/m/y/?] n
  UART16550 serial MIDI driver (SND_SERIAL_U16550) [N/m/y/?] n
  Generic MPU-401 UART driver (SND_MPU401) [N/m/y/?] n
*
* PCI sound devices
*
PCI sound devices (SND_PCI) [Y/n/?] (NEW)
  Analog Devices AD1889 (SND_AD1889) [N/m/y/?] (NEW)
  Avance Logic ALS300/ALS300+ (SND_ALS300) [N/m/y/?] (NEW)
  Avance Logic ALS4000 (SND_ALS4000) [N/m/y/?] (NEW)
  ALi M5451 PCI Audio Controller (SND_ALI5451) [N/m/y/?] (NEW)
  AudioScience ASIxxxx (SND_ASIHPI) [N/m/y/?] (NEW)
  ATI IXP AC97 Controller (SND_ATIIXP) [N/m/y/?] (NEW)
  ATI IXP Modem (SND_ATIIXP_MODEM) [N/m/y/?] (NEW)
  Aureal Advantage (SND_AU8810) [N/m/y/?] (NEW)
  Aureal Vortex (SND_AU8820) [N/m/y/?] (NEW)
  Aureal Vortex 2 (SND_AU8830) [N/m/y/?] (NEW)
  Emagic Audiowerk 2 (SND_AW2) [N/m/y/?] (NEW)
  Aztech AZF3328 / PCI168 (SND_AZT3328) [N/m/y/?] (NEW)
  Bt87x Audio Capture (SND_BT87X) [N/m/y/?] (NEW)
  SB Audigy LS / Live 24bit (SND_CA0106) [N/m/y/?] (NEW)
  C-Media 8338, 8738, 8768, 8770 (SND_CMIPCI) [N/m/y/?] (NEW)
  C-Media 8786, 8787, 8788 (Oxygen) (SND_OXYGEN) [N/m/y/?] (NEW)
  Cirrus Logic (Sound Fusion) CS4281 (SND_CS4281) [N/m/y/?] (NEW)
  Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x (SND_CS46XX)
[N/m/y/?] (NEW)
  CS5530 Audio (SND_CS5530) [N/m/y/?] (NEW)
  CS5535/CS5536 Audio (SND_CS5535AUDIO) [N/m/y/?] (NEW)
  Creative Sound Blaster X-Fi (SND_CTXFI) [N/m/y/?] (NEW)
  (Echoaudio) Darla20 (SND_DARLA20) [N/m/y/?] (NEW)
  (Echoaudio) Gina20 (SND_GINA20) [N/m/y/?] (NEW)
  (Echoaudio) Layla20 (SND_LAYLA20) [N/m/y/?] (NEW)
  (Echoaudio) Darla24 (SND_DARLA24) [N/m/y/?] (NEW)
  (Echoaudio) Gina24 (SND_GINA24) [N/m/y/?] (NEW)
  (Echoaudio) Layla24 (SND_LAYLA24) [N/m/y/?] (NEW)
  (Echoaudio) Mona (SND_MONA) [N/m/y/?] (NEW)
  (Echoaudio) Mia (SND_MIA) [N/m/y/?] (NEW)
  (Echoaudio) 3G cards (SND_ECHO3G) [N/m/y/?] (NEW)
  (Echoaudio) Indigo (SND_INDIGO) [N/m/y/?] (NEW)
  (Echoaudio) Indigo IO (SND_INDIGOIO) [N/m/y/?] (NEW)
  (Echoaudio) Indigo DJ (SND_INDIGODJ) [N/m/y/?] (NEW)
  (Echoaudio) Indigo IOx (SND_INDIGOIOX) [N/m/y/?] (NEW)
  (Echoaudio) Indigo DJx (SND_INDIGODJX) [N/m/y/?] (NEW)
  Emu10k1 (SB Live!, Audigy, E-mu APS) (SND_EMU10K1) [N/m/y/?] (NEW)
  Emu10k1X (Dell OEM Version) (SND_EMU10K1X) [N/m/y/?] (NEW)
  (Creative) Ensoniq AudioPCI 1370 (SND_ENS1370) [N/m/y/?] (NEW)
  (Creative) Ensoniq AudioPCI 1371/1373 (SND_ENS1371) [N/m/y/?] (NEW)
  ESS ES1938/1946/1969 (Solo-1) (SND_ES1938) [N/m/y/?] (NEW)
  ESS ES1968/1978 (Maestro-1/2/2E) (SND_ES1968) [N/m/y/?] (NEW)
  ForteMedia FM801 (SND_FM801) [N/m/y/?] (NEW)
  *
  * Intel HD Audio
  *
  Intel HD Audio (SND_HDA_INTEL) [N/m/y/?] (NEW)
  RME Hammerfall DSP Audio (SND_HDSP) [N/m/y/?] (NEW)
  RME Hammerfall DSP MADI/RayDAT/AIO (SND_HDSPM) [N/m/y/?] (NEW)
  ICEnsemble ICE1712 (Envy24) (SND_ICE1712) [N/m/y/?] (NEW)
  ICE/VT1724/1720 (Envy24HT/PT) (SND_ICE1724) [N/m/y/?] (NEW)
  Intel/SiS/nVidia/AMD/ALi AC97 Controller (SND_INTEL8X0) [N/m/y/?] (NE=
W)
  Intel/SiS/nVidia/AMD MC97 Modem (SND_INTEL8X0M) [N/m/y/?] (NEW)
  Korg 1212 IO (SND_KORG1212) [N/m/y/?] (NEW)
  Digigram Lola (SND_LOLA) [N/m/y/?] (NEW)
  Digigram LX6464ES (SND_LX6464ES) [N/m/y/?] (NEW)
  ESS Allegro/Maestro3 (SND_MAESTRO3) [N/m/y/?] (NEW)
  Digigram miXart (SND_MIXART) [N/m/y/?] (NEW)
  NeoMagic NM256AV/ZX (SND_NM256) [N/m/y/?] (NEW)
  Digigram PCXHR (SND_PCXHR) [N/m/y/?] (NEW)
  Conexant Riptide (SND_RIPTIDE) [N/m/y/?] (NEW)
  RME Digi32, 32/8, 32 PRO (SND_RME32) [N/m/y/?] (NEW)
  RME Digi96, 96/8, 96/8 PRO (SND_RME96) [N/m/y/?] (NEW)
  RME Digi9652 (Hammerfall) (SND_RME9652) [N/m/y/?] (NEW)
  S3 SonicVibes (SND_SONICVIBES) [N/m/y/?] (NEW)
  Trident 4D-Wave DX/NX; SiS 7018 (SND_TRIDENT) [N/m/y/?] (NEW)
  VIA 82C686A/B, 8233/8235 AC97 Controller (SND_VIA82XX) [N/m/y/?] (NEW=
)
  VIA 82C686A/B, 8233 based Modems (SND_VIA82XX_MODEM) [N/m/y/?] (NEW)
  Asus Virtuoso 66/100/200 (Xonar) (SND_VIRTUOSO) [N/m/y/?] (NEW)
  Digigram VX222 (SND_VX222) [N/m/y/?] (NEW)
  Yamaha YMF724/740/744/754 (SND_YMFPCI) [N/m/y/?] (NEW)
*
* USB sound devices
*
USB sound devices (SND_USB) [Y/n/?] y
  USB Audio/MIDI driver (SND_USB_AUDIO) [N/m/y/?] n
  Edirol UA-101/UA-1000 driver (SND_USB_UA101) [N/m/y/?] n
  Tascam US-122, US-224 and US-428 USB driver (SND_USB_USX2Y) [N/m/y/?]=
 (NEW)
  Native Instruments USB audio devices (SND_USB_CAIAQ) [N/m/y/?] n
  Tascam US-122L USB driver (SND_USB_US122L) [N/m/y/?] (NEW)
  TerraTec DMX 6Fire USB (SND_USB_6FIRE) [N/m/y/?] n
*
* HID support
*
HID bus support (HID) [Y/?] y
  Battery level reporting for HID devices (HID_BATTERY_STRENGTH) [N/y/?=
] (NEW)
  /dev/hidraw raw HID device support (HIDRAW) [N/y/?] n
  User-space I/O driver support for HID subsystem (UHID) [N/m/y/?] n
  Generic HID driver (HID_GENERIC) [Y/n/m/?] y
*
* USB support
*
USB support (USB_SUPPORT) [Y/n/?] y
  Support for Host-side USB (USB) [Y/n/m/?] y
    USB verbose debug messages (USB_DEBUG) [N/y/?] n
    USB announce new devices (USB_ANNOUNCE_NEW_DEVICES) [N/y/?] n
    *
    * Miscellaneous USB options
    *
    Enable USB persist by default (USB_DEFAULT_PERSIST) [Y/n/?] y
    Dynamic USB minor allocation (USB_DYNAMIC_MINORS) [N/y/?] n
    OTG support (USB_OTG) [N/y/?] n
    Rely on OTG Targeted Peripherals List (USB_OTG_WHITELIST) [N/y/?] n
    Disable external hubs (USB_OTG_BLACKLIST_HUB) [N/y/?] n
    USB Monitor (USB_MON) [N/m/y/?] n
    Support WUSB Cable Based Association (CBA) (USB_WUSB_CBAF) [N/m/y/?=
] n
    *
    * USB Host Controller Drivers
    *
    Cypress C67x00 HCD support (USB_C67X00_HCD) [N/m/y/?] n
    xHCI HCD (USB 3.0) support (USB_XHCI_HCD) [N/m/y/?] (NEW)
    EHCI HCD (USB 2.0) support (USB_EHCI_HCD) [Y/n/m/?] y
    Root Hub Transaction Translators (USB_EHCI_ROOT_HUB_TT) [Y/?] y
    Improved Transaction Translator scheduling (USB_EHCI_TT_NEWSCHED) [=
Y/n/?] y
    Generic EHCI driver for a platform device (USB_EHCI_HCD_PLATFORM)
[N/m/y/?] n
    OXU210HP HCD support (USB_OXU210HP_HCD) [N/m/y/?] n
    ISP116X HCD support (USB_ISP116X_HCD) [N/m/y/?] n
    ISP 1760 HCD support (USB_ISP1760_HCD) [N/m/y/?] n
    ISP1362 HCD support (USB_ISP1362_HCD) [N/m/y/?] n
    OHCI HCD support (USB_OHCI_HCD) [N/m/y/?] (NEW)
    UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/y/?] (NEW=
)
    SL811HS HCD support (USB_SL811_HCD) [N/m/y/?] n
    R8A66597 HCD support (USB_R8A66597_HCD) [N/m/y/?] n
    Synopsis DWC host support (USB_DWCOTG) [N/m/y/?] n
    Inventra Highspeed Dual Role Controller (TI, ADI, ...)
(USB_MUSB_HDRC) [N/m/y/?] n
    Renesas USBHS controller (USB_RENESAS_USBHS) [N/m/y/?] n
    *
    * USB Device Class drivers
    *
    USB Modem (CDC ACM) support (USB_ACM) [N/m/y/?] n
    USB Printer support (USB_PRINTER) [N/m/y/?] n
    USB Wireless Device Management support (USB_WDM) [N/m/y/?] n
    USB Test and Measurement Class support (USB_TMC) [N/m/y/?] n
    *
    * NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
    *
    *
    * also be needed; see USB_STORAGE Help for more info
    *
    USB Mass Storage support (USB_STORAGE) [Y/n/m/?] y
      USB Mass Storage verbose debug (USB_STORAGE_DEBUG) [N/y/?] n
      Realtek Card Reader support (USB_STORAGE_REALTEK) [N/m/y/?] n
      Datafab Compact Flash Reader support (USB_STORAGE_DATAFAB) [N/m/y=
/?] n
      Freecom USB/ATAPI Bridge support (USB_STORAGE_FREECOM) [N/m/y/?] =
n
      ISD-200 USB/ATA Bridge support (USB_STORAGE_ISD200) [N/m/y/?] n
      USBAT/USBAT02-based storage support (USB_STORAGE_USBAT) [N/m/y/?]=
 n
      SanDisk SDDR-09 (and other SmartMedia, including DPCM) support
(USB_STORAGE_SDDR09) [N/m/y/?] n
      SanDisk SDDR-55 SmartMedia support (USB_STORAGE_SDDR55) [N/m/y/?]=
 n
      Lexar Jumpshot Compact Flash Reader (USB_STORAGE_JUMPSHOT) [N/m/y=
/?] n
      Olympus MAUSB-10/Fuji DPC-R1 support (USB_STORAGE_ALAUDA) [N/m/y/=
?] n
      Support OneTouch Button on Maxtor Hard Drives
(USB_STORAGE_ONETOUCH) [N/m/y/?] n
      Support for Rio Karma music player (USB_STORAGE_KARMA) [N/m/y/?] =
n
      SAT emulation on Cypress USB/ATA Bridge with ATACB
(USB_STORAGE_CYPRESS_ATACB) [N/m/y/?] n
      USB ENE card reader support (USB_STORAGE_ENE_UB6250) [N/m/y/?] n
    *
    * USB Imaging devices
    *
    USB Mustek MDC800 Digital Camera support (USB_MDC800) [N/m/y/?] n
    Microtek X6USB scanner support (USB_MICROTEK) [N/m/y/?] n
  DesignWare USB3 DRD Core Support (USB_DWC3) [N/m/y/?] n
  ChipIdea Highspeed Dual Role Controller (USB_CHIPIDEA) [Y/n/m/?] y
    ChipIdea device controller (USB_CHIPIDEA_UDC) [Y/n/?] y
    ChipIdea host controller (USB_CHIPIDEA_HOST) [Y/n/?] y
    ChipIdea driver debug (USB_CHIPIDEA_DEBUG) [N/y/?] n
  *
  * USB port drivers
  *
  *
  * USB Miscellaneous drivers
  *
  EMI 6|2m USB Audio interface support (USB_EMI62) [N/m/y/?] n
  EMI 2|6 USB Audio interface support (USB_EMI26) [N/m/y/?] n
  ADU devices from Ontrak Control Systems (USB_ADUTUX) [N/m/y/?] n
  USB 7-Segment LED Display (USB_SEVSEG) [N/m/y/?] n
  USB Diamond Rio500 support (USB_RIO500) [N/m/y/?] n
  USB Lego Infrared Tower support (USB_LEGOTOWER) [N/m/y/?] n
  USB LCD driver support (USB_LCD) [N/m/y/?] n
  USB LED driver support (USB_LED) [N/m/y/?] n
  Cypress CY7C63xxx USB driver support (USB_CYPRESS_CY7C63) [N/m/y/?] n
  Cypress USB thermometer driver support (USB_CYTHERM) [N/m/y/?] n
  Siemens ID USB Mouse Fingerprint sensor support (USB_IDMOUSE) [N/m/y/=
?] n
  Elan PCMCIA CardBus Adapter USB Client (USB_FTDI_ELAN) [N/m/y/?] n
  Apple Cinema Display support (USB_APPLEDISPLAY) [N/m/y/?] n
  USB 2.0 SVGA dongle support (Net2280/SiS315) (USB_SISUSBVGA) [N/m/y/?=
] n
  USB LD driver (USB_LD) [N/m/y/?] n
  PlayStation 2 Trance Vibrator driver support (USB_TRANCEVIBRATOR) [N/=
m/y/?] n
  IO Warrior driver support (USB_IOWARRIOR) [N/m/y/?] n
  USB testing driver (USB_TEST) [N/m/y/?] n
  iSight firmware loading support (USB_ISIGHTFW) [N/m/y/?] n
  USB YUREX driver support (USB_YUREX) [N/m/y/?] n
  Functions for loading firmware on EZUSB chips (USB_EZUSB_FX2) [N/m/y/=
?] n
  USB3503 HSIC to USB20 Driver (USB_HSIC_USB3503) [N/m/y/?] n
  *
  * USB Peripheral Controller
  *
  Renesas R8A66597 USB Peripheral Controller (USB_R8A66597) [N/m/y/?] n
  PXA 27x (USB_PXA27X) [N/m/y/?] n
  Marvell USB2.0 Device Controller (USB_MV_UDC) [N/m/y/?] n
  MARVELL PXA2128 USB 3.0 controller (USB_MV_U3D) [N/m/y/?] n
  Renesas M66592 USB Peripheral Controller (USB_M66592) [N/m/y/?] n
  AMD5536 UDC (USB_AMD5536UDC) [N/m/y/?] (NEW)
  PLX NET2272 (USB_NET2272) [N/m/y/?] n
  NetChip 228x (USB_NET2280) [N/m/y/?] (NEW)
  Toshiba TC86C001 'Goku-S' (USB_GOKU) [N/m/y/?] (NEW)
  Intel EG20T PCH/LAPIS Semiconductor IOH(ML7213/ML7831) UDC
(USB_EG20T) [N/m/y/?] (NEW)
  Dummy HCD (DEVELOPMENT) (USB_DUMMY_HCD) [N/m/y/?] n
*
* Ultra Wideband devices
*
Ultra Wideband devices (UWB) [N/m/y/?] (NEW)
*
* MMC/SD/SDIO card support
*
MMC/SD/SDIO card support (MMC) [Y/n/m/?] y
  MMC debugging (MMC_DEBUG) [N/y/?] n
  Assume MMC/SD cards are non-removable (DANGEROUS)
(MMC_UNSAFE_RESUME) [N/y/?] n
  MMC host clock gating (MMC_CLKGATE) [N/y/?] n
  *
  * MMC/SD/SDIO Card Drivers
  *
  MMC block device driver (MMC_BLOCK) [Y/n/m/?] y
    Number of minors per block device (MMC_BLOCK_MINORS) [8] 8
    Use bounce buffer for simple hosts (MMC_BLOCK_BOUNCE) [Y/n/?] y
  SDIO UART/GPS class support (SDIO_UART) [N/m/y/?] n
  MMC host test driver (MMC_TEST) [N/m/y/?] n
  *
  * MMC/SD/SDIO Host Controller Drivers
  *
  Secure Digital Host Controller Interface support (MMC_SDHCI) [Y/n/m/?=
] y
  SDHCI support on PCI bus (MMC_SDHCI_PCI) [N/m/y/?] (NEW)
  SDHCI support for ACPI enumerated SDHCI controllers (MMC_SDHCI_ACPI)
[N/m/y/?] (NEW)
  SDHCI platform and OF driver helper (MMC_SDHCI_PLTFM) [Y/n/m/?] y
  Winbond W83L51xD SD/MMC Card Interface support (MMC_WBSD) [N/m/y/?] (=
NEW)
  TI Flash Media MMC/SD Interface support (MMC_TIFM_SD) [N/m/y/?] (NEW)
  MMC/SD/SDIO over SPI (MMC_SPI) [N/m/y/?] n
  ENE CB710 MMC/SD Interface support (MMC_CB710) [N/m/y/?] (NEW)
  VIA SD/MMC Card Reader Driver (MMC_VIA_SDMMC) [N/m/y/?] (NEW)
  VUB300 USB to SDIO/SD/MMC Host Controller support (MMC_VUB300) [N/m/y=
/?] n
  USB SD Host Controller (USHC) support (MMC_USHC) [N/m/y/?] n
*
* LED Support
*
LED Support (NEW_LEDS) [Y/n/?] y
  LED Class Support (LEDS_CLASS) [Y/n/m/?] y
  *
  * LED drivers
  *
  LCD Backlight driver for LM3530 (LEDS_LM3530) [N/m/y/?] n
  LED support for LM3642 Chip (LEDS_LM3642) [N/m/y/?] n
  LED driver for PCA9532 dimmer (LEDS_PCA9532) [N/m/y/?] n
  LED Support for GPIO connected LEDs (LEDS_GPIO) [Y/n/m/?] y
  LED Support for N.S. LP3944 (Fun Light) I2C chip (LEDS_LP3944) [N/m/y=
/?] n
  LED Support for N.S. LP5521 LED driver chip (LEDS_LP5521) [N/m/y/?] n
  LED Support for TI/National LP5523/55231 LED driver chip
(LEDS_LP5523) [N/m/y/?] n
  LED Support for TI LP5562 LED driver chip (LEDS_LP5562) [N/m/y/?] n
  Mail LED on Clevo notebook (LEDS_CLEVO_MAIL) [N/m/y/?] (NEW)
  LED Support for PCA955x I2C chips (LEDS_PCA955X) [N/m/y/?] n
  LED support for PCA9633 I2C chip (LEDS_PCA9633) [N/m/y/?] n
  Dialog DA9052/DA9053 LEDS (LEDS_DA9052) [N/m/y/?] n
  LED Support for DAC124S085 SPI DAC (LEDS_DAC124S085) [N/m/y/?] n
  PWM driven LED Support (LEDS_PWM) [N/m/y/?] n
  REGULATOR driven LED support (LEDS_REGULATOR) [N/m/y/?] n
  LED driver for BD2802 RGB LED (LEDS_BD2802) [N/m/y/?] n
  LED driver for Intel NAS SS4200 series (LEDS_INTEL_SS4200) [N/m/y/?] =
(NEW)
  LED driver for LT3593 controllers (LEDS_LT3593) [N/m/y/?] n
  LED Support for MC13783 PMIC (LEDS_MC13783) [N/m/y/?] n
  LED Support for TCA6507 I2C chip (LEDS_TCA6507) [N/m/y/?] n
  LED support for LM355x Chips, LM3554 and LM3556 (LEDS_LM355x) [N/m/y/=
?] n
  LED support for the Bachmann OT200 (LEDS_OT200) [N/m/y/?] n
  LED support for the BlinkM I2C RGB LED (LEDS_BLINKM) [N/m/y/?] n
  *
  * LED Triggers
  *
*
* InfiniBand support
*
InfiniBand support (INFINIBAND) [N/m/y/?] (NEW)
*
* DMA Engine support
*
DMA Engine support (DMADEVICES) [Y/n/?] y
  DMA Engine debugging (DMADEVICES_DEBUG) [N/y/?] n
  *
  * DMA Devices
  *
  Intel MID DMA support for Peripheral DMA controllers
(INTEL_MID_DMAC) [N/m/y/?] (NEW)
  Intel I/OAT DMA support (INTEL_IOATDMA) [N/m/y/?] (NEW)
  Synopsys DesignWare AHB DMA support (DW_DMAC) [N/m/y/?] n
  Timberdale FPGA DMA support (TIMB_DMA) [N/m/y/?] n
  Intel EG20T PCH / LAPIS Semicon IOH(ML7213/ML7223/ML7831) DMA
(PCH_DMA) [N/m/y/?] (NEW)
*
* Virtio drivers
*
PCI driver for virtio devices (VIRTIO_PCI) [N/m/y/?] (NEW)
Platform bus driver for memory mapped virtio devices (VIRTIO_MMIO) [N/m=
/y/?] n
*
* Staging drivers
*
Staging drivers (STAGING) [Y/n/?] y
  Agere ET-1310 Gigabit Ethernet support (ET131X) [N/m/y/?] (NEW)
  Alacritech Gigabit IS-NIC support (SLICOSS) [N/m/y/?] (NEW)
  USB/IP support (USBIP_CORE) [N/m/y/?] n
  IS89C35 WLAN USB driver (W35UND) [N/m/y/?] n
  Prism2.5/3 USB driver (PRISM2_USB) [N/m/y/?] n
  Line Echo Canceller support (ECHO) [N/m/y/?] n
  Data acquisition support (comedi) (COMEDI) [N/m/?] n
  Asus OLED driver (ASUS_OLED) [N/m/y/?] n
  RealTek RTL8187SE Wireless LAN NIC driver (R8187SE) [N/m/?] (NEW)
  RealTek RTL8192U Wireless LAN NIC driver (RTL8192U) [N/m/?] (NEW)
  Support for rtllib wireless devices (RTLLIB) [N/m/?] n
  RealTek RTL8712U (RTL8192SU) Wireless LAN NIC driver (R8712U) [N/m/y/=
?] n
  Realtek RTS5139 USB card reader support (RTS5139) [N/m/y/?] n
  Frontier Tranzport and Alphatrack support (TRANZPORT) [N/m/y/?] n
  PCIE ATA PS5000 IDE support (IDE_PHISON) [N/m/y/?] (NEW)
  VIA Technologies VT6655 support (VT6655) [N/m/?] (NEW)
  VIA Technologies VT6656 support (VT6656) [N/m/?] n
  Discretix SEP driver (DX_SEP) [N/m/y/?] (NEW)
  Memory allocator for compressed pages (ZSMALLOC) [N/y/?] n
  Silicon Motion SM7XX framebuffer support (FB_SM7XX) [N/m/y/?] (NEW)
  Broadcom Crystal HD video decoder support (CRYSTALHD) [N/m/y/?] (NEW)
  XGI display support (FB_XGI) [N/m/y/?] (NEW)
  ACPI Quickstart key driver (ACPI_QUICKSTART) [N/m/y/?] (NEW)
  USB ENE SM card reader support (USB_ENESTORAGE) [N/m/?] n
  Beceem BCS200/BCS220-3 and BCSM250 wimax support (BCM_WIMAX) [N/m/y/?=
] n
  Drivers for Flarion ft1000 devices (FT1000) [N/m/y] n
  Synaptics Clearpad TM1217 (TOUCHSCREEN_CLEARPAD_TM1217) [N/m/y/?] n
  Synaptics i2c rmi4 touchscreen (TOUCHSCREEN_SYNAPTICS_I2C_RMI4) [N/m/=
y/?] n
  USB over WiFi Host Controller (USB_WPAN_HCD) [N/m/y/?] n
  Silicom devices (NET_VENDOR_SILICOM) [Y/n/?] (NEW)
    Silicom BypassCTL library support (SBYPASS) [N/m/?] (NEW)
    Silicom BypassCTL net support (BPCTL) [N/m/?] (NEW)
  Cambridge Electronic Design 1401 USB support (CED1401) [N/m/y/?] n
  Digi Realport driver (DGRP) [N/m/y/?] n
  DesignWare USB2 DRD Core Support (USB_DWC2) [N/m/y/?] (NEW)
*
* X86 Platform Specific Device Drivers
*
X86 Platform Specific Device Drivers (X86_PLATFORM_DEVICES) [Y/n/?] (NE=
W)
  Acer Aspire One temperature and fan driver (ACERHDF) [N/m/y/?] (NEW)
  Asus Laptop Extras (ASUS_LAPTOP) [N/m/y/?] (NEW)
  Chrome OS Laptop (CHROMEOS_LAPTOP) [N/m/y/?] (NEW)
  Fujitsu Laptop Extras (FUJITSU_LAPTOP) [N/m/y/?] (NEW)
  Fujitsu Tablet Extras (FUJITSU_TABLET) [N/m/y/?] (NEW)
  Fujitsu-Siemens Amilo rfkill support (AMILO_RFKILL) [N/m/y/?] (NEW)
  HP laptop accelerometer (HP_ACCEL) [N/m/y/?] (NEW)
  MSI Laptop Extras (MSI_LAPTOP) [N/m/y/?] (NEW)
  Panasonic Laptop Extras (PANASONIC_LAPTOP) [N/m/y/?] (NEW)
  Sony Laptop Extras (SONY_LAPTOP) [N/m/y/?] (NEW)
  Lenovo IdeaPad Laptop Extras (IDEAPAD_LAPTOP) [N/m/y/?] (NEW)
  ThinkPad ACPI Laptop Extras (THINKPAD_ACPI) [N/m/y/?] (NEW)
  Thinkpad Hard Drive Active Protection System (hdaps) (SENSORS_HDAPS)
[N/m/y/?] (NEW)
  Thermal Management driver for Intel menlow platform (INTEL_MENLOW)
[N/m/y/?] (NEW)
  WMI (ACPI_WMI) [N/m/y/?] (NEW)
  Topstar Laptop Extras (TOPSTAR_LAPTOP) [N/m/y/?] (NEW)
  Toshiba Bluetooth RFKill switch support (TOSHIBA_BT_RFKILL) [N/m/y/?]=
 (NEW)
  CMPC Laptop Extras (ACPI_CMPC) [N/m/y/?] (NEW)
  Intel Intelligent Power Sharing (INTEL_IPS) [N/m/y/?] (NEW)
  Device driver to enable PRTL support (IBM_RTL) [N/m/y/?] (NEW)
  OLPC XO-1.5 ebook switch (XO15_EBOOK) [N/m/y/?] (NEW)
  Samsung Laptop driver (SAMSUNG_LAPTOP) [N/m/y/?] (NEW)
  Intel Oaktrail Platform Extras (INTEL_OAKTRAIL) [N/m/y/?] (NEW)
  Samsung Q10 Extras (SAMSUNG_Q10) [N/m/y/?] (NEW)
  Apple Gmux Driver (APPLE_GMUX) [N/m/y/?] (NEW)
  pvpanic device support (PVPANIC) [N/m/y/?] (NEW)
*
* Device Drivers
*
Intel Non-Transparent Bridge support (NTB) [N/m/y/?] (NEW)
*
* VME bridge support
*
VME bridge support (VME_BUS) [N/m/y/?] (NEW)
*
* Firmware Drivers
*
BIOS Enhanced Disk Drive calls determine boot disk (EDD) [N/m/y/?] (NEW=
)
Add firmware-provided memory map to sysfs (FIRMWARE_MEMMAP) [Y/n/?] (NE=
W)
BIOS update support for DELL systems via sysfs (DELL_RBU) [N/m/y/?] (NE=
W)
Dell Systems Management Base Driver (DCDBAS) [N/m/y/?] (NEW)
Export DMI identification via sysfs to userspace (DMIID) [Y/n/?] (NEW)
DMI table support in sysfs (DMI_SYSFS) [N/m/y/?] (NEW)
iSCSI Boot Firmware Table Attributes (ISCSI_IBFT_FIND) [N/y/?] (NEW)
Google Firmware Drivers (GOOGLE_FIRMWARE) [N/y/?] (NEW)
*
* Pseudo filesystems
*
/proc file system support (PROC_FS) [Y/n/?] y
  /proc/kcore support (PROC_KCORE) [N/y] (NEW)
  Sysctl support (/proc/sys) (PROC_SYSCTL) [Y/n/?] y
  Enable /proc page monitoring (PROC_PAGE_MONITOR) [Y/n/?] y
sysfs file system support (SYSFS) [Y/?] y
Tmpfs virtual memory file system support (former shm fs) (TMPFS) [Y/n/?=
] y
  Tmpfs POSIX Access Control Lists (TMPFS_POSIX_ACL) [N/y/?] n
  Tmpfs extended attributes (TMPFS_XATTR) [N/y/?] n
HugeTLB file system support (HUGETLBFS) [N/y/?] (NEW)
Userspace-driven configuration filesystem (CONFIGFS_FS) [M/y/?] m
*
* Kernel hacking
*
Show timing information on printks (PRINTK_TIME) [N/y/?] n
Default message log level (1-7) (DEFAULT_MESSAGE_LOGLEVEL) [4] 4
Enable __deprecated logic (ENABLE_WARN_DEPRECATED) [Y/n/?] y
Enable __must_check logic (ENABLE_MUST_CHECK) [Y/n/?] y
Warn for stack frames larger than (needs gcc 4.4) (FRAME_WARN) [1024] 1=
024
Magic SysRq key (MAGIC_SYSRQ) [Y/n/?] y
Strip assembler-generated symbols during link (STRIP_ASM_SYMS) [N/y/?] =
n
Generate readable assembler code (READABLE_ASM) [N/y/?] n
Enable unused/obsolete exported symbols (UNUSED_SYMBOLS) [N/y/?] n
Debug Filesystem (DEBUG_FS) [Y/n/?] y
Run 'make headers_check' when building vmlinux (HEADERS_CHECK) [N/y/?] =
n
Enable full Section mismatch analysis (DEBUG_SECTION_MISMATCH) [N/y/?] =
n
Kernel debugging (DEBUG_KERNEL) [Y/?] y
  Debug shared IRQ handlers (DEBUG_SHIRQ) [N/y/?] n
  Detect Hard and Soft Lockups (LOCKUP_DETECTOR) [N/y/?] n
Panic on Oops (PANIC_ON_OOPS) [N/y/?] n
Detect Hung Tasks (DETECT_HUNG_TASK) [N/y/?] n
Collect scheduler debugging info (SCHED_DEBUG) [N/y/?] n
Collect scheduler statistics (SCHEDSTATS) [N/y/?] n
Collect kernel timers statistics (TIMER_STATS) [N/y/?] n
Debug object operations (DEBUG_OBJECTS) [N/y/?] n
Enable SLUB performance statistics (SLUB_STATS) [N/y/?] n
Kernel memory leak detector (DEBUG_KMEMLEAK) [N/y/?] n
RT Mutex debugging, deadlock detection (DEBUG_RT_MUTEXES) [N/y/?] n
Built-in scriptable tester for rt-mutexes (RT_MUTEX_TESTER) [N/y/?] n
Spinlock and rw-lock debugging: basic checks (DEBUG_SPINLOCK) [Y/?] y
Mutex debugging: basic checks (DEBUG_MUTEXES) [Y/?] y
Lock debugging: detect incorrect freeing of live locks
(DEBUG_LOCK_ALLOC) [Y/?] y
Lock debugging: prove locking correctness (PROVE_LOCKING) [Y/n/?] y
Lock usage statistics (LOCK_STAT) [N/y/?] n
Lock dependency engine debugging (DEBUG_LOCKDEP) [N/y/?] n
Sleep inside atomic section checking (DEBUG_ATOMIC_SLEEP) [N/y/?] n
Locking API boot-time self-tests (DEBUG_LOCKING_API_SELFTESTS) [N/y/?] =
n
Stack utilization instrumentation (DEBUG_STACK_USAGE) [N/y/?] n
kobject debugging (DEBUG_KOBJECT) [N/y/?] n
Verbose BUG() reporting (adds 70K) (DEBUG_BUGVERBOSE) [N/y/?] n
Compile the kernel with debug info (DEBUG_INFO) [N/y/?] n
Debug VM (DEBUG_VM) [N/y/?] n
Debug VM translations (DEBUG_VIRTUAL) [N/y/?] (NEW)
Debug filesystem writers count (DEBUG_WRITECOUNT) [N/y/?] n
Debug memory initialisation (DEBUG_MEMORY_INIT) [N/y/?] n
Debug linked list manipulation (DEBUG_LIST) [N/y/?] n
Linked list sorting test (TEST_LIST_SORT) [N/y/?] n
Debug SG table operations (DEBUG_SG) [N/y/?] n
Debug notifier call chains (DEBUG_NOTIFIERS) [N/y/?] n
Debug credential management (DEBUG_CREDENTIALS) [N/y/?] n
Compile the kernel with frame pointers (FRAME_POINTER) [Y/?] y
Delay each boot printk message by N milliseconds (BOOT_PRINTK_DELAY) [N=
/y/?] n
Self test for the backtrace code (BACKTRACE_SELF_TEST) [N/m/y/?] n
=46orce extended block device numbers and spread them
(DEBUG_BLOCK_EXT_DEVT) [N/y/?] n
=46orce weak per-cpu definitions (DEBUG_FORCE_WEAK_PER_CPU) [N/y/?] n
Debug access to per_cpu maps (DEBUG_PER_CPU_MAPS) [N/y/?] n
Linux Kernel Dump Test Tool Module (LKDTM) [N/m/y/?] n
Notifier error injection (NOTIFIER_ERROR_INJECTION) [N/m/y/?] n
=46ault-injection framework (FAULT_INJECTION) [N/y/?] n
Latency measuring infrastructure (LATENCYTOP) [N/y/?] (NEW)
Strict user copy size checks (DEBUG_STRICT_USER_COPY_CHECKS) [N/y/?] (N=
EW)
Debug page memory allocations (DEBUG_PAGEALLOC) [N/y/?] n
Red-Black tree test (RBTREE_TEST) [N/m/?] n
Interval tree test (INTERVAL_TREE_TEST) [N/m/?] n
Remote debugging over FireWire early on boot
(PROVIDE_OHCI1394_DMA_INIT) [N/y/?] (NEW)
Enable dynamic printk() support (DYNAMIC_DEBUG) [N/y/?] n
Enable debugging of DMA-API usage (DMA_API_DEBUG) [N/y/?] n
Perform an atomic64_t self-test at boot (ATOMIC64_SELFTEST) [N/y/?] n
*
* kmemcheck: trap use of uninitialized memory
*
kmemcheck: trap use of uninitialized memory (KMEMCHECK) [N/y/?] (NEW)
Test functions located in the string_helpers module at runtime
(TEST_STRING_HELPERS) [N/m/y] n
Test kstrto*() family of functions at runtime (TEST_KSTRTOX) [N/m/y] n
=46ilter access to /dev/mem (STRICT_DEVMEM) [N/y/?] n
Enable verbose x86 bootup info messages (X86_VERBOSE_BOOTUP) [Y/n/?] (N=
EW)
Early printk (EARLY_PRINTK) [Y/n/?] (NEW)
  Early printk via EHCI debug port (EARLY_PRINTK_DBGP) [N/y/?] (NEW)
Check for stack overflows (DEBUG_STACKOVERFLOW) [N/y/?] (NEW)
Export kernel pagetable layout to userspace via debugfs (X86_PTDUMP)
[N/y/?] (NEW)
Write protect kernel read-only data structures (DEBUG_RODATA) [Y/n/?] (=
NEW)
  Testcase for the DEBUG_RODATA feature (DEBUG_RODATA_TEST) [Y/n/?] (NE=
W)
Set loadable kernel module data as NX and text as RO
(DEBUG_SET_MODULE_RONX) [N/y/?] (NEW)
Testcase for the NX non-executable stack feature (DEBUG_NX_TEST) [N/m/?=
] (NEW)
Set upper limit of TLB entries to flush one-by-one (DEBUG_TLBFLUSH)
[N/y/?] (NEW)
Enable IOMMU debugging (IOMMU_DEBUG) [N/y/?] (NEW)
Enable IOMMU stress-test mode (IOMMU_STRESS) [N/y/?] (NEW)
IO delay type
> 1. port 0x80 based port-IO delay [recommended] (IO_DELAY_0X80) (NEW)
  2. port 0xed based port-IO delay (IO_DELAY_0XED) (NEW)
  3. udelay based port-IO delay (IO_DELAY_UDELAY) (NEW)
  4. no port-IO delay (IO_DELAY_NONE) (NEW)
choice[1-4]:
Debug boot parameters (DEBUG_BOOT_PARAMS) [N/y/?] (NEW)
CPA self-test code (CPA_DEBUG) [N/y/?] (NEW)
Allow gcc to uninline functions marked 'inline' (OPTIMIZE_INLINING)
[N/y/?] (NEW)
NMI Selftest (DEBUG_NMI_SELFTEST) [N/y/?] (NEW)
*
* Cryptographic API
*
Cryptographic API (CRYPTO) [Y/?] y
  *
  * Crypto core or helper
  *
  Cryptographic algorithm manager (CRYPTO_MANAGER) [N/m/y/?] n
  Userspace cryptographic algorithm configuration (CRYPTO_USER) [N/m/y/=
?] n
  GF(2^128) multiplication functions (CRYPTO_GF128MUL) [N/m/y/?] n
  Null algorithms (CRYPTO_NULL) [N/m/y/?] n
  Parallel crypto engine (CRYPTO_PCRYPT) [N/m/y/?] n
  Software async crypto daemon (CRYPTO_CRYPTD) [N/m/y/?] n
  Authenc support (CRYPTO_AUTHENC) [N/m/y/?] n
  Testing module (CRYPTO_TEST) [N/m/?] n
  *
  * Authenticated Encryption with Associated Data
  *
  CCM support (CRYPTO_CCM) [N/m/y/?] n
  GCM/GMAC support (CRYPTO_GCM) [N/m/y/?] n
  Sequence Number IV Generator (CRYPTO_SEQIV) [N/m/y/?] n
  *
  * Block modes
  *
  CBC support (CRYPTO_CBC) [N/m/y/?] n
  CTR support (CRYPTO_CTR) [N/m/y/?] n
  CTS support (CRYPTO_CTS) [N/m/y/?] n
  ECB support (CRYPTO_ECB) [N/m/y/?] n
  LRW support (CRYPTO_LRW) [N/m/y/?] n
  PCBC support (CRYPTO_PCBC) [N/m/y/?] n
  XTS support (CRYPTO_XTS) [N/m/y/?] n
  *
  * Hash modes
  *
  CMAC support (CRYPTO_CMAC) [N/m/y/?] n
  HMAC support (CRYPTO_HMAC) [N/m/y/?] n
  XCBC support (CRYPTO_XCBC) [N/m/y/?] n
  VMAC support (CRYPTO_VMAC) [N/m/y/?] n
  *
  * Digest
  *
  CRC32c CRC algorithm (CRYPTO_CRC32C) [Y/?] y
  CRC32c INTEL hardware acceleration (CRYPTO_CRC32C_INTEL) [N/m/y/?] (N=
EW)
  CRC32 CRC algorithm (CRYPTO_CRC32) [N/m/y/?] n
  CRC32 PCLMULQDQ hardware acceleration (CRYPTO_CRC32_PCLMUL) [N/m/y/?]=
 (NEW)
  GHASH digest algorithm (CRYPTO_GHASH) [N/m/y/?] n
  MD4 digest algorithm (CRYPTO_MD4) [N/m/y/?] n
  MD5 digest algorithm (CRYPTO_MD5) [N/m/y/?] n
  Michael MIC keyed digest algorithm (CRYPTO_MICHAEL_MIC) [N/m/y/?] n
  RIPEMD-128 digest algorithm (CRYPTO_RMD128) [N/m/y/?] n
  RIPEMD-160 digest algorithm (CRYPTO_RMD160) [N/m/y/?] n
  RIPEMD-256 digest algorithm (CRYPTO_RMD256) [N/m/y/?] n
  RIPEMD-320 digest algorithm (CRYPTO_RMD320) [N/m/y/?] n
  SHA1 digest algorithm (CRYPTO_SHA1) [N/m/y/?] n
  SHA1 digest algorithm (SSSE3/AVX) (CRYPTO_SHA1_SSSE3) [N/m/y/?] (NEW)
  SHA256 digest algorithm (SSSE3/AVX/AVX2) (CRYPTO_SHA256_SSSE3) [N/m/y=
/?] (NEW)
  SHA512 digest algorithm (SSSE3/AVX/AVX2) (CRYPTO_SHA512_SSSE3) [N/m/y=
/?] (NEW)
  SHA224 and SHA256 digest algorithm (CRYPTO_SHA256) [N/m/y/?] n
  SHA384 and SHA512 digest algorithms (CRYPTO_SHA512) [N/m/y/?] n
  Tiger digest algorithms (CRYPTO_TGR192) [N/m/y/?] n
  Whirlpool digest algorithms (CRYPTO_WP512) [N/m/y/?] n
  GHASH digest algorithm (CLMUL-NI accelerated)
(CRYPTO_GHASH_CLMUL_NI_INTEL) [N/m/y/?] (NEW)
  *
  * Ciphers
  *
  AES cipher algorithms (CRYPTO_AES) [Y/?] y
  AES cipher algorithms (x86_64) (CRYPTO_AES_X86_64) [N/m/y/?] (NEW)
  AES cipher algorithms (AES-NI) (CRYPTO_AES_NI_INTEL) [N/m/y/?] (NEW)
  Anubis cipher algorithm (CRYPTO_ANUBIS) [N/m/y/?] n
  ARC4 cipher algorithm (CRYPTO_ARC4) [Y/?] y
  Blowfish cipher algorithm (CRYPTO_BLOWFISH) [N/m/y/?] n
  Blowfish cipher algorithm (x86_64) (CRYPTO_BLOWFISH_X86_64) [N/m/y/?]=
 (NEW)
  Camellia cipher algorithms (CRYPTO_CAMELLIA) [N/m/y/?] n
  Camellia cipher algorithm (x86_64) (CRYPTO_CAMELLIA_X86_64) [N/m/y/?]=
 (NEW)
  Camellia cipher algorithm (x86_64/AES-NI/AVX)
(CRYPTO_CAMELLIA_AESNI_AVX_X86_64) [N/m/y/?] (NEW)
  Camellia cipher algorithm (x86_64/AES-NI/AVX2)
(CRYPTO_CAMELLIA_AESNI_AVX2_X86_64) [N/m/y/?] (NEW)
  CAST5 (CAST-128) cipher algorithm (CRYPTO_CAST5) [N/m/y/?] n
  CAST5 (CAST-128) cipher algorithm (x86_64/AVX)
(CRYPTO_CAST5_AVX_X86_64) [N/m/y/?] (NEW)
  CAST6 (CAST-256) cipher algorithm (CRYPTO_CAST6) [N/m/y/?] n
  CAST6 (CAST-256) cipher algorithm (x86_64/AVX)
(CRYPTO_CAST6_AVX_X86_64) [N/m/y/?] (NEW)
  DES and Triple DES EDE cipher algorithms (CRYPTO_DES) [N/m/y/?] n
  FCrypt cipher algorithm (CRYPTO_FCRYPT) [N/m/y/?] n
  Khazad cipher algorithm (CRYPTO_KHAZAD) [N/m/y/?] n
  Salsa20 stream cipher algorithm (CRYPTO_SALSA20) [N/m/y/?] n
  Salsa20 stream cipher algorithm (x86_64) (CRYPTO_SALSA20_X86_64)
[N/m/y/?] (NEW)
  SEED cipher algorithm (CRYPTO_SEED) [N/m/y/?] n
  Serpent cipher algorithm (CRYPTO_SERPENT) [N/m/y/?] n
  Serpent cipher algorithm (x86_64/SSE2) (CRYPTO_SERPENT_SSE2_X86_64)
[N/m/y/?] (NEW)
  Serpent cipher algorithm (x86_64/AVX) (CRYPTO_SERPENT_AVX_X86_64)
[N/m/y/?] (NEW)
  Serpent cipher algorithm (x86_64/AVX2) (CRYPTO_SERPENT_AVX2_X86_64)
[N/m/y/?] (NEW)
  TEA, XTEA and XETA cipher algorithms (CRYPTO_TEA) [N/m/y/?] n
  Twofish cipher algorithm (CRYPTO_TWOFISH) [N/m/y/?] n
  Twofish cipher algorithm (x86_64) (CRYPTO_TWOFISH_X86_64) [N/m/y/?] (=
NEW)
  Twofish cipher algorithm (x86_64, 3-way parallel)
(CRYPTO_TWOFISH_X86_64_3WAY) [N/m/y/?] (NEW)
  Twofish cipher algorithm (x86_64/AVX) (CRYPTO_TWOFISH_AVX_X86_64)
[N/m/y/?] (NEW)
  *
  * Compression
  *
  Deflate compression algorithm (CRYPTO_DEFLATE) [Y/?] y
  Zlib compression algorithm (CRYPTO_ZLIB) [N/m/y/?] n
  LZO compression algorithm (CRYPTO_LZO) [Y/?] y
  *
  * Random Number Generation
  *
  Pseudo Random Number Generation for Cryptographic modules
(CRYPTO_ANSI_CPRNG) [N/m/y/?] n
  User-space interface for hash algorithms (CRYPTO_USER_API_HASH) [N/m/=
y/?] n
  User-space interface for symmetric key cipher algorithms
(CRYPTO_USER_API_SKCIPHER) [N/m/y/?] n
#
# configuration written to .config
#
include/config/auto.conf:575:warning: symbol value
'debug/uncompress.h' invalid for UNCOMPRESS_INCLUDE
include/config/auto.conf:582:warning: symbol value
'mach/debug-macro.S' invalid for DEBUG_LL_INCLUDE














  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/syscalls/../include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/syscalls/../include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/syscalls/../include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/syscalls/../include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/syscalls/../include/generated/asm/syscalls_64.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  WRAP    arch/x86/include/generated/asm/clkdev.h
  CHK     include/generated/uapi/linux/version.h
  UPD     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHECK   scripts/mod/empty.c
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  CC      scripts/mod/devicetable-offsets.s
  GEN     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/sortextable
  LD      drivers/staging/wlan-ng/built-in.o
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

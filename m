From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Thu, 27 Dec 2018 13:47:34 +0900
Message-ID: <CAK7LNASo5jedRxjX5zevLSmZRce3fERcFc=qn_JtJXx1Ss3iJA@mail.gmail.com>
References: <20181008073128.GL29268@gate.crashing.org>
	<alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
	<20181009145330.GT29268@gate.crashing.org>
	<alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
	<20181010072240.GB103159@gmail.com>
	<20181010080324.GV29268@gate.crashing.org>
	<20181010081906.GA5533@zn.tnic>
	<20181010185432.GB29268@gate.crashing.org>
	<20181010191427.GF5533@zn.tnic> <20181013193335.GD31650@zn.tnic>
	<20181031125526.GA13219@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181031125526.GA13219@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Max Filippov <jcmvbkbc@gmail.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Segher Boessenkool <segher@kernel.crashing.org>, Chris Zankel <chris@zankel.net>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.>
List-Id: linux-sparse@vger.kernel.org

Hi Peter,


On Wed, Oct 31, 2018 at 9:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Oct 13, 2018 at 09:33:35PM +0200, Borislav Petkov wrote:
> > Ok,
> >
> > with Segher's help I've been playing with his patch ontop of bleeding
> > edge gcc 9 and here are my observations. Please double-check me for
> > booboos so that they can be addressed while there's time.
> >
> > So here's what I see ontop of 4.19-rc7:
> >
> > First marked the alternative asm() as inline and undeffed the "inline"
> > keyword. I need to do that because of the funky games we do with
> > "inline" redefinitions in include/linux/compiler_types.h.
> >
> > And Segher hinted at either doing:
> >
> > asm volatile inline(...
> >
> > or
> >
> > asm volatile __inline__(...
> >
> > but both "inline" variants are defined as macros in that file.
> >
> > Which means we either need to #undef inline before using it in asm() or
> > come up with something cleverer.
>
> # git grep -e "\<__inline__\>" | wc -l
> 488
> # git grep -e "\<__inline\>" | wc -l
> 56
> # git grep -e "\<inline\>" | wc -l
> 69598
>
> And we already have scripts/checkpatch.pl:
>
>   # Check for __inline__ and __inline, prefer inline
>
> Which suggests we do:
>
> git grep -l "\<__inline\(\|__\)\>" | while read file
> do
>         sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
> done
>
> and get it over with.


Do you have a plan to really do this?

This is a nice cleanup anyway.

I think the last minute of MW is
a good timing for the global replacement like this.




>
> Anyway, with the below patch, I get:
>
>    text    data     bss     dec     hex filename
> 17385183        5064780 1953892 24403855        1745f8f defconfig-build/vmlinux
> 17385678        5064780 1953892 24404350        174617e defconfig-build/vmlinux
>
> Which shows we inline more (look for asm_volatile for the actual
> changes).
>
>
> So yes, this seems like something we could work with.
>
> ---
>  Documentation/trace/tracepoint-analysis.rst        |  2 +-
>  Documentation/translations/ja_JP/SubmittingPatches |  4 +--
>  Documentation/translations/zh_CN/SubmittingPatches |  4 +--
>  arch/alpha/include/asm/atomic.h                    | 12 +++----
>  arch/alpha/include/asm/bitops.h                    |  6 ++--
>  arch/alpha/include/asm/compiler.h                  |  4 +--
>  arch/alpha/include/asm/dma.h                       | 22 ++++++------
>  arch/alpha/include/asm/floppy.h                    |  4 +--
>  arch/alpha/include/asm/irq.h                       |  2 +-
>  arch/alpha/include/asm/local.h                     |  4 +--
>  arch/alpha/include/asm/smp.h                       |  2 +-
>  arch/arm/mach-iop32x/include/mach/uncompress.h     |  2 +-
>  arch/arm/mach-iop33x/include/mach/uncompress.h     |  2 +-
>  arch/arm/mach-ixp4xx/include/mach/uncompress.h     |  2 +-
>  arch/ia64/hp/common/sba_iommu.c                    |  2 +-
>  arch/ia64/hp/sim/simeth.c                          |  2 +-
>  arch/ia64/include/asm/atomic.h                     |  8 ++---
>  arch/ia64/include/asm/bitops.h                     | 34 +++++++++---------
>  arch/ia64/include/asm/delay.h                      | 14 ++++----
>  arch/ia64/include/asm/irq.h                        |  2 +-
>  arch/ia64/include/asm/page.h                       |  2 +-
>  arch/ia64/include/asm/sn/leds.h                    |  2 +-
>  arch/ia64/include/asm/uaccess.h                    |  4 +--
>  arch/ia64/include/uapi/asm/rse.h                   | 12 +++----
>  arch/ia64/include/uapi/asm/swab.h                  |  6 ++--
>  arch/ia64/oprofile/backtrace.c                     |  4 +--
>  arch/m68k/include/asm/blinken.h                    |  2 +-
>  arch/m68k/include/asm/checksum.h                   |  2 +-
>  arch/m68k/include/asm/dma.h                        | 32 ++++++++---------
>  arch/m68k/include/asm/floppy.h                     |  8 ++---
>  arch/m68k/include/asm/nettel.h                     |  8 ++---
>  arch/m68k/mac/iop.c                                | 14 ++++----
>  arch/mips/include/asm/atomic.h                     | 16 ++++-----
>  arch/mips/include/asm/checksum.h                   |  2 +-
>  arch/mips/include/asm/dma.h                        | 20 +++++------
>  arch/mips/include/asm/jazz.h                       |  2 +-
>  arch/mips/include/asm/local.h                      |  4 +--
>  arch/mips/include/asm/string.h                     |  8 ++---
>  arch/mips/kernel/binfmt_elfn32.c                   |  2 +-
>  arch/nds32/include/asm/swab.h                      |  4 +--
>  arch/parisc/include/asm/atomic.h                   | 20 +++++------
>  arch/parisc/include/asm/bitops.h                   | 18 +++++-----
>  arch/parisc/include/asm/checksum.h                 |  4 +--
>  arch/parisc/include/asm/compat.h                   |  2 +-
>  arch/parisc/include/asm/delay.h                    |  2 +-
>  arch/parisc/include/asm/dma.h                      | 20 +++++------
>  arch/parisc/include/asm/ide.h                      |  8 ++---
>  arch/parisc/include/asm/irq.h                      |  2 +-
>  arch/parisc/include/asm/spinlock.h                 | 12 +++----
>  arch/powerpc/include/asm/atomic.h                  | 40 +++++++++++-----------
>  arch/powerpc/include/asm/bitops.h                  | 28 +++++++--------
>  arch/powerpc/include/asm/dma.h                     | 20 +++++------
>  arch/powerpc/include/asm/edac.h                    |  2 +-
>  arch/powerpc/include/asm/irq.h                     |  2 +-
>  arch/powerpc/include/asm/local.h                   | 14 ++++----
>  arch/sh/include/asm/pgtable_64.h                   |  2 +-
>  arch/sh/include/asm/processor_32.h                 |  4 +--
>  arch/sh/include/cpu-sh3/cpu/dac.h                  |  6 ++--
>  arch/x86/include/asm/alternative.h                 | 14 ++++----
>  arch/x86/um/asm/checksum.h                         |  4 +--
>  arch/x86/um/asm/checksum_32.h                      |  4 +--
>  arch/xtensa/include/asm/checksum.h                 | 14 ++++----
>  arch/xtensa/include/asm/cmpxchg.h                  |  4 +--
>  arch/xtensa/include/asm/irq.h                      |  2 +-
>  block/partitions/amiga.c                           |  2 +-
>  drivers/atm/he.c                                   |  6 ++--
>  drivers/atm/idt77252.c                             |  6 ++--
>  drivers/gpu/drm/mga/mga_drv.h                      |  2 +-
>  drivers/gpu/drm/mga/mga_state.c                    | 14 ++++----
>  drivers/gpu/drm/r128/r128_drv.h                    |  2 +-
>  drivers/gpu/drm/r128/r128_state.c                  | 14 ++++----
>  drivers/gpu/drm/via/via_irq.c                      |  2 +-
>  drivers/gpu/drm/via/via_verifier.c                 | 30 ++++++++--------
>  drivers/isdn/hardware/eicon/platform.h             | 14 ++++----
>  drivers/isdn/i4l/isdn_net.c                        | 14 ++++----
>  drivers/isdn/i4l/isdn_net.h                        |  8 ++---
>  drivers/media/pci/ivtv/ivtv-ioctl.c                |  2 +-
>  drivers/net/ethernet/sun/sungem.c                  |  8 ++---
>  drivers/net/ethernet/sun/sunhme.c                  |  6 ++--
>  drivers/net/hamradio/baycom_ser_fdx.c              |  2 +-
>  drivers/net/wan/lapbether.c                        |  2 +-
>  drivers/net/wan/n2.c                               |  4 +--
>  drivers/parisc/led.c                               |  4 +--
>  drivers/parisc/sba_iommu.c                         |  2 +-
>  drivers/parport/parport_gsc.c                      |  2 +-
>  drivers/parport/parport_gsc.h                      |  4 +--
>  drivers/parport/parport_pc.c                       |  2 +-
>  drivers/scsi/lpfc/lpfc_scsi.c                      |  2 +-
>  drivers/scsi/pcmcia/sym53c500_cs.c                 |  4 +--
>  drivers/scsi/qla2xxx/qla_inline.h                  |  2 +-
>  drivers/scsi/qla2xxx/qla_os.c                      |  4 +--
>  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |  4 +--
>  drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  2 +-
>  drivers/staging/rtl8723bs/include/drv_types.h      |  6 ++--
>  drivers/staging/rtl8723bs/include/ieee80211.h      |  6 ++--
>  drivers/staging/rtl8723bs/include/osdep_service.h  | 10 +++---
>  .../rtl8723bs/include/osdep_service_linux.h        | 14 ++++----
>  drivers/staging/rtl8723bs/include/rtw_mlme.h       | 14 ++++----
>  drivers/staging/rtl8723bs/include/rtw_recv.h       | 16 ++++-----
>  drivers/staging/rtl8723bs/include/sta_info.h       |  2 +-
>  drivers/staging/rtl8723bs/include/wifi.h           | 14 ++++----
>  drivers/staging/rtl8723bs/include/wlan_bssdef.h    |  2 +-
>  drivers/tty/amiserial.c                            |  2 +-
>  drivers/tty/serial/ip22zilog.c                     |  2 +-
>  drivers/tty/serial/sunsab.c                        |  4 +--
>  drivers/tty/serial/sunzilog.c                      |  2 +-
>  drivers/video/fbdev/core/fbcon.c                   | 20 +++++------
>  drivers/video/fbdev/ffb.c                          |  2 +-
>  drivers/video/fbdev/intelfb/intelfbdrv.c           | 10 +++---
>  drivers/video/fbdev/intelfb/intelfbhw.c            |  2 +-
>  drivers/w1/masters/matrox_w1.c                     |  4 +--
>  fs/coda/coda_linux.h                               |  6 ++--
>  fs/freevxfs/vxfs_inode.c                           |  2 +-
>  fs/nfsd/nfsfh.h                                    |  4 +--
>  include/acpi/platform/acgcc.h                      |  2 +-
>  include/acpi/platform/acintel.h                    |  2 +-
>  include/asm-generic/ide_iops.h                     |  8 ++---
>  include/linux/atalk.h                              |  4 +--
>  include/linux/ceph/messenger.h                     |  2 +-
>  include/linux/compiler_types.h                     |  4 +--
>  include/linux/hdlc.h                               |  4 +--
>  include/linux/inetdevice.h                         |  8 ++---
>  include/linux/parport.h                            |  4 +--
>  include/linux/parport_pc.h                         | 22 ++++++------
>  include/net/ax25.h                                 |  2 +-
>  include/net/checksum.h                             |  2 +-
>  include/net/dn_nsp.h                               | 16 ++++-----
>  include/net/ip.h                                   |  2 +-
>  include/net/ip6_checksum.h                         |  2 +-
>  include/net/ipx.h                                  | 10 +++---
>  include/net/llc_c_ev.h                             |  4 +--
>  include/net/llc_conn.h                             |  4 +--
>  include/net/llc_s_ev.h                             |  2 +-
>  include/net/netrom.h                               |  8 ++---
>  include/net/scm.h                                  | 14 ++++----
>  include/net/udplite.h                              |  2 +-
>  include/net/x25.h                                  |  8 ++---
>  include/net/xfrm.h                                 | 18 +++++-----
>  include/uapi/linux/atm.h                           |  4 +--
>  include/uapi/linux/atmsap.h                        |  2 +-
>  include/uapi/linux/map_to_7segment.h               |  2 +-
>  include/uapi/linux/netfilter_arp/arp_tables.h      |  2 +-
>  include/uapi/linux/netfilter_bridge/ebtables.h     |  2 +-
>  include/uapi/linux/netfilter_ipv4/ip_tables.h      |  2 +-
>  include/uapi/linux/netfilter_ipv6/ip6_tables.h     |  2 +-
>  include/video/newport.h                            | 12 +++----
>  lib/zstd/mem.h                                     |  2 +-
>  net/appletalk/atalk_proc.c                         |  4 +--
>  net/appletalk/ddp.c                                |  2 +-
>  net/core/neighbour.c                               |  2 +-
>  net/core/scm.c                                     |  2 +-
>  net/decnet/dn_nsp_in.c                             |  2 +-
>  net/decnet/dn_nsp_out.c                            |  2 +-
>  net/decnet/dn_route.c                              |  2 +-
>  net/decnet/dn_table.c                              |  4 +--
>  net/ipv4/igmp.c                                    |  2 +-
>  net/ipv6/af_inet6.c                                |  2 +-
>  net/ipv6/icmp.c                                    |  4 +--
>  net/ipv6/udp.c                                     |  4 +--
>  net/lapb/lapb_iface.c                              |  4 +--
>  net/llc/llc_input.c                                |  2 +-
>  scripts/checkpatch.pl                              |  8 ++---
>  scripts/genksyms/keywords.c                        |  4 +--
>  scripts/kernel-doc                                 |  4 +--
>  sound/sparc/amd7930.c                              |  6 ++--
>  165 files changed, 547 insertions(+), 547 deletions(-)


-- 
Best Regards
Masahiro Yamada

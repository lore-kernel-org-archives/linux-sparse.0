From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 0/4] kernel hacking: GCC optimization for better debug experience (-Og)
Date: Sun, 28 Oct 2018 13:09:41 +0000
Message-ID: <20181028130945.23581-1-changbin.du@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk, akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, robin.murphy@arm.com, Changbin Du <changbin.du@gmail.com>
List-Id: linux-sparse@vger.kernel.org

Hi all,
I have posted this series several months ago but interrupted by personal
affairs. Now I get time to complete this task. Thanks for all of the
reviewers.

I know some kernel developers was searching for a method to dissable GCC
optimizations, probably they want to apply GCC '-O0' option. But since Linux
kernel relies on GCC optimization to remove some dead code, so '-O0' just
breaks the build. They do need this because they want to debug kernel with
qemu, simics, kgtp or kgdb.

Thanks for the GCC '-Og' optimization level introduced in GCC 4.8, which
offers a reasonable level of optimization while maintaining fast compilation
and a good debugging experience. It is similar to '-O1' while perferring to
keep debug ability over runtime speed. With '-Og', we can build a kernel with
better debug ability and little performance drop after some simple change.

In this series, firstly introduce a new config CONFIG_NO_AUTO_INLINE after two
fixes for this new option. With this option, only functions explicitly marked
with "inline" will  be inlined. This will allow the function tracer to trace
more functions because it only traces functions that the compiler has not
inlined.

Then introduce new config CC_OPTIMIZE_FOR_DEBUGGING which apply '-Og'
optimization level for whole kernel, with a simple fix in fix_to_virt().
Currently I have only tested this option on x86 and ARM platform. Other
platforms should also work but probably need some compiling fixes as what
having done in this series. I leave that to who want to try this debug
option.

Comparison of vmlinux size: a bit smaller.

    w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ size vmlinux
       text    data     bss     dec     hex filename
    22665554   9709674  2920908 35296136        21a9388 vmlinux

    w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ size vmlinux
       text    data     bss     dec     hex filename
    21499032   10102758 2920908 34522698        20ec64a vmlinux


Comparison of system performance: a bit drop (~6%).
    This benchmark of kernel compilation is suggested by Ingo Molnar.
    https://lkml.org/lkml/2018/5/2/74

    Preparation: Set cpufreq to 'performance'.
    for ((cpu=0; cpu<120; cpu++)); do
      G=/sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
      [ -f $G ] && echo performance > $G
    done

    w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

     Performance counter stats for 'make -j8' (5 runs):

        219.764246652 seconds time elapsed                   ( +-  0.78% )

    w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

    Performance counter stats for 'make -j8' (5 runs):

         233.574187771 seconds time elapsed                  ( +-  0.19% )

v3:
  o Take suggestions from Masahiro Yamada.
v2:
  o rebase on top of mainline.

Changbin Du (4):
  x86/mm: declare check_la57_support() as inline
  kernel hacking: new config NO_AUTO_INLINE to disable compiler
    auto-inline optimizations
  ARM: mm: fix build error in fix_to_virt with
    CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
  kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
    optimization

 Makefile                     | 11 +++++++++++
 arch/arm/mm/mmu.c            |  2 +-
 arch/x86/kernel/head64.c     |  2 +-
 include/linux/compiler-gcc.h |  2 +-
 include/linux/compiler.h     |  2 +-
 init/Kconfig                 | 20 ++++++++++++++++++++
 kernel/configs/tiny.config   |  1 +
 lib/Kconfig.debug            | 17 +++++++++++++++++
 8 files changed, 53 insertions(+), 4 deletions(-)

-- 
2.17.1

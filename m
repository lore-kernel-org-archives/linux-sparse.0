From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 4/4] kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Date: Sun, 28 Oct 2018 13:09:45 +0000
Message-ID: <20181028130945.23581-5-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181028130945.23581-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk, akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, robin.murphy@arm.com, Changbin Du <changbin.du@gmail.com>
List-Id: linux-sparse@vger.kernel.org

This will apply GCC '-Og' optimization level which is supported
since GCC 4.8. This optimization level offers a reasonable level
of optimization while maintaining fast compilation and a good
debugging experience. It is similar to '-O1' while perferring
to keep debug ability over runtime speed.

If enabling this option breaks your kernel, you should either
disable this or find a fix (mostly in the arch code). Currently
this option has only been tested on x86_64 and arm platform.

This option can satisfy people who was searching for a method
to disable compiler optimizations so to achieve better kernel
debugging experience with kgdb or qemu.

The main problem of '-Og' is we must not use __attribute__((error(msg))).
The compiler will report error though the call to error function
still can be optimize out. So we must fallback to array tricky.

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

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

---
v3:
  o make CC_OPTIMIZE_FOR_DEBUGGING depends on $(cc-option,-Og)
  o reflect CONFIG_CC_OPTIMIZE_FOR_DEBUGGING in tiny.config
---
 Makefile                     |  5 +++++
 include/linux/compiler-gcc.h |  2 +-
 include/linux/compiler.h     |  2 +-
 init/Kconfig                 | 20 ++++++++++++++++++++
 kernel/configs/tiny.config   |  1 +
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 04beb822ddfc..10de245a3325 100644
--- a/Makefile
+++ b/Makefile
@@ -657,6 +657,10 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
+ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
+KBUILD_CFLAGS	+= -Og
+KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
+else
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
@@ -667,6 +671,7 @@ else
 KBUILD_CFLAGS   += -O2
 endif
 endif
+endif
 
 KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 			$(call cc-disable-warning,maybe-uninitialized,))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 90ddfefb6c2b..4832c98c7885 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -85,7 +85,7 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#ifndef __CHECKER__
+#if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 1921545c6351..3836397bf477 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -350,7 +350,7 @@ static inline void *offset_to_ptr(const int *off)
  * sparse see a constant array size without breaking compiletime_assert on old
  * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
  */
-# ifndef __CHECKER__
+# if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #  define __compiletime_error_fallback(condition) \
 	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
 # endif
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..0fb9c0b5f1a1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1105,6 +1105,26 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+config CC_OPTIMIZE_FOR_DEBUGGING
+	bool "Optimize for better debugging experience (-Og)"
+	depends on $(cc-option,-Og)
+	select NO_AUTO_INLINE
+	help
+	  This will apply GCC '-Og' optimization level which is supported
+	  since GCC 4.8. This optimization level offers a reasonable level
+	  of optimization while maintaining fast compilation and a good
+	  debugging experience. It is similar to '-O1' while preferring to
+	  keep debug ability over runtime speed. The overall performance
+	  will drop a bit (~6%).
+
+	  Use only if you want to debug the kernel, especially if you want
+	  to have better kernel debugging experience with gdb facilities
+	  like kgdb or qemu. If enabling this option breaks your kernel,
+	  you should either disable this or find a fix (mostly in the arch
+	  code).
+
+	  If unsure, select N.
+
 endchoice
 
 config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
index 7fa0c4ae6394..599ea86b0800 100644
--- a/kernel/configs/tiny.config
+++ b/kernel/configs/tiny.config
@@ -1,5 +1,6 @@
 # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is not set
 # CONFIG_KERNEL_GZIP is not set
 # CONFIG_KERNEL_BZIP2 is not set
 # CONFIG_KERNEL_LZMA is not set
-- 
2.17.1

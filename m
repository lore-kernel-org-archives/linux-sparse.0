From: changbin.du@intel.com
Subject: [PATCH v5 1/4] x86/mm: surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif
Date: Tue,  5 Jun 2018 16:13:37 +0800
Message-ID: <1528186420-6615-2-git-send-email-changbin.du@intel.com>
References: <1528186420-6615-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528186420-6615-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, akpm@linux-foundation.org, yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc: rostedt@goodmis.org, tglx@linutronix.de, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, changbin.du@gmail.com, Changbin Du <changbin.du@intel.com>
List-Id: linux-sparse@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

The level4_kernel_pgt is only defined when X86_5LEVEL is enabled. So
surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif to
make code correct.

Signed-off-by: Changbin Du <changbin.du@intel.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/pgtable_64.h |  2 ++
 arch/x86/kernel/head64.c          | 13 ++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 877bc27..9e7f667 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -15,7 +15,9 @@
 #include <linux/bitops.h>
 #include <linux/threads.h>
 
+#ifdef CONFIG_X86_5LEVEL
 extern p4d_t level4_kernel_pgt[512];
+#endif
 extern p4d_t level4_ident_pgt[512];
 extern pud_t level3_kernel_pgt[512];
 extern pud_t level3_ident_pgt[512];
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c408f8..775d7a6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,16 +143,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pgd = fixup_pointer(&early_top_pgt, physaddr);
 	p = pgd + pgd_index(__START_KERNEL_map);
-	if (la57)
-		*p = (unsigned long)level4_kernel_pgt;
-	else
-		*p = (unsigned long)level3_kernel_pgt;
-	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
-
+#ifdef CONFIG_X86_5LEVEL
 	if (la57) {
+		*p = (unsigned long)level4_kernel_pgt;
 		p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
 		p4d[511] += load_delta;
-	}
+	} else
+#endif
+		*p = (unsigned long)level3_kernel_pgt;
+	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
 
 	pud = fixup_pointer(&level3_kernel_pgt, physaddr);
 	pud[510] += load_delta;
-- 
2.7.4

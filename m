From: =?windows-1252?Q?Martin_Li=9Aka?= <mliska@suse.cz>
Subject: Re: [PATCH 2/2] compiler/gcc6: add support for GCC 6
Date: Wed, 15 Apr 2015 11:29:18 +0200
Message-ID: <552E2F6E.60402@suse.cz>
References: <18dfac4fefaed0816f50af5a410fad2d27ca9639.1429003432.git.mliska@suse.cz> <552CDCF5.9000206@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000806060100030701060405"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60628 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755900AbbDOJ3U (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Apr 2015 05:29:20 -0400
In-Reply-To: <552CDCF5.9000206@suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org

This is a multi-part message in MIME format.
--------------000806060100030701060405
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

On 04/14/2015 11:25 AM, Martin Liška wrote:
> Because GCC trunk version has switched to GCC 6.x, new header file
> is needed.
>
> Signed-off-by: Martin Liska  <mliska@suse.cz>
> ---
>   include/linux/compiler-gcc6.h | 55 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>   create mode 100644 include/linux/compiler-gcc6.h
>
> diff --git a/include/linux/compiler-gcc6.h b/include/linux/compiler-gcc6.h
> new file mode 100644
> index 0000000..208767a
> --- /dev/null
> +++ b/include/linux/compiler-gcc6.h
> @@ -0,0 +1,55 @@
> +#ifndef __LINUX_COMPILER_H
> +#error "Please don't include <linux/compiler-gcc6.h> directly, include <linux/compiler.h> instead."
> +#endif
> +
> +#define __used                __attribute__((__used__))
> +#define __must_check            __attribute__((warn_unused_result))
> +#define __compiler_offsetof(a, b)    __builtin_offsetof(a, b)
> +
> +/* Mark functions as cold. gcc will assume any path leading to a call
> +   to them will be unlikely.  This means a lot of manual unlikely()s
> +   are unnecessary now for any paths leading to the usual suspects
> +   like BUG(), printk(), panic() etc. [but let's keep them for now for
> +   older compilers]
> +
> +   gcc also has a __attribute__((__hot__)) to move hot functions into
> +   a special section, but I don't see any sense in this right now in
> +   the kernel context */
> +#define __cold            __attribute__((__cold__))
> +
> +#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
> +
> +#ifndef __CHECKER__
> +# define __compiletime_warning(message) __attribute__((warning(message)))
> +# define __compiletime_error(message) __attribute__((error(message)))
> +#endif /* __CHECKER__ */
> +
> +/*
> + * Mark a position in code as unreachable.  This can be used to
> + * suppress control flow warnings after asm blocks that transfer
> + * control elsewhere.
> + */
> +#define unreachable() __builtin_unreachable()
> +
> +/* Mark a function definition as prohibited from being cloned. */
> +#define __noclone    __attribute__((__noclone__))
> +
> +/*
> + * Tell the optimizer that something else uses this function or variable.
> + */
> +#define __visible __attribute__((externally_visible))
> +
> +/*
> + * 'asm goto' miscompilation is fixed in GCC 5.x version:
> + *
> + *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
> + */
> +#define asm_volatile_goto(x...)    do { asm goto(x); } while (0)
> +
> +#ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
> +#define __HAVE_BUILTIN_BSWAP32__
> +#define __HAVE_BUILTIN_BSWAP64__
> +#define __HAVE_BUILTIN_BSWAP16__
> +#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
> +
> +#define KASAN_ABI_VERSION 4

Hello.

v2 of the patch where I made a copy of compiler-gcc6.h from compiler-gcc5.h.

Thanks,
Martin

--------------000806060100030701060405
Content-Type: text/x-patch;
 name="0002-compiler-gcc6-add-support-for-GCC-6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-compiler-gcc6-add-support-for-GCC-6.patch"

From 2163ba712ed9e2305d8f3fad704b201d70edd3d8 Mon Sep 17 00:00:00 2001
From: mliska <mliska@suse.cz>
Date: Wed, 15 Apr 2015 10:56:43 +0200
Subject: [PATCH 2/2] compiler/gcc6: add support for GCC 6

Because GCC trunk version has switched to GCC 6.x, new header file is needed.

Signed-off-by: Martin Liska  <mliska@suse.cz>
---
 include/linux/compiler-gcc6.h | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 include/linux/compiler-gcc6.h

diff --git a/include/linux/compiler-gcc6.h b/include/linux/compiler-gcc6.h
new file mode 100644
index 0000000..ba064fa
--- /dev/null
+++ b/include/linux/compiler-gcc6.h
@@ -0,0 +1,59 @@
+#ifndef __LINUX_COMPILER_H
+#error "Please don't include <linux/compiler-gcc6.h> directly, include <linux/compiler.h> instead."
+#endif
+
+#define __used				__attribute__((__used__))
+#define __must_check			__attribute__((warn_unused_result))
+#define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
+
+/* Mark functions as cold. gcc will assume any path leading to a call
+   to them will be unlikely.  This means a lot of manual unlikely()s
+   are unnecessary now for any paths leading to the usual suspects
+   like BUG(), printk(), panic() etc. [but let's keep them for now for
+   older compilers]
+
+   gcc also has a __attribute__((__hot__)) to move hot functions into
+   a special section, but I don't see any sense in this right now in
+   the kernel context */
+#define __cold			__attribute__((__cold__))
+
+#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
+
+#ifndef __CHECKER__
+# define __compiletime_warning(message) __attribute__((warning(message)))
+# define __compiletime_error(message) __attribute__((error(message)))
+#endif /* __CHECKER__ */
+
+/*
+ * Mark a position in code as unreachable.  This can be used to
+ * suppress control flow warnings after asm blocks that transfer
+ * control elsewhere.
+ */
+#define unreachable() __builtin_unreachable()
+
+/* Mark a function definition as prohibited from being cloned. */
+#define __noclone	__attribute__((__noclone__))
+
+/*
+ * Tell the optimizer that something else uses this function or variable.
+ */
+#define __visible __attribute__((externally_visible))
+
+/*
+ * GCC 'asm goto' miscompiles certain code sequences:
+ *
+ *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
+ *
+ * Work it around via a compiler barrier quirk suggested by Jakub Jelinek.
+ *
+ * (asm goto is automatically volatile - the naming reflects this.)
+ */
+#define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
+
+#ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
+#define __HAVE_BUILTIN_BSWAP32__
+#define __HAVE_BUILTIN_BSWAP64__
+#define __HAVE_BUILTIN_BSWAP16__
+#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
+
+#define KASAN_ABI_VERSION 4
-- 
2.1.4


--------------000806060100030701060405--

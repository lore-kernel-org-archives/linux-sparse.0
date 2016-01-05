From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] Do not drop 'nocast' modifier when taking the address.
Date: Tue, 5 Jan 2016 17:25:53 +0100
Message-ID: <20160105162552.GA3478@macpro.local>
References: <201509182109.6ccgXDVp%fengguang.wu@intel.com>
 <55FC16F4.7060407@openvz.org>
 <55FC17B4.9060702@redhat.com>
 <20150918144026.GJ3317@rkaganb.sw.ru>
 <55FC22B4.9010301@redhat.com>
 <20150918150644.GB20668@wfg-t540p.sh.intel.com>
 <20160105135156.GB1044@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38788 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbcAEQZ6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Jan 2016 11:25:58 -0500
Received: by mail-wm0-f53.google.com with SMTP id b14so37096304wmb.1
        for <linux-sparse@vger.kernel.org>; Tue, 05 Jan 2016 08:25:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160105135156.GB1044@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

With the following code:
	typedef unsigned long __nocast cputime_t;

	void task_cputime_adjusted(cputime_t *);

	void current_task_runtime_100ns(void)
	{
	        cputime_t utime;

	        task_cputime_adjusted(&utime);
	}

sparse emits the following message:
	x.c:16:32: warning: incorrect type in argument 1 (different modifiers)
	x.c:16:32:    expected unsigned long [nocast] [usertype] *<noident>
	x.c:16:32:    got unsigned long *<noident>
	x.c:16:32: warning: implicit cast to nocast type

In other words, when taking the address of 'utime', sparse drops the 'nocast'
modifier and then complains that task_cputime_adjusted() is not given a
'nocast' pointer as expected ...

This feels wrong to me.

The proposed fix is to simply not dropping the 'nocast' modifier when
taking the address, like done for a normal type qualifier.
This gives very reasonable behaviour for all the test cases I could
think of:
	- taking the address or dereferencing doesn't drop the nocast
	- arithmetic operations on nocast give a nocast result.
	- implicit to/from cast is OK only if the base type are the same
	- implicit to/from pointer cast is OK only if the base type are the same

This still gives a "leaky" semantic: the nocast modifier can be lost via
an implicit cast to a non-qualified value.

Explicit cast to or from nocast values doesn't give any warning, maybe
it's OK, maybe it's not but it's orthogonal to the current issue.

Is this the wanted semantic for the nocast modifier?

Reported-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h            |   2 +-
 validation/nocast.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 validation/nocast.c

diff --git a/symbol.h b/symbol.h
index ccb5dcb9..9b3f1604 100644
--- a/symbol.h
+++ b/symbol.h
@@ -247,7 +247,7 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG_ALL)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
-#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE | MOD_NORETURN)
+#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE | MOD_NORETURN | MOD_NOCAST)
 
 
 /* Current parsing/evaluation function */
diff --git a/validation/nocast.c b/validation/nocast.c
new file mode 100644
index 00000000..c28676a3
--- /dev/null
+++ b/validation/nocast.c
@@ -0,0 +1,197 @@
+#define	__nocast	__attribute__((nocast))
+typedef unsigned long __nocast ulong_nc_t;
+
+extern void use_val(ulong_nc_t);
+extern void use_ptr(ulong_nc_t *);
+
+/* use address */
+static void good_use_address(void)
+{
+	ulong_nc_t t;
+
+	use_ptr(&t);
+}
+
+static ulong_nc_t *good_ret_address(void)
+{
+	static ulong_nc_t t;
+
+	return &t;
+}
+
+static ulong_nc_t good_deref(ulong_nc_t *t)
+{
+	return *t;
+}
+
+/* assign value */
+static ulong_nc_t t;
+static ulong_nc_t good_assign_self = t;
+static unsigned long good_assign_sametype = t;
+
+/* assign pointer */
+static ulong_nc_t *good_ptr = &t;
+static ulong_nc_t *bad_ptr_to = 1UL;
+static unsigned long *bad_ptr_from = &t;
+
+/* arithmetic operation */
+static ulong_nc_t good_arith(ulong_nc_t t, unsigned int n)
+{
+	return t + n;
+}
+
+/* implicit cast to other types */
+static unsigned long good_ret_samecast(ulong_nc_t t)
+{
+	return t;
+}
+static unsigned long long bad_ret_biggercast(ulong_nc_t t)
+{
+	return t;
+}
+static long bad_ret_signcast(ulong_nc_t t)
+{
+	return t;
+}
+static short bad_ret_smallercast(ulong_nc_t t)
+{
+	return t;
+}
+
+static void assign_val(ulong_nc_t t)
+{
+	ulong_nc_t good_c = t;
+	unsigned long good_ul = t;
+	unsigned long long bad_ull = t;
+	long bad_l = t;
+	short bad_i = t;
+}
+
+static void assign_via_ptr(ulong_nc_t *t)
+{
+	ulong_nc_t good_c = *t;
+	unsigned long good_ul = *t;
+	unsigned long long bad_ull = *t;
+	long bad_l = *t;
+	short bad_i = *t;
+}
+
+static void assign_ptr(ulong_nc_t *t)
+{
+	ulong_nc_t *good_same_type = t;
+	unsigned long *bad_mod = t;
+	unsigned long long __nocast *bad_size = t;
+	short __nocast *bad_i = t;
+	long __nocast *bad_l = t;
+}
+
+/* implicit cast to nocast */
+static void implicit_assign_to(void)
+{
+	ulong_nc_t t;
+	unsigned long ul = 1;
+	unsigned short us = 1;
+	unsigned long long ull = 1;
+	long l = 1;
+
+	t = ul;		/* implicit to nocast from same type: OK? */
+	t = us;
+	t = ull;
+	t = l;
+}
+
+static void bad_implicit_arg_to(void)
+{
+	unsigned long ul = 1;
+	unsigned short us = 1;
+	unsigned long long ull = 1;
+	long l = 1;
+
+	use_val(ul);	/* implicit to nocast from same type: OK? */
+	use_val(us);
+	use_val(ull);
+	use_val(l);
+}
+
+/* implicit cast from nocast */
+static unsigned long good_implicit_ret_ul(ulong_nc_t t)
+{
+	return t;	/* implicit to nocast from same type: OK? */
+}
+
+static unsigned short bad_implicit_ret_us(ulong_nc_t t)
+{
+	return t;
+}
+
+static unsigned long long bad_implicit_ret_ull(ulong_nc_t t)
+{
+	return t;
+}
+
+static long bad_implicit_ret_l(ulong_nc_t t)
+{
+	return t;
+}
+
+/* FIXME: explicit cast: should we complain? */
+static ulong_nc_t good_samecast(ulong_nc_t v)
+{
+	return (ulong_nc_t) v;
+}
+
+static ulong_nc_t bad_tocast(unsigned long v)
+{
+	return (ulong_nc_t) v;
+}
+
+static unsigned long bad_fromcast(ulong_nc_t v)
+{
+	return (unsigned long) v;
+}
+
+/*
+ * check-name: nocast.c
+ *
+ * check-error-start
+nocast.c:34:33: warning: incorrect type in initializer (different base types)
+nocast.c:34:33:    expected unsigned long [nocast] [usertype] *static [toplevel] bad_ptr_to
+nocast.c:34:33:    got unsigned long
+nocast.c:34:33: warning: implicit cast to nocast type
+nocast.c:35:39: warning: incorrect type in initializer (different modifiers)
+nocast.c:35:39:    expected unsigned long *static [toplevel] bad_ptr_from
+nocast.c:35:39:    got unsigned long static [nocast] [toplevel] *<noident>
+nocast.c:35:39: warning: implicit cast from nocast type
+nocast.c:50:16: warning: implicit cast from nocast type
+nocast.c:54:16: warning: implicit cast from nocast type
+nocast.c:58:16: warning: implicit cast from nocast type
+nocast.c:65:38: warning: implicit cast from nocast type
+nocast.c:66:22: warning: implicit cast from nocast type
+nocast.c:67:23: warning: implicit cast from nocast type
+nocast.c:74:38: warning: implicit cast from nocast type
+nocast.c:75:22: warning: implicit cast from nocast type
+nocast.c:76:23: warning: implicit cast from nocast type
+nocast.c:82:34: warning: incorrect type in initializer (different modifiers)
+nocast.c:82:34:    expected unsigned long *bad_mod
+nocast.c:82:34:    got unsigned long [nocast] [usertype] *t
+nocast.c:82:34: warning: implicit cast from nocast type
+nocast.c:83:49: warning: incorrect type in initializer (different type sizes)
+nocast.c:83:49:    expected unsigned long long [nocast] *bad_size
+nocast.c:83:49:    got unsigned long [nocast] [usertype] *t
+nocast.c:83:49: warning: implicit cast to/from nocast type
+nocast.c:84:33: warning: incorrect type in initializer (different type sizes)
+nocast.c:84:33:    expected short [nocast] *bad_i
+nocast.c:84:33:    got unsigned long [nocast] [usertype] *t
+nocast.c:84:33: warning: implicit cast to/from nocast type
+nocast.c:85:32: warning: implicit cast to/from nocast type
+nocast.c:98:13: warning: implicit cast to nocast type
+nocast.c:99:13: warning: implicit cast to nocast type
+nocast.c:100:13: warning: implicit cast to nocast type
+nocast.c:111:17: warning: implicit cast to nocast type
+nocast.c:112:17: warning: implicit cast to nocast type
+nocast.c:113:17: warning: implicit cast to nocast type
+nocast.c:124:16: warning: implicit cast from nocast type
+nocast.c:129:16: warning: implicit cast from nocast type
+nocast.c:134:16: warning: implicit cast from nocast type
+ * check-error-end
+ */
-- 
2.6.4



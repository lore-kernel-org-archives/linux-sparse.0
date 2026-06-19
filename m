Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F092F8EA3
	for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2026 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852744; cv=none; b=RRUyKrGjVoQzQxit+NwiaLrusRBxQD4A0Iph2dEBOAzWRAg0k3dLXXxyWw58ULzTJq2kzRQHCw5EbVaD8AXLzlyyz/GuD8B5WEasvdwJMe/hbeSSz7ubHWGbkNu6HW+9ZvitcgEkPWgJx+XtyhAmpCiiDE8bveHMXMRvtffovBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852744; c=relaxed/simple;
	bh=dRFYV7fnqjsaPUesjflKFXMmTpIE4w8AUnTyKaDZ4hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HLZOcLzdHUHxynGaSuyIDfcfMbWgXxtgTPTbSM0s7/3QVJZG37vx3yutD3rLjEdOvssKob3Ok+N5reDtFaVE6Usn+m+fZK3lTPdCLSR1kjzEWYQQgxGK5VbhkmYGUTQf0l6CEOHEi58CPeLlh0ScD1lEj9nnE3JUUQmy5bicaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=klWmPGyO; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="klWmPGyO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=K/Hf7DHBXqBNPJel7/DNa2XMS9mLbqgfUbGop5Fdfqk=; b=klWmPGyOGlY4SsDI
	ZN8qgDVAAxUYwp5MEQ/qMVdEYRc/DCN13YEInfqJ2eJb8JUDrV9TNLYy8jC7YBdaOTlzp8aIpdsRY
	1odBppTywdDIHiCj5f0+pUsMPBFgTEGTBqoOmodAIu193W3EznJZ5wn25BdD7TPXt3X+u9uY16N4b
	DUhfJsCjGfR0cmEIIvsqwLKq38sGXf9TXc/uZ9iGwtH9Fbco4f4Pd8WsLP/vqTacEdRrVKwaIPSFa
	dNdXTFmhMmFtWxD69APkfFCLdhaCl95c6rQvkEhYwuMkVCNLVETGXe51Fv1W7FLXKD+xCKFhYnvbm
	kH9IXFahXl2jdNLXfg==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1waTIE-00HCaI-0z; Fri, 19 Jun 2026 08:05:34 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1waTID-0000000033q-2iK0;
	Fri, 19 Jun 2026 08:05:33 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC v4 4/4] tests: add varargs printf format tests
Date: Fri, 19 Jun 2026 08:05:32 +0100
Message-Id: <20260619070532.11664-5-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
References: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

Add some tests for the new printf format checking code.
Note, these do not all pass yet.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 validation/varargs-format-addrspace1.c |  36 ++++++++
 validation/varargs-format-bad.c        |  18 ++++
 validation/varargs-format-checking.c   |  21 +++++
 validation/varargs-format-position.c   |  32 +++++++
 validation/varargs-format-prefix.c     |  19 ++++
 validation/varargs-format-tests.c      |  82 +++++++++++++++++
 validation/varargs-type-formattest.c   | 117 +++++++++++++++++++++++++
 7 files changed, 325 insertions(+)
 create mode 100644 validation/varargs-format-addrspace1.c
 create mode 100644 validation/varargs-format-bad.c
 create mode 100644 validation/varargs-format-checking.c
 create mode 100644 validation/varargs-format-position.c
 create mode 100644 validation/varargs-format-prefix.c
 create mode 100644 validation/varargs-format-tests.c
 create mode 100644 validation/varargs-type-formattest.c

diff --git a/validation/varargs-format-addrspace1.c b/validation/varargs-format-addrspace1.c
new file mode 100644
index 00000000..3370ac67
--- /dev/null
+++ b/validation/varargs-format-addrspace1.c
@@ -0,0 +1,36 @@
+
+extern int variadic(char *msg, ...) __attribute__((format (printf, 1, 2)));
+extern int variadic2(char *msg, int , ...) __attribute__((format (printf, 1, 3)));
+extern int variadic3(int, char *msg,  ...) __attribute__((format (printf, 2, 3)));
+
+static void test(void) {
+	void __attribute__((noderef, address_space(1))) *a;
+	void *b;
+
+	variadic("%s\n", a);
+	variadic("%s\n", b);
+	variadic("%s %s\n", b, a);
+	variadic2("%s %s\n", 1, b, a);
+	variadic3(1, "%s %s\n", b, a);
+	variadic3(1, "%s %p\n", b, a);
+}
+
+/*
+ * check-name: variadic formatting test with address-space to %s
+ * check-command: sparse -Wformat $file
+ *
+ * check-error-start
+varargs-format-addrspace1.c:10:26: warning: incorrect type in argument 2 (different address spaces)
+varargs-format-addrspace1.c:10:26:    expected char const *
+varargs-format-addrspace1.c:10:26:    got void [noderef] <asn:1> *a
+varargs-format-addrspace1.c:12:32: warning: incorrect type in argument 3 (different address spaces)
+varargs-format-addrspace1.c:12:32:    expected char const *
+varargs-format-addrspace1.c:12:32:    got void [noderef] <asn:1> *a
+varargs-format-addrspace1.c:13:36: warning: incorrect type in argument 4 (different address spaces)
+varargs-format-addrspace1.c:13:36:    expected char const *
+varargs-format-addrspace1.c:13:36:    got void [noderef] <asn:1> *a
+varargs-format-addrspace1.c:14:36: warning: incorrect type in argument 4 (different address spaces)
+varargs-format-addrspace1.c:14:36:    expected char const *
+varargs-format-addrspace1.c:14:36:    got void [noderef] <asn:1> *a
+ * check-error-end
+ */
diff --git a/validation/varargs-format-bad.c b/validation/varargs-format-bad.c
new file mode 100644
index 00000000..82ae357c
--- /dev/null
+++ b/validation/varargs-format-bad.c
@@ -0,0 +1,18 @@
+
+extern int variadic(char *msg, ...) __attribute__((format (printf, 0, 0)));
+extern int variadic2(char *msg, int , ...) __attribute__((format (printf, 2, 2)));
+extern int variadic3(char *msg, int , ...) __attribute__((format (printf, 2, 1)));
+
+static void test(void) {
+}
+
+/*
+ * check-name: variadic formatting test with bad formatting parameters
+ * check-command: sparse -Wformat $file
+ *
+ * check-error-start
+varargs-format-bad.c:2:73: warning: bad format positions
+varargs-format-bad.c:3:80: warning: bad format positions
+varargs-format-bad.c:4:80: warning: format cannot be after va_args
+* check-error-end
+ */
diff --git a/validation/varargs-format-checking.c b/validation/varargs-format-checking.c
new file mode 100644
index 00000000..9f3e5ac2
--- /dev/null
+++ b/validation/varargs-format-checking.c
@@ -0,0 +1,21 @@
+
+extern void pf(char *msg, ...) __attribute__((format (printf, 1, 2)));
+
+static void test(void) {
+	pf("%u %lu %llu\n", 1U, 1UL, 1ULL);
+	pf("%d %ld %lld\n", 1, 1L, 1LL);
+	pf("%x %lx %llx\n", 1U, 1UL, 1ULL);
+	pf("%d %ld %lld\n", 1, 1L, 1L);
+}
+
+/*
+ * check-name: variadic formatting test type checking
+ * check-command: sparse -Wformat $file
+ * check-known-to-fail
+ *
+ * check-error-start
+varargs-format-checking.c:8:36: warning: incorrect type in argument 4 (different types)
+varargs-format-checking.c:8:36:    expected long long
+varargs-format-checking.c:8:36:    got long
+ * check-error-end
+ */
diff --git a/validation/varargs-format-position.c b/validation/varargs-format-position.c
new file mode 100644
index 00000000..88a4dbc2
--- /dev/null
+++ b/validation/varargs-format-position.c
@@ -0,0 +1,32 @@
+
+extern void pf(char *msg, ...) __attribute__((format (printf, 1, 2)));
+
+static void test(void) {
+	pf("%2$d %u\n", 1U, 1L);
+	pf("%3$d %2$u\n", 1U, 1);
+	pf("%1$d %2$d\n", 1L, 1);
+}
+
+/*
+ * check-name: variadic formatting test position checking
+ * check-command: sparse -Wformat $file
+ * check-known-to-fail
+ *
+ * check-error-start
+varargs-format-position.c:5:29: warning: incorrect type in argument 3 (different types)
+varargs-format-position.c:5:29:    expected int
+varargs-format-position.c:5:29:    got long
+varargs-format-position.c:5:12: warning: format 3: position: no position specified
+varargs-format-position.c:5:29: warning: incorrect type in argument 3 (different types)
+varargs-format-position.c:5:29:    expected unsigned int
+varargs-format-position.c:5:29:    got long
+varargs-format-position.c:6:12: warning: no argument at position '4'
+varargs-format-position.c:6:31: warning: incorrect type in argument 3 (different types)
+varargs-format-position.c:6:31:    expected unsigned int
+varargs-format-position.c:6:31:    got int
+varargs-format-position.c:7:27: warning: incorrect type in argument 2 (different types)
+varargs-format-position.c:7:27:    expected int
+varargs-format-position.c:7:27:    got long
+ * check-error-end
+ *
+ */
diff --git a/validation/varargs-format-prefix.c b/validation/varargs-format-prefix.c
new file mode 100644
index 00000000..8e2456e6
--- /dev/null
+++ b/validation/varargs-format-prefix.c
@@ -0,0 +1,19 @@
+
+extern int __attribute__((format (printf, 1, 2))) variadic(char *msg, ...);
+
+static int test(void) {
+	void __attribute__((noderef, address_space(1))) *a;
+
+	variadic("%s\n", a);
+}
+
+/*
+ * check-name: variadic formatting test prefix based __attribute__
+ * check-command: sparse -Wformat $file
+ *
+ * check-error-start
+varargs-format-prefix.c:7:26: warning: incorrect type in argument 2 (different address spaces)
+varargs-format-prefix.c:7:26:    expected char const *
+varargs-format-prefix.c:7:26:    got void [noderef] <asn:1> *a
+ * check-error-end
+ */
diff --git a/validation/varargs-format-tests.c b/validation/varargs-format-tests.c
new file mode 100644
index 00000000..9a5cb9cd
--- /dev/null
+++ b/validation/varargs-format-tests.c
@@ -0,0 +1,82 @@
+
+
+extern void pf(char *msg, ...) __attribute__((format (printf, 1, 2)));
+
+static int test(void)
+{
+	pf("%*d\n", 5, 10);		/* value 10, print width is 5 */
+	pf("%2$*1$d\n", 5, 10);		/* value 10, print width is 5 */
+	pf("%3$*2$d\n", 1, 5, 10);	/* ok, skipping the '1' */
+	pf("%3$-*2$d\n", 1, 5, 10);	/* ok, skipping the '1' */
+	pf("%3$*2$-d\n", 1, 5, 10);	/* bad, the "-" shouldn't be before the 'd' */
+	pf("%3$ *2$d\n", 1, 5, 10);	/* ok, skipping the '1' */
+	pf("%3$+*2$d\n", 1, 5, 10);	/* ok, skipping the '1' */
+	pf("%3$0+*2$d\n", 1, 5, 10);	/* ok, skipping the '1' */
+	pf("%3$+0*2$d\n", 1, 5, 10);	/* ok, skipping the '1' */
+	pf("%3$+#*2$d\n", 1, 5, 10);	/* ok, skipping the '1' */
+	pf("%3$+#*2$.5d\n", 1, 5, 10);	/* ok, skipping the '1' */
+
+	/* go with some precision as well as width strings */
+	pf("%2$+*1$.6d\n", 5, 10);	/* ok */
+	pf("%2$+*1$.*3$d\n", 5, 10, 6);	/* ok */
+	pf("%2$+*3$.*1$d\n", 6, 10, 5);	/* ok */
+	pf("%2$+*1$.*d\n", 5, 10, 6);	/* not ok */
+
+	pf("%s", "msg");
+	return 0;
+}
+
+static void test2(int x, int y, const void *p)
+{
+	pf("%02x%02x %8p\n", x, y, p);
+}
+
+static inline void fn(int x) { pf("%08x\n", x); }
+static void test3(int x)
+{
+	fn;
+	fn(x);
+}
+
+static void test4(int i, unsigned int u)
+{
+	pf("%d\n", i);
+	pf("%x\n", u);
+}
+
+extern void sf(char *fmt, ...) __attribute__((format (scanf, 1, 2)));
+
+static void test5(void)
+{
+	char str[32];
+	char *s;
+	void *ptr;
+	void * const cp;
+	unsigned int u;
+	int i;
+
+	sf("%s %p %i %u", str, &ptr, &i, &u);
+	sf("%p", &cp);
+}
+
+static void test6(const char *str, int width)
+{
+	pf("%*s", width, str);
+	pf("%2$*1$d", width, str);	/* equivalent to previous */
+	pf("%*s", str, width);
+}
+
+
+/*
+ * check-name: variadic formatting tests for width/precisions
+ * check-command: sparse -Wformat $file
+ *
+ * check-error-start
+varargs-format-tests.c:11:12: warning: cannot evaluate type '%3$*2$-d'
+varargs-format-tests.c:11:12: warning: cannot evaluate format string
+varargs-format-tests.c:22:12: warning: format 3: position: no position specified
+varargs-format-tests.c:59:13: warning: incorrect type in argument 2 (different modifiers)
+varargs-format-tests.c:59:13:    expected void **
+varargs-format-tests.c:59:13:    got void *const *
+ * check-error-end
+ */
diff --git a/validation/varargs-type-formattest.c b/validation/varargs-type-formattest.c
new file mode 100644
index 00000000..f01c6d89
--- /dev/null
+++ b/validation/varargs-type-formattest.c
@@ -0,0 +1,117 @@
+
+extern void pf1(char *msg, ...) __attribute__((format (printf, 1, 2)));
+extern void pf2(int m, char *msg, ...) __attribute__((format (printf, 2, 3)));
+
+/* run all the tests with both of these printf formatted types */
+#define pf(x...) do { pf1(x); pf2(1, x); } while(0);
+
+static void test(void) {
+	/* first two are valid */
+	pf("%*d", 5, 10);	/* value 10, print width is 5 */
+	pf("%2$*1$d", 5, 10);	/* value 10, print width is 5 */
+	pf("%2$*3$d", 5, 10);	/* value 10, print width is ?? */
+
+	pf("%*d", 5, 10);	/* value 10, print width is 5 */
+	pf("%*d", 5, 10L);	/* value 10, print width is 5 (bad type) */
+	pf("%*d", 5UL, 10L);	/* value 10, print width is 5 (bad type) */
+
+	pf("%3$*2$d", 1, 5, 10);	/* ok, skipping the '1' */
+	pf("%3$*2$d", 1, 5, 10L);	/* bad print type */
+	pf("%2$*3$d", 1UL, 10, 5);	/* ok, try with swapping width/val */
+	pf("%2$*3$d", 1UL, 10L, 5);	/* bad, try with swapping width/val */
+
+	/* and now try with precision specifiers */
+
+	pf("%*.6d", 5, 10);	/* value 10, print width is 5 */
+	pf("%*.6d", 5, 10L);	/* value 10, print width is 5 (bad type) */
+	pf("%*.6d", 5UL, 10L);	/* value 10, print width is 5 (bad type) */
+
+	pf("%*.*d", 5, 6, 10);	/* value 10, print width is 5 */
+	pf("%*.*d", 5, 6, 10L);	/* value 10, print width is 5 (bad type) */
+	pf("%*.*d", 5UL, 6, 10L); /* value 10, print width is 5 (bad type) */
+	pf("%*.*d", 5, 6UL, 10); /* value 10, print width is 5 (bad type) */
+}
+
+/*
+ * check-name: variadic formatting test position checking types
+ * check-command: sparse -Wformat $file
+ * check-known-to-fail
+ *
+ * check-error-start
+varargs-type-formattest.c:12:9: warning: width: no argument at position 4
+varargs-type-formattest.c:12:9: warning: width: no argument at position 5
+varargs-type-formattest.c:15:9: warning: incorrect type in argument 3 (different types)
+varargs-type-formattest.c:15:9:    expected int
+varargs-type-formattest.c:15:9:    got long
+varargs-type-formattest.c:15:9: warning: incorrect type in argument 4 (different types)
+varargs-type-formattest.c:15:9:    expected int
+varargs-type-formattest.c:15:9:    got long
+varargs-type-formattest.c:16:9: warning: incorrect type for width argument 2
+varargs-type-formattest.c:16:9:    expected int
+varargs-type-formattest.c:16:9:    got unsigned long
+varargs-type-formattest.c:16:9: warning: incorrect type in argument 3 (different types)
+varargs-type-formattest.c:16:9:    expected int
+varargs-type-formattest.c:16:9:    got long
+varargs-type-formattest.c:16:9: warning: incorrect type for width argument 3
+varargs-type-formattest.c:16:9:    expected int
+varargs-type-formattest.c:16:9:    got unsigned long
+varargs-type-formattest.c:16:9: warning: incorrect type in argument 4 (different types)
+varargs-type-formattest.c:16:9:    expected int
+varargs-type-formattest.c:16:9:    got long
+varargs-type-formattest.c:19:9: warning: incorrect type in argument 4 (different types)
+varargs-type-formattest.c:19:9:    expected int
+varargs-type-formattest.c:19:9:    got long
+varargs-type-formattest.c:19:9: warning: incorrect type in argument 5 (different types)
+varargs-type-formattest.c:19:9:    expected int
+varargs-type-formattest.c:19:9:    got long
+varargs-type-formattest.c:21:9: warning: incorrect type in argument 3 (different types)
+varargs-type-formattest.c:21:9:    expected int
+varargs-type-formattest.c:21:9:    got long
+varargs-type-formattest.c:21:9: warning: incorrect type in argument 4 (different types)
+varargs-type-formattest.c:21:9:    expected int
+varargs-type-formattest.c:21:9:    got long
+varargs-type-formattest.c:26:9: warning: incorrect type in argument 3 (different types)
+varargs-type-formattest.c:26:9:    expected int
+varargs-type-formattest.c:26:9:    got long
+varargs-type-formattest.c:26:9: warning: incorrect type in argument 4 (different types)
+varargs-type-formattest.c:26:9:    expected int
+varargs-type-formattest.c:26:9:    got long
+varargs-type-formattest.c:27:9: warning: incorrect type for width argument 2
+varargs-type-formattest.c:27:9:    expected int
+varargs-type-formattest.c:27:9:    got unsigned long
+varargs-type-formattest.c:27:9: warning: incorrect type in argument 3 (different types)
+varargs-type-formattest.c:27:9:    expected int
+varargs-type-formattest.c:27:9:    got long
+varargs-type-formattest.c:27:9: warning: incorrect type for width argument 3
+varargs-type-formattest.c:27:9:    expected int
+varargs-type-formattest.c:27:9:    got unsigned long
+varargs-type-formattest.c:27:9: warning: incorrect type in argument 4 (different types)
+varargs-type-formattest.c:27:9:    expected int
+varargs-type-formattest.c:27:9:    got long
+varargs-type-formattest.c:30:9: warning: incorrect type in argument 4 (different types)
+varargs-type-formattest.c:30:9:    expected int
+varargs-type-formattest.c:30:9:    got long
+varargs-type-formattest.c:30:9: warning: incorrect type in argument 5 (different types)
+varargs-type-formattest.c:30:9:    expected int
+varargs-type-formattest.c:30:9:    got long
+varargs-type-formattest.c:31:9: warning: incorrect type for width argument 2
+varargs-type-formattest.c:31:9:    expected int
+varargs-type-formattest.c:31:9:    got unsigned long
+varargs-type-formattest.c:31:9: warning: incorrect type in argument 4 (different types)
+varargs-type-formattest.c:31:9:    expected int
+varargs-type-formattest.c:31:9:    got long
+varargs-type-formattest.c:31:9: warning: incorrect type for width argument 3
+varargs-type-formattest.c:31:9:    expected int
+varargs-type-formattest.c:31:9:    got unsigned long
+varargs-type-formattest.c:31:9: warning: incorrect type in argument 5 (different types)
+varargs-type-formattest.c:31:9:    expected int
+varargs-type-formattest.c:31:9:    got long
+varargs-type-formattest.c:32:9: warning: incorrect type for position argument 3
+varargs-type-formattest.c:32:9:    expected int
+varargs-type-formattest.c:32:9:    got unsigned long
+varargs-type-formattest.c:32:9: warning: incorrect type for position argument 4
+varargs-type-formattest.c:32:9:    expected int
+varargs-type-formattest.c:32:9:    got unsigned long
+ * check-error-end
+ *
+ */
-- 
2.37.2.352.g3c44437643


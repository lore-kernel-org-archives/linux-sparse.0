From: Randy Dunlap <rdunlap@infradead.org>
Subject: sparse patch v2: add noclone as an ignored attribute
Date: Thu, 21 Feb 2013 16:20:49 -0800
Message-ID: <5126B9E1.1070007@infradead.org>
References: <51184E28.40909@infradead.org> <CANeU7Qk+5RMN--w_BQpUoX5yh_fkdfme7AxVpm3HXVyZX_inJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:48669 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758729Ab3BVAUM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 21 Feb 2013 19:20:12 -0500
In-Reply-To: <CANeU7Qk+5RMN--w_BQpUoX5yh_fkdfme7AxVpm3HXVyZX_inJQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add attribute "noclone" or "__noclone" or "__noclone__" as an
ignored attribute. Fixes this sparse warning:

arch/x86/kvm/vmx.c:6268:13: error: attribute '__noclone__': unknown attribute

Also add test case for 'noclone': validation/attr-noclone.c.
'make check' says for this test case:
     TEST     attribute noclone (attr-noclone.c)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 parse.c                   |    3 +++
 validation/attr-noclone.c |    9 +++++++++
 2 files changed, 12 insertions(+)

--- sparse-2013-0210.orig/parse.c
+++ sparse-2013-0210/parse.c
@@ -541,6 +541,9 @@ const char *ignored_attributes[] = {
 	"__naked__",
 	"no_instrument_function",
 	"__no_instrument_function__",
+	"noclone",
+	"__noclone",
+	"__noclone__",
 	"noinline",
 	"__noinline__",
 	"nonnull",
--- /dev/null
+++ sparse-2013-0210/validation/attr-noclone.c
@@ -0,0 +1,9 @@
+#define noclone		__attribute__((__noclone__))
+
+static void noclone bar(void)
+{
+}
+
+/*
+ * check-name: attribute noclone
+ */

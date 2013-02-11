From: Randy Dunlap <rdunlap@infradead.org>
Subject: sparse: add noclone as an ignored attribute
Date: Sun, 10 Feb 2013 17:49:28 -0800
Message-ID: <51184E28.40909@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:55647
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751903Ab3BKBsg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 10 Feb 2013 20:48:36 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Randy Dunlap <rdunlap@infradead.org>

Add attribute "noclone" or "__noclone" or "__noclone__" as an
ignored attribute. Fixes this sparse warning:

arch/x86/kvm/vmx.c:6268:13: error: attribute '__noclone__': unknown attribute

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 parse.c |    3 +++
 1 file changed, 3 insertions(+)

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

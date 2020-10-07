Return-Path: <SRS0=ZUDq=DO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E95C4363C
	for <linux-sparse@archiver.kernel.org>; Wed,  7 Oct 2020 11:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEE220782
	for <linux-sparse@archiver.kernel.org>; Wed,  7 Oct 2020 11:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgJGL6a (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 7 Oct 2020 07:58:30 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35932 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgJGL61 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Oct 2020 07:58:27 -0400
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 430953B6580
        for <linux-sparse@vger.kernel.org>; Wed,  7 Oct 2020 11:53:03 +0000 (UTC)
X-Originating-IP: 78.45.89.65
Received: from im-t490s.redhat.com (ip-78-45-89-65.net.upcbroadband.cz [78.45.89.65])
        (Authenticated sender: i.maximets@ovn.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E10634000E;
        Wed,  7 Oct 2020 11:52:40 +0000 (UTC)
From:   Ilya Maximets <i.maximets@ovn.org>
To:     linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     ovs-dev@openvswitch.org, Ian Stokes <ian.stokes@intel.com>,
        Aaron Conole <aconole@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH] flex-array: allow arrays of unions with flexible members.
Date:   Wed,  7 Oct 2020 13:52:34 +0200
Message-Id: <20201007115234.1482603-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

There is a common pattern on how to allocate memory for a flexible-size
structure, e.g.

  union {
      struct flex f;  /* Structure that contains a flexible array. */
      char buf[MAX_SIZE];  /* Memeory buffer for structure 'flex' and
                              its flexible array. */
  };

There is another exmaple of such thing in CMSG manpage with the
alignment purposes:

  union {         /* Ancillary data buffer, wrapped in a union
                     in order to ensure it is suitably aligned */
      char buf[CMSG_SPACE(sizeof(myfds))];
      struct cmsghdr align;
  } u;

Such unions could form an array in case user wants multiple
instances of them.  For example, if you want receive up to
32 network packets via recvmmsg(), you will need 32 unions like 'u'.
Open vSwitch does exactly that and fails the check.

Disabling this check by default for unions.  Adding new option
-Wflex-union-array to enable it back.  This option works only
if -Wflex-array-array enabled (which is default behavior).

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Not sure if this is a best way to fix the issue, but it works fine for
openvswitch project.  The actual code in question that makes sparse fail
OVS build could be found here:
  https://github.com/openvswitch/ovs/blob/39fbd2c3f0392811689ec780f09baf90faceb877/lib/netdev-linux.c#L1238

 options.c                         |  2 ++
 options.h                         |  1 +
 sparse.1                          |  7 +++++++
 symbol.c                          |  3 ++-
 symbol.h                          |  7 +++++++
 validation/flex-union-array-no.c  |  9 +++++++++
 validation/flex-union-array-yes.c | 11 +++++++++++
 validation/flex-union-array.h     | 11 +++++++++++
 8 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 validation/flex-union-array-no.c
 create mode 100644 validation/flex-union-array-yes.c
 create mode 100644 validation/flex-union-array.h

diff --git a/options.c b/options.c
index b46900b9..cb935832 100644
--- a/options.c
+++ b/options.c
@@ -103,6 +103,7 @@ int Wexternal_function_has_definition = 1;
 int Wflexible_array_array = 1;
 int Wflexible_array_nested = 0;
 int Wflexible_array_sizeof = 0;
+int Wflexible_union_array = 0;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
@@ -846,6 +847,7 @@ static const struct flag warnings[] = {
 	{ "flexible-array-array", &Wflexible_array_array },
 	{ "flexible-array-nested", &Wflexible_array_nested },
 	{ "flexible-array-sizeof", &Wflexible_array_sizeof },
+	{ "flexible-union-array", &Wflexible_union_array },
 	{ "implicit-int", &Wimplicit_int },
 	{ "init-cstring", &Winit_cstring },
 	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
diff --git a/options.h b/options.h
index d23ed472..a20c9f61 100644
--- a/options.h
+++ b/options.h
@@ -102,6 +102,7 @@ extern int Wexternal_function_has_definition;
 extern int Wflexible_array_array;
 extern int Wflexible_array_nested;
 extern int Wflexible_array_sizeof;
+extern int Wflexible_union_array;
 extern int Wimplicit_int;
 extern int Winit_cstring;
 extern int Wint_to_pointer_cast;
diff --git a/sparse.1 b/sparse.1
index 9b1a59c6..ac45b67c 100644
--- a/sparse.1
+++ b/sparse.1
@@ -278,6 +278,13 @@ possibly recursively.
 Sparse does not issue these warnings by default.
 .
 .TP
+.B -Wflexible-union-array
+Warn about arrays of unions containing a flexible array.
+
+Sparse does not issue these warnings by default.
+To turn them on, \fB-Wflexible-array-array\fR should be enabled too.
+.
+.TP
 .B \-Winit\-cstring
 Warn about initialization of a char array with a too long constant C string.
 
diff --git a/symbol.c b/symbol.c
index 97c2e35d..7ad7351b 100644
--- a/symbol.c
+++ b/symbol.c
@@ -271,7 +271,8 @@ static struct symbol * examine_array_type(struct symbol *sym)
 			bit_size = -1;
 		}
 	}
-	if (has_flexible_array(base_type) && Wflexible_array_array)
+	if (has_flexible_array(base_type) && Wflexible_array_array &&
+	    (!is_union_type(base_type) || Wflexible_union_array))
 		warning(sym->pos, "array of flexible structures");
 	alignment = base_type->ctype.alignment;
 	if (!sym->ctype.alignment)
diff --git a/symbol.h b/symbol.h
index e1f53926..b208ce87 100644
--- a/symbol.h
+++ b/symbol.h
@@ -425,6 +425,13 @@ static inline int is_array_type(struct symbol *type)
 	return type->type == SYM_ARRAY;
 }
 
+static inline int is_union_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return type->type == SYM_UNION;
+}
+
 static inline int is_float_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
diff --git a/validation/flex-union-array-no.c b/validation/flex-union-array-no.c
new file mode 100644
index 00000000..d370971c
--- /dev/null
+++ b/validation/flex-union-array-no.c
@@ -0,0 +1,9 @@
+#include "flex-union-array.h"
+
+/*
+ * check-name: flex-union-array-no
+ * check-command: sparse -Wflexible-array-array -Wno-flexible-union-array $file
+ *
+ * check-error-start
+ * check-error-end
+ */
diff --git a/validation/flex-union-array-yes.c b/validation/flex-union-array-yes.c
new file mode 100644
index 00000000..4c594386
--- /dev/null
+++ b/validation/flex-union-array-yes.c
@@ -0,0 +1,11 @@
+#include "flex-union-array.h"
+
+/*
+ * check-name: flex-union-array-yes
+ * check-command: sparse -Wflexible-array-array -Wflexible-union-array $file
+ *
+ * check-error-start
+flex-union-array-yes.c: note: in included file:
+flex-union-array.h:11:17: warning: array of flexible structures
+ * check-error-end
+ */
diff --git a/validation/flex-union-array.h b/validation/flex-union-array.h
new file mode 100644
index 00000000..b2a74d1a
--- /dev/null
+++ b/validation/flex-union-array.h
@@ -0,0 +1,11 @@
+struct s_flex {
+	int i;
+	long f[];
+};
+
+union s {
+	struct s_flex flex;
+	char buf[200];
+};
+
+static union s a[2];
-- 
2.25.4


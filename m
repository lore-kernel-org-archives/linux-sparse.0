From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH 2/3 RESEND] Add -Wno-enum-mismatch
Date: Tue, 29 Aug 2006 18:17:24 -0700
Message-ID: <1156900644.5203.12.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:17069 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932285AbWH3BRS
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Aug 2006 21:17:18 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7U1HHNg027344
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 21:17:17 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7U1HH6e356746
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 19:17:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7U1HHYb020076
	for <linux-sparse@vger.kernel.org>; Tue, 29 Aug 2006 19:17:17 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

Add the ability to turn off enum type mismatch warnings using
-Wno-enum-mismatch, helpful when attempting to track down a particular class
of warnings only without losing them amongst others.  Enum type mismatch
checking defaults to on, so this does not change the default behavior of
sparse.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 evaluate.c |    2 ++
 lib.c      |    2 ++
 lib.h      |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index c5d2526..177797a 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -243,6 +243,8 @@ warn_for_different_enum_types (struct po
 			       struct symbol *typea,
 			       struct symbol *typeb)
 {
+	if (!Wenum_mismatch)
+		return;
 	if (typea->type == SYM_NODE)
 		typea = typea->ctype.base_type;
 	if (typeb->type == SYM_NODE)
diff --git a/lib.c b/lib.c
index 61c35b3..8fac8ae 100644
--- a/lib.c
+++ b/lib.c
@@ -179,6 +179,7 @@ int Wdecl = 0;
 int Wtransparent_union = 1;
 int Wshadow = 0;
 int Waddress_space = 1;
+int Wenum_mismatch = 1;
 int preprocess_only;
 char *include;
 int include_fd = -1;
@@ -325,6 +326,7 @@ static const struct warning {
 	{ "transparent-union", &Wtransparent_union },
 	{ "shadow", &Wshadow },
 	{ "address-space", &Waddress_space },
+	{ "enum-mismatch", &Wenum_mismatch },
 };
 

diff --git a/lib.h b/lib.h
index 24dd38f..0b45c67 100644
--- a/lib.h
+++ b/lib.h
@@ -79,6 +79,7 @@ extern int Wbitwise, Wtypesign, Wcontext
 extern int Wtransparent_union;
 extern int Waddress_space;
 extern int Wcast_to_address_space;
+extern int Wenum_mismatch;
 extern int Wdecl;
 extern int Wone_bit_signed_bitfield;
 extern int Wshadow;
-- 
1.4.1.1

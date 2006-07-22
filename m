From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Add -Wno-enum-mismatch
Date: Fri, 21 Jul 2006 19:35:25 -0700
Message-ID: <1153535725.1797.5.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58557 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751267AbWGVCf0
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 21 Jul 2006 22:35:26 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6M2ZNbK005692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2006 22:35:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6M2ZNiJ267492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2006 20:35:23 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6M2ZN35032191
	for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2006 20:35:23 -0600
Received: from IBM-882E9B45D97.beaverton.ibm.com (IBM-882E9B45D97.beaverton.ibm.com [9.47.18.143])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6M2ZMVv032188
	for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2006 20:35:23 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
index 84d0647..d92418a 100644
--- a/lib.c
+++ b/lib.c
@@ -178,6 +178,7 @@ int Wcast_to_address_space = 0;
 int Wdecl = 0;
 int Wtransparent_union = 1;
 int Waddress_space = 1;
+int Wenum_mismatch = 1;
 int preprocess_only;
 char *include;
 int include_fd = -1;
@@ -323,6 +324,7 @@ static const struct warning {
 	{ "context", &Wcontext },
 	{ "transparent-union", &Wtransparent_union },
 	{ "address-space", &Waddress_space },
+	{ "enum-mismatch", &Wenum_mismatch },
 };
 

diff --git a/lib.h b/lib.h
index e6b9bfa..5f67a12 100644
--- a/lib.h
+++ b/lib.h
@@ -79,6 +79,7 @@ extern int Wbitwise, Wtypesign, Wcontext
 extern int Wtransparent_union;
 extern int Waddress_space;
 extern int Wcast_to_address_space;
+extern int Wenum_mismatch;
 extern int Wdecl;
 extern int Wone_bit_signed_bitfield;
 

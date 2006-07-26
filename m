From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] Add -Wno-cast-truncate
Date: Wed, 26 Jul 2006 10:24:52 -0700
Message-ID: <1153934692.12517.46.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:33735 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030292AbWGZRYv
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 26 Jul 2006 13:24:51 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6QHOoEZ017745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 13:24:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k6QHOnBK168548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 11:24:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k6QHOnad019109
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 11:24:49 -0600
Received: from dyn9047018143.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k6QHOntd019086
	for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2006 11:24:49 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Add the ability to turn off checks for casts that truncate constant values
using -Wno-cast-truncate, helpful when attempting to track down a particular
class of warnings only without losing them amongst others.  Checks for
truncating casts default to on, so this does not change the default behavior
of sparse.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 expand.c |    4 ++++
 lib.c    |    2 ++
 lib.h    |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/expand.c b/expand.c
index 474344d..882d80e 100644
--- a/expand.c
+++ b/expand.c
@@ -94,6 +94,10 @@ Int:
 	mask = signmask | (signmask-1);
 	expr->value = value & mask;
 
+	// Stop here unless checking for truncation
+	if (!Wcast_truncate)
+		return;
+	
 	// Check if we dropped any bits..
 	oldsignmask = 1ULL << (old_size-1);
 	oldmask = oldsignmask | (oldsignmask-1);
diff --git a/lib.c b/lib.c
index d92418a..7a2e291 100644
--- a/lib.c
+++ b/lib.c
@@ -169,6 +169,7 @@ static char pre_buffer[8192];
 
 int Wdefault_bitfield_sign = 0;
 int Wone_bit_signed_bitfield = 1;
+int Wcast_truncate = 1;
 int Wbitwise = 0;
 int Wtypesign = 0;
 int Wcontext = 0;
@@ -316,6 +317,7 @@ static const struct warning {
 	{ "cast-to-as", &Wcast_to_address_space },
 	{ "decl", &Wdecl },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
+	{ "cast-truncate", &Wcast_truncate },
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
 	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
 	{ "undef", &Wundefined_preprocessor },
diff --git a/lib.h b/lib.h
index 5f67a12..b542cd6 100644
--- a/lib.h
+++ b/lib.h
@@ -82,6 +82,7 @@ extern int Wcast_to_address_space;
 extern int Wenum_mismatch;
 extern int Wdecl;
 extern int Wone_bit_signed_bitfield;
+extern int Wcast_truncate;
 
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);

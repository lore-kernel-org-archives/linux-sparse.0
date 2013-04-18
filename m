From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] Define __SIZEOF_POINTER__
Date: Thu, 18 Apr 2013 12:14:30 -0700
Message-ID: <20130418191428.GA19319@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50156 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab3DRTOg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Apr 2013 15:14:36 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

GCC defines a macro __SIZEOF_POINTER__ to the size of a pointer in
bytes.  Define it in sparse as well.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 cgcc  |   15 ++++++++++-----
 lib.c |    1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/cgcc b/cgcc
index 6636cc6..c075e5f 100755
--- a/cgcc
+++ b/cgcc
@@ -240,27 +240,32 @@ sub add_specs {
 	return (' -Di386=1 -D__i386=1 -D__i386__=1' .
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
 		&float_types (1, 1, 21, [24,8], [53,11], [64,15]) .
-		&define_size_t ($m64 ? "long unsigned int" : "unsigned int"));
+		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
+		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 'sparc') {
 	return (' -Dsparc=1 -D__sparc=1 -D__sparc__=1' .
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
-		&define_size_t ($m64 ? "long unsigned int" : "unsigned int"));
+		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
+		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 'sparc64') {
 	return (' -Dsparc=1 -D__sparc=1 -D__sparc__=1 -D__sparcv9__=1 -D__sparc64__=1 -D__arch64__=1 -D__LP64__=1' .
 		&integer_types (8, 16, 32, 64, 64, 128) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
-		&define_size_t ("long unsigned int"));
+		&define_size_t ("long unsigned int") .
+		' -D__SIZEOF_POINTER__=8');
     } elsif ($spec eq 'x86_64') {
 	return (' -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1' . ($m32 ? '' : ' -D__LP64__=1') .
 		&integer_types (8, 16, 32, $m32 ? 32 : 64, 64, 128) .
 		&float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
-		&define_size_t ($m32 ? "unsigned int" : "long unsigned int"));
+		&define_size_t ($m32 ? "unsigned int" : "long unsigned int") .
+		' -D__SIZEOF_POINTER__=' . ($m32 ? '4' : '8'));
     } elsif ($spec eq 'ppc') {
 	return (' -D__powerpc__=1 -D_BIG_ENDIAN -D_STRING_ARCH_unaligned=1' .
 		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
 		&float_types (1, 1, 21, [24,8], [53,11], [113,15]) .
-		&define_size_t ($m64 ? "long unsigned int" : "unsigned int"));
+		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
+		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 'host_os_specs') {
 	my $os = `uname -s`;
 	chomp $os;
diff --git a/lib.c b/lib.c
index 4f69e11..98a5515 100644
--- a/lib.c
+++ b/lib.c
@@ -863,6 +863,7 @@ void create_builtin_stream(void)
 	add_pre_buffer("#weak_define __LONG_MAX__ " STRINGIFY(__LONG_MAX__) "\n");
 	add_pre_buffer("#weak_define __LONG_LONG_MAX__ " STRINGIFY(__LONG_LONG_MAX__) "\n");
 	add_pre_buffer("#weak_define __WCHAR_MAX__ " STRINGIFY(__WCHAR_MAX__) "\n");
+	add_pre_buffer("#weak_define __SIZEOF_POINTER__ " STRINGIFY(__SIZEOF_POINTER__) "\n");
 }
 
 static struct symbol_list *sparse_tokenstream(struct token *token)
-- 
1.7.10.4


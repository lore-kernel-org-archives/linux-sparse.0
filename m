From: Alexander Shishkin <alexander.shishckin@gmail.com>
Subject: [PATCH] don't call sparse when called to generate dependencies
Date: Tue, 26 Aug 2008 00:33:39 +0300
Message-ID: <1219700019-19627-1-git-send-email-alexander.shishckin@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:29873 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbYHYVdd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Aug 2008 17:33:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so823849nfc.21
        for <linux-sparse@vger.kernel.org>; Mon, 25 Aug 2008 14:33:31 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse development list <linux-sparse@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishckin@gmail.com>

I have a situation here when $(CC) is called with -M options with
slighly different set of -I/-D/etc arguments, which causes all sorts of
funny reports from sparse. Also, this increases the overall build time
because every compilation unit if sparsed twice.

Signed-off-by: Alexander Shishkin <alexander.shishckin@gmail.com>
---
 cgcc |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/cgcc b/cgcc
index 4fab530..89adbed 100755
--- a/cgcc
+++ b/cgcc
@@ -7,6 +7,7 @@ my $check = $ENV{'CHECK'} || 'sparse';
 my $m32 = 0;
 my $m64 = 0;
 my $has_specs = 0;
+my $gendeps = 0;
 my $do_check = 0;
 my $do_compile = 1;
 my $verbose = 0;
@@ -22,6 +23,7 @@ foreach (@ARGV) {
 
     $m32 = 1 if /^-m32$/;
     $m64 = 1 if /^-m64$/;
+    $gendeps = 1 if /^-M$/;
 
     if (/^-specs=(.*)$/) {
 	$check .= &add_specs ($1);
@@ -44,6 +46,11 @@ foreach (@ARGV) {
     $check .= $this_arg unless &cc_only_option ($_);
 }
 
+if ($gendeps) {
+    $do_compile = 1;
+    $do_check = 0;
+}
+
 if ($do_check) {
     if (!$has_specs) {
 	$check .= &add_specs ('host_arch_specs');
-- 
1.5.6.3


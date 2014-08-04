From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH/RFC 10/10] cgcc: add a configuration file for cgcc
Date: Mon, 04 Aug 2014 19:41:15 +0100
Message-ID: <53DFD3CB.8050607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:52922 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751071AbaHDSrP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:47:15 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


The configuration file, ~/.cgccrc, allows a user to use perl syntax
to set the $gcc_base_dir and $multiarch_dir variables, which would
then suppress two compiler invocations. This can result in a marked
performance boost on platforms for which the fork/exec costs are
high (e.g. cygwin).

For example, on a multiarch system the file might look like:

    $ cat ~/.cgccrc
    $gcc_base_dir = "/usr/lib/gcc/x86_64-linux-gnu/4.8/";
    $multiarch_dir = "x86_64-linux-gnu";
    $

whereas for a non-multiarch system (e.g. cygwin):

    $ cat ~/.cgccrc
    $gcc_base_dir = "/usr/lib/gcc/x86_64-pc-cygwin/4.8.3/";
    $multiarch_dir = "";
    $

For me, on linux the difference in performance measured between
3-4% (e.g. 17.053s -> 16.379s to run sparse over the git sources),
whereas on cygwin it measured about 20% (94.890s -> 76.207s).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 cgcc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/cgcc b/cgcc
index d7daa99..9d65438 100755
--- a/cgcc
+++ b/cgcc
@@ -11,10 +11,16 @@ my $has_specs = 0;
 my $gendeps = 0;
 my $do_check = 0;
 my $do_compile = 1;
-my $gcc_base_dir;
-my $multiarch_dir;
+our $gcc_base_dir;
+our $multiarch_dir;
 my $verbose = 0;
 
+my $cgccrc_file = $ENV{'HOME'}."/.cgccrc" if $ENV{'HOME'};
+if (-e $cgccrc_file) {
+    do $cgccrc_file;
+    die $@ if $@;
+}
+
 while (@ARGV) {
     $_ = shift(@ARGV);
     # Look for a .c file.  We don't want to run the checker on .o or .so files
-- 
2.0.0

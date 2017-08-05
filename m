From: Christopher Li <sparse@chrisli.org>
Subject: what is cooking in sparse-next-20170805
Date: Sat, 5 Aug 2017 08:42:12 -0400
Message-ID: <CANeU7Q=PetPO=LujGB9mk6RhzJz9aQivYNgx=_4Eht3XMrPFCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36361 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdHEMmN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 08:42:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id t83so4408662pfj.3
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 05:42:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Two new series from Luc has been applied.
- fix: give a type to bad conditionnal expressions
  I confirm the wine source file checking went from 23s to 3.x seconds.

- fix list corruption with recursive remove_usage()
   this replace 7d54acb0d6d4a9dff3c91688b0223cd4c4a6d6ea
   "Let pseudo->users loop on duplicate versin of list"

The kernel compile check shows that has output difference in 3 files
compare to rc4. I include the diff here. I will dig a bit more which change
cause it. It seems reasonable enough.  There is one context imbalance
warning was gone. My guess is that the conditional expression patch
make sparse understand the source code better now.

This should be very very close the RC5 release.

Go give it more test!

Chris




$ diff linux-checker/rc4 linux-checker/exp -ruN
diff -ruN linux-checker/rc4/arch/x86/platform/uv/uv_nmi.sp
linux-checker/exp/arch/x86/platform/uv/uv_nmi.sp
--- linux-checker/rc4/arch/x86/platform/uv/uv_nmi.sp 2017-08-05
05:07:52.176462385 -0700
+++ linux-checker/exp/arch/x86/platform/uv/uv_nmi.sp 2017-08-05
04:56:42.959747891 -0700
@@ -24,5 +24,5 @@
 ./arch/x86/include/asm/uv/uv_hub.h:678:41:    got unsigned long *
 arch/x86/platform/uv/uv_nmi.c:908:5: warning: symbol 'uv_handle_nmi'
was not declared. Should it be static?
 arch/x86/platform/uv/uv_nmi.c:1016:13: warning: symbol
'uv_nmi_setup_common' was not declared. Should it be static?
-arch/x86/platform/uv/uv_nmi.c:482:12: warning: context imbalance in
'uv_check_nmi' - different lock contexts for basic block
+arch/x86/platform/uv/uv_nmi.c:541:9: warning: context imbalance in
'uv_check_nmi' - different lock contexts for basic block
 arch/x86/platform/uv/uv_nmi.c:559:17: warning: context imbalance in
'uv_handle_nmi' - unexpected unlock
diff -ruN linux-checker/rc4/drivers/auxdisplay/panel.sp
linux-checker/exp/drivers/auxdisplay/panel.sp
--- linux-checker/rc4/drivers/auxdisplay/panel.sp 2017-08-05
05:07:54.558438024 -0700
+++ linux-checker/exp/drivers/auxdisplay/panel.sp 2017-08-05
04:56:45.285724297 -0700
@@ -1 +0,0 @@
-drivers/auxdisplay/panel.c:1402:17: warning: context imbalance in
'panel_scan_timer' - different lock contexts for basic block
diff -ruN linux-checker/rc4/drivers/net/ethernet/chelsio/cxgb3/sge.sp
linux-checker/exp/drivers/net/ethernet/chelsio/cxgb3/sge.sp
--- linux-checker/rc4/drivers/net/ethernet/chelsio/cxgb3/sge.sp
2017-08-05 05:08:45.045911820 -0700
+++ linux-checker/exp/drivers/net/ethernet/chelsio/cxgb3/sge.sp
2017-08-05 04:57:32.503081874 -0700
@@ -13,4 +13,3 @@
 drivers/net/ethernet/chelsio/cxgb3/sge.c:2371:47: warning: incorrect
type in assignment (different base types)
 drivers/net/ethernet/chelsio/cxgb3/sge.c:2371:47:    expected
unsigned int [unsigned] [usertype] priority
 drivers/net/ethernet/chelsio/cxgb3/sge.c:2371:47:    got restricted
__be32 [assigned] [usertype] rss_lo
-drivers/net/ethernet/chelsio/cxgb3/sge.c:2936:9: warning: context
imbalance in 'sge_timer_rx' - different lock contexts for basic block
diff -ruN linux-checker/rc4/drivers/staging/lustre/lustre/obdclass/lu_object.sp
linux-checker/exp/drivers/staging/lustre/lustre/obdclass/lu_object.sp
--- linux-checker/rc4/drivers/staging/lustre/lustre/obdclass/lu_object.sp
2017-08-05 05:09:19.649552223 -0700
+++ linux-checker/exp/drivers/staging/lustre/lustre/obdclass/lu_object.sp
2017-08-05 04:58:06.379516299 -0700
@@ -1,2 +1,2 @@
-drivers/staging/lustre/lustre/obdclass/lu_object.c:95:6: warning:
context imbalance in 'lu_object_put' - different lock contexts for
basic block
+drivers/staging/lustre/lustre/obdclass/lu_object.c:95:6: warning:
context imbalance in 'lu_object_put' - wrong count at exit
 drivers/staging/lustre/lustre/obdclass/lu_object.c:1727:54: warning:
context imbalance in 'lu_context_exit' - different lock contexts for
basic block

From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Thu, 17 Aug 2017 00:42:19 -0400
Message-ID: <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34442 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdHQEmV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:42:21 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so34564664ywg.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:42:21 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to implement and integrate to sparse
> the method described in the paper:
>     "Simple and Efficient Construction of Static Single Assignment Form"
>         by Matthias Braun, Sebastian Buchwald, Sebastian Hack,
>            Roland Leissa, Christoph Mallon and Andreas Zwinkau.
>     cfr. http://www.cdl.uni-saarland.de/papers/bbhlmz13cc.pdf
>
> In the present case, the principal motivation to use this method
> is that the current one in sparse is severely broken.
>
>
> The series is also available in the git repository at:
>
>   git://github.com/lucvoo/sparse.git sssa-mini-v1
>
> for you to fetch changes up to 98a21bc0c82af5115687c7e03a277519836bcac6:
>
>   sssa: remove now unneeded simplify_one_symbol() (2017-08-16 17:25:25 +0200)

Hi Luc,

Thank you so much for the patch.

Here is the kernel full allmodconfig running ssa-mini-v1 on my new
compile server. On the new server the timing is very consistent.
The variance of run to run is under 0.1 second.

ssa-mini-v1:
1205.82user 463.65system 1:16.97elapsed 2168%CPU (0avgtext+0avgdata
536216maxresident)k
0inputs+12824outputs (0major+132162996minor)pagefaults 0swaps
1206.35user 463.27system 1:16.95elapsed 2169%CPU (0avgtext+0avgdata
536296maxresident)k
0inputs+12824outputs (0major+132156314minor)pagefaults 0swaps


This is the rc5 as base line.
1173.42user 453.56system 1:15.21elapsed 2163%CPU (0avgtext+0avgdata
238072maxresident)k
0inputs+12784outputs (0major+128858147minor)pagefaults 0swaps
1172.86user 453.53system 1:15.14elapsed 2164%CPU (0avgtext+0avgdata
238076maxresident)k
0inputs+12784outputs (0major+128858804minor)pagefaults 0swaps

So the ssa-mini-v1 is about 2% slower than the current rc5.

I inline the sparse checking different here.
I will take a look at you patches next :-)

BTW, how do you want your patches to be merged? Assume there is
some feed back. Do you want to come up with V2 V3 or have them merged
to master then come up with fix up on master?

Thanks

Chris

diff -ruN linux-checker/rc5/drivers/base/firmware_class.sp
linux-checker/ssa/drivers/base/firmware_class.sp
--- linux-checker/rc5/drivers/base/firmware_class.sp 2017-08-17
00:27:32.065207474 -0400
+++ linux-checker/ssa/drivers/base/firmware_class.sp 2017-08-17
00:18:56.525833366 -0400
@@ -1 +1 @@
-drivers/base/firmware_class.c:395:9: warning: context imbalance in
'fw_free_buf' - wrong count at exit
+drivers/base/firmware_class.c:391:13: warning: context imbalance in
'fw_free_buf' - wrong count at exit
diff -ruN linux-checker/rc5/drivers/block/drbd/drbd_actlog.sp
linux-checker/ssa/drivers/block/drbd/drbd_actlog.sp
--- linux-checker/rc5/drivers/block/drbd/drbd_actlog.sp 2017-08-17
00:27:32.496218655 -0400
+++ linux-checker/ssa/drivers/block/drbd/drbd_actlog.sp 2017-08-17
00:18:57.015846078 -0400
@@ -26,3 +26,4 @@
 drivers/block/drbd/drbd_int.h:1773:14: error: incompatible types in
comparison expression (different address spaces)
 drivers/block/drbd/drbd_actlog.c:469:44: error: incompatible types in
comparison expression (different address spaces)
 drivers/block/drbd/drbd_actlog.c:173:16: warning: context imbalance
in '_drbd_md_sync_page_io' - different lock contexts for basic block
+drivers/block/drbd/drbd_actlog.c:1244:24: warning: context imbalance
in 'drbd_rs_del_all' - different lock contexts for basic block
diff -ruN linux-checker/rc5/drivers/block/drbd/drbd_nl.sp
linux-checker/ssa/drivers/block/drbd/drbd_nl.sp
--- linux-checker/rc5/drivers/block/drbd/drbd_nl.sp 2017-08-17
00:27:32.724224570 -0400
+++ linux-checker/ssa/drivers/block/drbd/drbd_nl.sp 2017-08-17
00:18:57.303853549 -0400
@@ -62,6 +62,7 @@
 drivers/block/drbd/drbd_int.h:791:24: error: incompatible types in
comparison expression (different address spaces)
 drivers/block/drbd/drbd_int.h:791:24: error: incompatible types in
comparison expression (different address spaces)
 drivers/block/drbd/drbd_int.h:791:24: error: incompatible types in
comparison expression (different address spaces)
+drivers/block/drbd/drbd_nl.c:436:17: warning: context imbalance in
'highest_fencing_policy' - different lock contexts for basic block
 drivers/block/drbd/drbd_nl.c:3419:9: warning: context imbalance in
'drbd_adm_dump_devices' - different lock contexts for basic block
 drivers/block/drbd/drbd_nl.c:3687:9: warning: context imbalance in
'drbd_adm_dump_peer_devices' - different lock contexts for basic block
-drivers/block/drbd/drbd_nl.c:3858:9: warning: context imbalance in
'nla_put_status_info' - different lock contexts for basic block
+drivers/block/drbd/drbd_nl.c:3735:12: warning: context imbalance in
'nla_put_status_info' - different lock contexts for basic block
diff -ruN linux-checker/rc5/drivers/block/drbd/drbd_state.sp
linux-checker/ssa/drivers/block/drbd/drbd_state.sp
--- linux-checker/rc5/drivers/block/drbd/drbd_state.sp 2017-08-17
00:27:32.669223143 -0400
+++ linux-checker/ssa/drivers/block/drbd/drbd_state.sp 2017-08-17
00:18:57.216851292 -0400
@@ -27,5 +27,7 @@
 drivers/block/drbd/drbd_state.c:1309:36: warning: cast to non-scalar
 drivers/block/drbd/drbd_state.c:1310:36: warning: cast to non-scalar
 drivers/block/drbd/drbd_state.c:2037:17: error: incompatible types in
comparison expression (different address spaces)
+drivers/block/drbd/drbd_state.c:806:14: warning: context imbalance in
'is_valid_state' - different lock contexts for basic block
+drivers/block/drbd/drbd_state.c:1074:9: warning: context imbalance in
'sanitize_state' - different lock contexts for basic block
 drivers/block/drbd/drbd_state.c:1917:25: warning: context imbalance
in 'after_state_ch' - unexpected unlock
 drivers/block/drbd/drbd_state.c:2333:32: warning: context imbalance
in '_conn_request_state' - unexpected unlock
diff -ruN linux-checker/rc5/drivers/block/drbd/drbd_worker.sp
linux-checker/ssa/drivers/block/drbd/drbd_worker.sp
--- linux-checker/rc5/drivers/block/drbd/drbd_worker.sp 2017-08-17
00:27:32.640222391 -0400
+++ linux-checker/ssa/drivers/block/drbd/drbd_worker.sp 2017-08-17
00:18:57.135849191 -0400
@@ -39,6 +39,6 @@
 drivers/block/drbd/drbd_worker.c:1876:38: error: incompatible types
in comparison expression (different address spaces)
 drivers/block/drbd/drbd_worker.c:2081:14: error: incompatible types
in comparison expression (different address spaces)
 drivers/block/drbd/drbd_worker.c:2136:14: error: incompatible types
in comparison expression (different address spaces)
-drivers/block/drbd/drbd_worker.c:84:25: warning: context imbalance in
'drbd_md_endio' - unexpected unlock
+drivers/block/drbd/drbd_int.h:2140:9: warning: context imbalance in
'drbd_md_endio' - unexpected unlock
 drivers/block/drbd/drbd_worker.c:274:9: warning: context imbalance in
'drbd_request_endio' - unexpected unlock
 drivers/block/drbd/drbd_worker.c:393:12: warning: context imbalance
in 'read_for_csum' - wrong count at exit
diff -ruN linux-checker/rc5/drivers/block/zram/zram_drv.sp
linux-checker/ssa/drivers/block/zram/zram_drv.sp
--- linux-checker/rc5/drivers/block/zram/zram_drv.sp 2017-08-17
00:27:32.761225530 -0400
+++ linux-checker/ssa/drivers/block/zram/zram_drv.sp 2017-08-17
00:18:57.303853549 -0400
@@ -1,2 +1,2 @@
 drivers/block/zram/zram_drv.c:425:13: warning: context imbalance in
'zram_slot_lock' - wrong count at exit
-./include/linux/bit_spinlock.h:62:25: warning: context imbalance in
'zram_slot_unlock' - unexpected unlock
+./arch/x86/include/asm/bitops.h:133:9: warning: context imbalance in
'zram_slot_unlock' - unexpected unlock
diff -ruN linux-checker/rc5/drivers/net/ethernet/chelsio/cxgb4/l2t.sp
linux-checker/ssa/drivers/net/ethernet/chelsio/cxgb4/l2t.sp
--- linux-checker/rc5/drivers/net/ethernet/chelsio/cxgb4/l2t.sp
2017-08-17 00:27:55.087804725 -0400
+++ linux-checker/ssa/drivers/net/ethernet/chelsio/cxgb4/l2t.sp
2017-08-17 00:19:19.860438712 -0400
@@ -1 +1 @@
-./include/linux/skbuff.h:1754:29: warning: context imbalance in
'handle_failed_resolution' - unexpected unlock
+./include/linux/skbuff.h:1733:9: warning: context imbalance in
'handle_failed_resolution' - unexpected unlock
diff -ruN linux-checker/rc5/drivers/net/ethernet/chelsio/cxgb4/sge.sp
linux-checker/ssa/drivers/net/ethernet/chelsio/cxgb4/sge.sp
--- linux-checker/rc5/drivers/net/ethernet/chelsio/cxgb4/sge.sp
2017-08-17 00:27:55.177807060 -0400
+++ linux-checker/ssa/drivers/net/ethernet/chelsio/cxgb4/sge.sp
2017-08-17 00:19:19.965441436 -0400
@@ -10,3 +10,4 @@
 drivers/net/ethernet/chelsio/cxgb4/sge.c:2091:43: warning: cast to
restricted __be64
 drivers/net/ethernet/chelsio/cxgb4/sge.c:1189:34: warning: context
imbalance in 't4_eth_xmit' - different lock contexts for basic block
 drivers/net/ethernet/chelsio/cxgb4/sge.c:1645:28: warning: context
imbalance in 'service_ofldq' - unexpected unlock
+drivers/net/ethernet/chelsio/cxgb4/sge.c:2674:17: warning: context
imbalance in 'sge_tx_timer_cb' - different lock contexts for basic
block
diff -ruN linux-checker/rc5/drivers/net/ethernet/chelsio/cxgb4vf/sge.sp
linux-checker/ssa/drivers/net/ethernet/chelsio/cxgb4vf/sge.sp
--- linux-checker/rc5/drivers/net/ethernet/chelsio/cxgb4vf/sge.sp
2017-08-17 00:27:54.992802261 -0400
+++ linux-checker/ssa/drivers/net/ethernet/chelsio/cxgb4vf/sge.sp
2017-08-17 00:19:20.099444912 -0400
@@ -0,0 +1 @@
+drivers/net/ethernet/chelsio/cxgb4vf/sge.c:2146:17: warning: context
imbalance in 'sge_tx_timer_cb' - different lock contexts for basic
block
diff -ruN linux-checker/rc5/drivers/net/ethernet/myricom/myri10ge/myri10ge.sp
linux-checker/ssa/drivers/net/ethernet/myricom/myri10ge/myri10ge.sp
--- linux-checker/rc5/drivers/net/ethernet/myricom/myri10ge/myri10ge.sp
2017-08-17 00:27:57.390864471 -0400
+++ linux-checker/ssa/drivers/net/ethernet/myricom/myri10ge/myri10ge.sp
2017-08-17 00:19:22.537508160 -0400
@@ -0,0 +1 @@
+drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1449:35: warning:
context imbalance in 'myri10ge_intr' - different lock contexts for
basic block
diff -ruN linux-checker/rc5/drivers/net/ethernet/neterion/vxge/vxge-config.sp
linux-checker/ssa/drivers/net/ethernet/neterion/vxge/vxge-config.sp
--- linux-checker/rc5/drivers/net/ethernet/neterion/vxge/vxge-config.sp
2017-08-17 00:27:57.707872695 -0400
+++ linux-checker/ssa/drivers/net/ethernet/neterion/vxge/vxge-config.sp
2017-08-17 00:19:22.506507356 -0400
@@ -58,4 +58,4 @@
 drivers/net/ethernet/neterion/vxge/vxge-config.c:919:46: warning:
cast to restricted __be64
 drivers/net/ethernet/neterion/vxge/vxge-config.c:919:46: warning:
cast to restricted __be64
 drivers/net/ethernet/neterion/vxge/vxge-config.c:919:46: warning:
cast to restricted __be64
-drivers/net/ethernet/neterion/vxge/vxge-config.c:218:9: warning:
context imbalance in 'vxge_hw_vpath_fw_api' - different lock contexts
for basic block
+drivers/net/ethernet/neterion/vxge/vxge-config.c:157:1: warning:
context imbalance in 'vxge_hw_vpath_fw_api' - different lock contexts
for basic block
diff -ruN linux-checker/rc5/drivers/net/ethernet/neterion/vxge/vxge-main.sp
linux-checker/ssa/drivers/net/ethernet/neterion/vxge/vxge-main.sp
--- linux-checker/rc5/drivers/net/ethernet/neterion/vxge/vxge-main.sp
2017-08-17 00:27:57.449866002 -0400
+++ linux-checker/ssa/drivers/net/ethernet/neterion/vxge/vxge-main.sp
2017-08-17 00:19:22.544508342 -0400
@@ -0,0 +1,3 @@
+drivers/net/ethernet/neterion/vxge/vxge-main.c:116:27: warning:
context imbalance in 'vxge_poll_inta' - different lock contexts for
basic block
+drivers/net/ethernet/neterion/vxge/vxge-main.c:116:27: warning:
context imbalance in 'vxge_netpoll' - different lock contexts for
basic block
+drivers/net/ethernet/neterion/vxge/vxge-main.c:116:27: warning:
context imbalance in 'vxge_tx_msix_handle' - different lock contexts
for basic block
diff -ruN linux-checker/rc5/drivers/net/wan/sbni.sp
linux-checker/ssa/drivers/net/wan/sbni.sp
--- linux-checker/rc5/drivers/net/wan/sbni.sp 2017-08-17
00:28:00.488944842 -0400
+++ linux-checker/ssa/drivers/net/wan/sbni.sp 2017-08-17
00:19:25.338580825 -0400
@@ -1,2 +1,2 @@
 drivers/net/wan/sbni.c:525:20: warning: context imbalance in
'sbni_interrupt' - different lock contexts for basic block
-drivers/net/wan/sbni.c:577:9: warning: context imbalance in
'handle_channel' - different lock contexts for basic block
+drivers/net/wan/sbni.c:531:1: warning: context imbalance in
'handle_channel' - different lock contexts for basic block
diff -ruN linux-checker/rc5/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.sp
linux-checker/ssa/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.sp
--- linux-checker/rc5/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.sp
2017-08-17 00:28:01.987983730 -0400
+++ linux-checker/ssa/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.sp
2017-08-17 00:19:27.150627834 -0400
@@ -0,0 +1 @@
+drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c:459:9: warning:
context imbalance in 'iwl_read_prph_block' - different lock contexts
for basic block
diff -ruN linux-checker/rc5/drivers/scsi/device_handler/scsi_dh_alua.sp
linux-checker/ssa/drivers/scsi/device_handler/scsi_dh_alua.sp
--- linux-checker/rc5/drivers/scsi/device_handler/scsi_dh_alua.sp
2017-08-17 00:28:06.435099097 -0400
+++ linux-checker/ssa/drivers/scsi/device_handler/scsi_dh_alua.sp
2017-08-17 00:19:31.388737779 -0400
@@ -1,2 +1,3 @@
 drivers/scsi/device_handler/scsi_dh_alua.c:139:16: warning: Variable
length array is used.
 drivers/scsi/device_handler/scsi_dh_alua.c:167:16: warning: Variable
length array is used.
+drivers/scsi/device_handler/scsi_dh_alua.c:658:33: warning: context
imbalance in 'alua_rtpg' - different lock contexts for basic block
diff -ruN linux-checker/rc5/drivers/scsi/libfc/fc_fcp.sp
linux-checker/ssa/drivers/scsi/libfc/fc_fcp.sp
--- linux-checker/rc5/drivers/scsi/libfc/fc_fcp.sp 2017-08-17
00:28:07.033114610 -0400
+++ linux-checker/ssa/drivers/scsi/libfc/fc_fcp.sp 2017-08-17
00:19:31.949752332 -0400
@@ -7,6 +7,6 @@
 drivers/scsi/libfc/fc_fcp.c:1465:26: warning: context imbalance in
'fc_fcp_timeout' - unexpected unlock
 drivers/scsi/libfc/fc_fcp.c:1654:26: warning: context imbalance in
'fc_fcp_rec_resp' - unexpected unlock
 drivers/scsi/libfc/fc_fcp.c:1699:26: warning: context imbalance in
'fc_fcp_rec_error' - unexpected unlock
-drivers/scsi/libfc/fc_fcp.c:1804:34: warning: context imbalance in
'fc_fcp_srr_resp' - unexpected unlock
+drivers/scsi/libfc/fc_fcp.c:246:23: warning: context imbalance in
'fc_fcp_srr_resp' - unexpected unlock
 drivers/scsi/libfc/fc_fcp.c:1848:26: warning: context imbalance in
'fc_fcp_srr_error' - unexpected unlock
 drivers/scsi/libfc/fc_fcp.c:2153:9: warning: context imbalance in
'fc_eh_abort' - unexpected unlock
diff -ruN linux-checker/rc5/drivers/scsi/mvsas/mv_sas.sp
linux-checker/ssa/drivers/scsi/mvsas/mv_sas.sp
--- linux-checker/rc5/drivers/scsi/mvsas/mv_sas.sp 2017-08-17
00:28:07.361123120 -0400
+++ linux-checker/ssa/drivers/scsi/mvsas/mv_sas.sp 2017-08-17
00:19:32.287761101 -0400
@@ -31,5 +31,5 @@
 drivers/scsi/mvsas/mv_sas.c:1671:23: warning: cast to restricted __le32
 drivers/scsi/mvsas/mv_sas.c:1672:23: warning: cast to restricted __le32
 drivers/scsi/mvsas/mv_sas.c:1092:13: warning: context imbalance in
'mvs_port_notify_formed' - different lock contexts for basic block
-drivers/scsi/mvsas/mv_sas.c:1238:9: warning: context imbalance in
'mvs_dev_found_notify' - different lock contexts for basic block
+drivers/scsi/mvsas/mv_sas.c:1190:12: warning: context imbalance in
'mvs_dev_found_notify' - different lock contexts for basic block
 drivers/scsi/mvsas/mv_sas.c:1832:9: warning: context imbalance in
'mvs_slot_complete' - unexpected unlock
diff -ruN linux-checker/rc5/fs/btrfs/ctree.sp
linux-checker/ssa/fs/btrfs/ctree.sp
--- linux-checker/rc5/fs/btrfs/ctree.sp 2017-08-17 00:28:19.948449660 -0400
+++ linux-checker/ssa/fs/btrfs/ctree.sp 2017-08-17 00:19:45.049092155 -0400
@@ -1,3 +1,3 @@
 fs/btrfs/ctree.c:154:22: error: incompatible types in comparison
expression (different address spaces)
-fs/btrfs/ctree.c:635:42: warning: context imbalance in
'tree_mod_log_insert_move' - unexpected unlock
-fs/btrfs/ctree.c:864:42: warning: context imbalance in
'tree_mod_log_eb_copy' - unexpected unlock
+fs/btrfs/ctree.c:354:9: warning: context imbalance in
'tree_mod_log_insert_move' - unexpected unlock
+fs/btrfs/ctree.c:354:9: warning: context imbalance in
'tree_mod_log_eb_copy' - unexpected unlock
diff -ruN linux-checker/rc5/fs/btrfs/dev-replace.sp
linux-checker/ssa/fs/btrfs/dev-replace.sp
--- linux-checker/rc5/fs/btrfs/dev-replace.sp 2017-08-17
00:28:20.029451761 -0400
+++ linux-checker/ssa/fs/btrfs/dev-replace.sp 2017-08-17
00:19:45.090093219 -0400
@@ -6,7 +6,7 @@
 fs/btrfs/dev-replace.c:807:17: error: incompatible types in
comparison expression (different address spaces)
 fs/btrfs/dev-replace.c:364:9: error: incompatible types in comparison
expression (different address spaces)
 fs/btrfs/dev-replace.c:364:9: error: incompatible types in comparison
expression (different address spaces)
-fs/btrfs/dev-replace.c:866:9: warning: context imbalance in
'btrfs_dev_replace_lock' - wrong count at exit
+fs/btrfs/dev-replace.c:864:6: warning: context imbalance in
'btrfs_dev_replace_lock' - wrong count at exit
 fs/btrfs/dev-replace.c:886:17: warning: context imbalance in
'btrfs_dev_replace_unlock' - unexpected unlock
 fs/btrfs/dev-replace.c:900:9: warning: context imbalance in
'btrfs_dev_replace_set_lock_blocking' - unexpected unlock
 fs/btrfs/dev-replace.c:911:9: warning: context imbalance in
'btrfs_dev_replace_clear_lock_blocking' - wrong count at exit
diff -ruN linux-checker/rc5/fs/btrfs/extent-tree.sp
linux-checker/ssa/fs/btrfs/extent-tree.sp
--- linux-checker/rc5/fs/btrfs/extent-tree.sp 2017-08-17
00:28:19.860447377 -0400
+++ linux-checker/ssa/fs/btrfs/extent-tree.sp 2017-08-17
00:19:45.581105957 -0400
@@ -1,3 +1,3 @@
 fs/btrfs/extent-tree.c:7412:39: warning: context imbalance in
'btrfs_lock_cluster' - wrong count at exit
 fs/btrfs/extent-tree.c:7688:44: warning: context imbalance in
'find_free_extent' - unexpected unlock
-fs/btrfs/extent-tree.c:9764:9: warning: context imbalance in
'btrfs_put_block_group_cache' - wrong count at exit
+fs/btrfs/extent-tree.c:9759:6: warning: context imbalance in
'btrfs_put_block_group_cache' - wrong count at exit
diff -ruN linux-checker/rc5/fs/ceph/caps.sp linux-checker/ssa/fs/ceph/caps.sp
--- linux-checker/rc5/fs/ceph/caps.sp 2017-08-17 00:28:20.364460452 -0400
+++ linux-checker/ssa/fs/ceph/caps.sp 2017-08-17 00:19:45.554105256 -0400
@@ -1,3 +1,3 @@
 fs/ceph/caps.c:2036:9: warning: context imbalance in 'try_flush_caps'
- wrong count at exit
-fs/ceph/caps.c:3155:9: warning: context imbalance in
'handle_cap_grant' - wrong count at exit
+fs/ceph/caps.c:2909:13: warning: context imbalance in
'handle_cap_grant' - wrong count at exit
 fs/ceph/caps.c:3739:17: warning: context imbalance in
'ceph_handle_caps' - unexpected unlock
diff -ruN linux-checker/rc5/fs/ntfs/compress.sp
linux-checker/ssa/fs/ntfs/compress.sp
--- linux-checker/rc5/fs/ntfs/compress.sp 2017-08-17 00:28:24.202560020 -0400
+++ linux-checker/ssa/fs/ntfs/compress.sp 2017-08-17 00:19:49.671212062 -0400
@@ -1,3 +1,3 @@
 fs/ntfs/compress.c:195:58: warning: Variable length array is used.
 fs/ntfs/compress.c:220:28: warning: context imbalance in
'ntfs_decompress' - unexpected unlock
-fs/ntfs/compress.c:886:16: warning: context imbalance in
'ntfs_read_compressed_block' - different lock contexts for basic block
+fs/ntfs/compress.c:785:16: warning: context imbalance in
'ntfs_read_compressed_block' - different lock contexts for basic block
diff -ruN linux-checker/rc5/ipc/sem.sp linux-checker/ssa/ipc/sem.sp
--- linux-checker/rc5/ipc/sem.sp 2017-08-17 00:28:27.519646071 -0400
+++ linux-checker/ssa/ipc/sem.sp 2017-08-17 00:19:53.227304314 -0400
@@ -1,5 +1,5 @@
 ipc/sem.c:521:9: warning: context imbalance in 'newary' - unexpected unlock
-ipc/sem.c:1132:17: warning: context imbalance in 'freeary' - unexpected unlock
+ipc/sem.c:446:9: warning: context imbalance in 'freeary' - unexpected unlock
 ipc/sem.c:1585:9: warning: context imbalance in 'semctl_down' -
different lock contexts for basic block
 ipc/sem.c:1690:24: warning: context imbalance in 'find_alloc_undo' -
wrong count at exit
 ./include/linux/rcupdate.h:663:9: warning: context imbalance in
'SyS_semtimedop' - unexpected unlock
diff -ruN linux-checker/rc5/ipc/util.sp linux-checker/ssa/ipc/util.sp
--- linux-checker/rc5/ipc/util.sp 2017-08-17 00:28:27.471644826 -0400
+++ linux-checker/ssa/ipc/util.sp 2017-08-17 00:19:53.161302602 -0400
@@ -3,5 +3,5 @@
 ipc/util.c:373:27: warning: context imbalance in 'ipcget_public' -
unexpected unlock
 ipc/util.c:518:22: warning: context imbalance in 'ipc_lock' -
different lock contexts for basic block
 ipc/util.c:687:29: warning: context imbalance in 'sysvipc_find_ipc' -
different lock contexts for basic block
-ipc/util.c:725:27: warning: context imbalance in 'sysvipc_proc_next'
- unexpected unlock
-ipc/util.c:769:27: warning: context imbalance in 'sysvipc_proc_stop'
- unexpected unlock
+ipc/util.h:162:20: warning: context imbalance in 'sysvipc_proc_next'
- unexpected unlock
+ipc/util.h:162:20: warning: context imbalance in 'sysvipc_proc_stop'
- unexpected unlock
diff -ruN linux-checker/rc5/kernel/cgroup/cgroup.sp
linux-checker/ssa/kernel/cgroup/cgroup.sp
--- linux-checker/rc5/kernel/cgroup/cgroup.sp 2017-08-17
00:28:27.999658524 -0400
+++ linux-checker/ssa/kernel/cgroup/cgroup.sp 2017-08-17
00:19:53.705316715 -0400
@@ -1 +1 @@
-kernel/cgroup/cgroup.c:2656:9: warning: context imbalance in
'cgroup_lock_and_drain_offline' - wrong count at exit
+kernel/cgroup/cgroup.c:2645:6: warning: context imbalance in
'cgroup_lock_and_drain_offline' - wrong count at exit
diff -ruN linux-checker/rc5/kernel/debug/debug_core.sp
linux-checker/ssa/kernel/debug/debug_core.sp
--- linux-checker/rc5/kernel/debug/debug_core.sp 2017-08-17
00:28:27.883655514 -0400
+++ linux-checker/ssa/kernel/debug/debug_core.sp 2017-08-17
00:19:53.626314665 -0400
@@ -1 +1 @@
-./arch/x86/include/asm/paravirt.h:809:16: warning: context imbalance
in 'kgdb_cpu_enter' - different lock contexts for basic block
+kernel/debug/debug_core.c:495:9: warning: context imbalance in
'kgdb_cpu_enter' - different lock contexts for basic block
diff -ruN linux-checker/rc5/kernel/events/core.sp
linux-checker/ssa/kernel/events/core.sp
--- linux-checker/rc5/kernel/events/core.sp 2017-08-17 00:28:28.175663090 -0400
+++ linux-checker/ssa/kernel/events/core.sp 2017-08-17 00:19:53.907321955 -0400
@@ -136,9 +136,9 @@
 kernel/events/core.c:149:16: warning: incorrect type in initializer
(different address spaces)
 kernel/events/core.c:11016:26: warning: incorrect type in initializer
(different address spaces)
 kernel/events/core.c:11044:26: warning: incorrect type in initializer
(different address spaces)
-kernel/events/core.c:156:9: warning: context imbalance in
'perf_ctx_lock' - wrong count at exit
+kernel/events/core.c:152:13: warning: context imbalance in
'perf_ctx_lock' - wrong count at exit
 kernel/events/core.c:164:17: warning: context imbalance in
'perf_ctx_unlock' - unexpected unlock
-./include/linux/rcupdate.h:661:9: warning: context imbalance in
'perf_lock_task_context' - different lock contexts for basic block
+kernel/events/core.c:1331:17: warning: context imbalance in
'perf_lock_task_context' - different lock contexts for basic block
 kernel/events/core.c:1358:17: warning: context imbalance in
'perf_pin_task_context' - unexpected unlock
 kernel/events/core.c:2363:9: warning: context imbalance in
'__perf_install_in_context' - wrong count at exit
 kernel/events/core.c:3862:17: warning: context imbalance in
'find_get_context' - unexpected unlock
diff -ruN linux-checker/rc5/net/irda/irqueue.sp
linux-checker/ssa/net/irda/irqueue.sp
--- linux-checker/rc5/net/irda/irqueue.sp 2017-08-17 00:28:30.494723251 -0400
+++ linux-checker/ssa/net/irda/irqueue.sp 2017-08-17 00:19:56.477388628 -0400
@@ -1,4 +1,4 @@
-net/irda/irqueue.c:405:25: warning: context imbalance in
'hashbin_delete' - different lock contexts for basic block
+net/irda/irqueue.c:414:33: warning: context imbalance in
'hashbin_delete' - different lock contexts for basic block
 net/irda/irqueue.c:445:6: warning: context imbalance in
'hashbin_insert' - different lock contexts for basic block
 net/irda/irqueue.c:538:9: warning: context imbalance in
'hashbin_remove_first' - different lock contexts for basic block
 net/irda/irqueue.c:628:9: warning: context imbalance in
'hashbin_remove' - different lock contexts for basic block
diff -ruN linux-checker/rc5/security/selinux/avc.sp
linux-checker/ssa/security/selinux/avc.sp
--- linux-checker/rc5/security/selinux/avc.sp 2017-08-17
00:28:32.946786862 -0400
+++ linux-checker/ssa/security/selinux/avc.sp 2017-08-17
00:19:59.397464380 -0400
@@ -0,0 +1 @@
+security/selinux/avc.c:523:58: warning: context imbalance in
'avc_alloc_node' - different lock contexts for basic block

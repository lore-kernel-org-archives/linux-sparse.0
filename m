From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/2] OSS: soundcard: locking bug in sound_ioctl()
Date: Mon, 11 Oct 2010 22:42:18 +0200
Message-ID: <201010112242.19246.arnd@arndb.de>
References: <20101010173352.GB5851@bicker> <1286794326.3634.13.camel@jlt3.sipsolutions.net> <20101011185455.GB8537@feather>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64927 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab0JKUmy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 16:42:54 -0400
In-Reply-To: <20101011185455.GB8537@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Dan Carpenter <error27@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-sparse@vger.kernel.org

On Monday 11 October 2010 20:54:56 Josh Triplett wrote:
> On Mon, Oct 11, 2010 at 12:52:06PM +0200, Johannes Berg wrote:
>
> > I don't know. Could be related to trylock issues, could be just historic
> > since semaphores can't really be annotated, or could be something else
> > entirely... I would expect a huge amount of warnings from sparse though
> > if you "just" annotate them since there are things like rtnl_lock()
> > which would have to propagate context.
> 
> As far as I know, no reason exists to not just annotate mutexes; I think
> mutexes just came along later and nobody happened to add the appropriate
> annotations.  (Also, sparse does handle trylock.)
> 
> But yes, annotating mutexes will then introduce a giant pile of lock
> warnings that need further annotation propagation.  It will also
> introduce lock warnings that represent actual bugs, making it important
> to not just blindly propagate annotations to make warnings go away.

I've given it a try, wrapping the trylock/interruptible/killable variants
into macros and the number of additional warnings was much less than
I had feared. This is the diff for today's sparse with today's linux-next
x86_64_defconfig:

> arch/x86/kernel/smpboot.c:100:6: warning: context imbalance in 'cpu_hotplug_driver_lock' - wrong count at exit
> arch/x86/kernel/smpboot.c:105:6: warning: context imbalance in 'cpu_hotplug_driver_unlock' - unexpected unlock
> kernel/cpu.c:27:6: warning: context imbalance in 'cpu_maps_update_begin' - wrong count at exit
> kernel/cpu.c:32:6: warning: context imbalance in 'cpu_maps_update_done' - unexpected unlock
> kernel/cpu.c:110:9: warning: context imbalance in 'cpu_hotplug_begin' - wrong count at exit
> kernel/cpu.c:120:13: warning: context imbalance in 'cpu_hotplug_done' - unexpected unlock
> kernel/params.c:565:6: warning: context imbalance in '__kernel_param_lock' - wrong count at exit
> kernel/params.c:571:6: warning: context imbalance in '__kernel_param_unlock' - unexpected unlock
> kernel/irq/autoprobe.c:110:9: warning: context imbalance in 'probe_irq_on' - wrong count at exit
> kernel/irq/autoprobe.c:145:9: warning: context imbalance in 'probe_irq_mask' - unexpected unlock
> kernel/irq/autoprobe.c:189:9: warning: context imbalance in 'probe_irq_off' - unexpected unlock
> kernel/trace/trace.c:1716:26: warning: context imbalance in 's_start' - different lock contexts for basic block
> kernel/trace/trace.c:303:31: warning: context imbalance in 's_stop' - unexpected unlock
> kernel/trace/trace.c:2277:9: warning: context imbalance in 't_start' - wrong count at exit
> kernel/trace/trace.c:2280:13: warning: context imbalance in 't_stop' - unexpected unlock
> kernel/trace/trace.c:3196:28: warning: context imbalance in 'tracing_read_pipe' - different lock contexts for basic block
> kernel/trace/trace.c:3349:28: warning: context imbalance in 'tracing_splice_read_pipe' - different lock contexts for basic block
> kernel/trace/trace.c:303:31: warning: context imbalance in 'tracing_buffers_read' - unexpected unlock
> kernel/trace/trace.c:303:31: warning: context imbalance in 'tracing_buffers_splice_read' - unexpected unlock
> kernel/trace/trace_stat.c:203:13: warning: context imbalance in 'stat_seq_start' - wrong count at exit
> kernel/trace/trace_stat.c:240:13: warning: context imbalance in 'stat_seq_stop' - unexpected unlock
> kernel/trace/trace_events.c:399:9: warning: context imbalance in 't_start' - wrong count at exit
> kernel/trace/trace_events.c:430:9: warning: context imbalance in 's_start' - wrong count at exit
> kernel/trace/trace_events.c:444:13: warning: context imbalance in 't_stop' - unexpected unlock
> kernel/trace/trace_kprobe.c:1064:13: warning: context imbalance in 'probes_seq_start' - wrong count at exit
> kernel/trace/trace_kprobe.c:1075:13: warning: context imbalance in 'probes_seq_stop' - unexpected unlock
> kernel/cgroup.c:737:6: warning: context imbalance in 'cgroup_lock' - wrong count at exit
> kernel/cgroup.c:748:6: warning: context imbalance in 'cgroup_unlock' - unexpected unlock
> kernel/cgroup.c:1867:6: warning: context imbalance in 'cgroup_lock_live_group' - different lock contexts for basic block
> kernel/cgroup.c:2155:12: warning: context imbalance in 'cgroup_create_file' - different lock contexts for basic block
> kernel/cgroup.c:3273:47: warning: context imbalance in 'cgroup_lock_hierarchy' - different lock contexts for basic block
> kernel/cgroup.c:3291:25: warning: context imbalance in 'cgroup_unlock_hierarchy' - unexpected unlock
> kernel/cgroup.c:3362:9: warning: context imbalance in 'cgroup_create' - unexpected unlock
> kernel/cpuset.c:2449:6: warning: context imbalance in 'cpuset_unlock' - unexpected unlock
> kernel/audit_watch.c:439:5: warning: context imbalance in 'audit_add_watch' - unexpected unlock
> kernel/audit_tree.c:662:9: warning: context imbalance in 'audit_add_tree_rule' - unexpected unlock
> mm/shmem.c:943:9: warning: context imbalance in 'shmem_unuse_inode' - unexpected unlock
> mm/shmem.c:1029:9: warning: context imbalance in 'shmem_unuse' - wrong count at exit
> mm/mmap.c:2598:9: warning: context imbalance in 'mm_take_all_locks' - wrong count at exit
> mm/mmap.c:2657:9: warning: context imbalance in 'mm_drop_all_locks' - unexpected unlock
> mm/swapfile.c:1692:13: warning: context imbalance in 'swap_start' - wrong count at exit
> mm/swapfile.c:1737:13: warning: context imbalance in 'swap_stop' - unexpected unlock
> mm/swapfile.c:2114:17: warning: context imbalance in 'sys_swapon' - unexpected unlock
> fs/super.c:239:6: warning: context imbalance in 'lock_super' - wrong count at exit
> fs/super.c:245:6: warning: context imbalance in 'unlock_super' - unexpected unlock
> fs/exec.c:1079:5: warning: context imbalance in 'prepare_bprm_creds' - different lock contexts for basic block
> arch/x86/include/asm/current.h:14:16: warning: context imbalance in 'free_bprm' - unexpected unlock
> fs/exec.c:1105:6: warning: context imbalance in 'install_exec_creds' - unexpected unlock
> fs/pipe.c:55:9: warning: context imbalance in 'pipe_lock_nested' - wrong count at exit
> fs/pipe.c:71:17: warning: context imbalance in 'pipe_unlock' - unexpected unlock
> fs/namei.c:1346:15: warning: context imbalance in 'lock_rename' - wrong count at exit
> fs/namei.c:1376:6: warning: context imbalance in 'unlock_rename' - unexpected unlock
> fs/namei.c:1491:36: warning: context imbalance in '__open_namei_create' - unexpected unlock
> fs/namei.c:1730:20: warning: context imbalance in 'do_last' - different lock contexts for basic block
> fs/namei.c:1905:15: warning: context imbalance in 'lookup_create' - wrong count at exit
> fs/namei.c:2040:9: warning: context imbalance in 'sys_mknodat' - unexpected unlock
> fs/namei.c:2103:9: warning: context imbalance in 'sys_mkdirat' - unexpected unlock
> fs/namei.c:2391:9: warning: context imbalance in 'sys_symlinkat' - unexpected unlock
> fs/namei.c:2490:9: warning: context imbalance in 'sys_linkat' - unexpected unlock
> fs/namei.c:2577:9: warning: context imbalance in 'vfs_rename_dir' - different lock contexts for basic block
> fs/namei.c:2609:9: warning: context imbalance in 'vfs_rename_other' - different lock contexts for basic block
> fs/readdir.c:43:9: warning: context imbalance in 'vfs_readdir' - unexpected unlock
> fs/dcache.c:1792:17: warning: context imbalance in '__d_unalias' - unexpected unlock
> fs/libfs.c:783:9: warning: context imbalance in 'simple_attr_read' - unexpected unlock
> fs/libfs.c:815:9: warning: context imbalance in 'simple_attr_write' - unexpected unlock
> fs/direct-io.c:1095:17: warning: context imbalance in 'direct_io_worker' - unexpected unlock
> fs/direct-io.c:1253:9: warning: context imbalance in '__blockdev_direct_IO' - different lock contexts for basic block
> fs/autofs4/root.c:582:17: warning: context imbalance in 'autofs4_lookup' - unexpected unlock
> fs/autofs4/waitq.c:274:25: warning: context imbalance in 'validate_request' - unexpected unlock
> fs/autofs4/waitq.c:366:17: warning: context imbalance in 'autofs4_wait' - different lock contexts for basic block
> include/linux/spinlock_api_smp.h:152:27: warning: context imbalance in 'journal_lock_updates' - wrong count at exit
> fs/jbd/transaction.c:484:9: warning: context imbalance in 'journal_unlock_updates' - unexpected unlock
> fs/proc/base.c:2313:9: warning: context imbalance in 'proc_pid_attr_write' - unexpected unlock
> fs/proc/proc_tty.c:107:13: warning: context imbalance in 't_start' - wrong count at exit
> fs/proc/proc_tty.c:118:13: warning: context imbalance in 't_stop' - unexpected unlock
> fs/sysfs/dir.c:350:6: warning: context imbalance in 'sysfs_addrm_start' - wrong count at exit
> fs/sysfs/dir.c:504:6: warning: context imbalance in 'sysfs_addrm_finish' - unexpected unlock
> arch/x86/include/asm/current.h:14:16: warning: context imbalance in 'ata_eh_acquire' - wrong count at exit
> drivers/ata/libata-eh.c:495:9: warning: context imbalance in 'ata_eh_release' - unexpected unlock
> drivers/base/bus.c:181:17: warning: context imbalance in 'driver_unbind' - different lock contexts for basic block
> drivers/base/bus.c:211:17: warning: context imbalance in 'driver_bind' - different lock contexts for basic block
> drivers/base/bus.c:731:9: warning: context imbalance in 'bus_rescan_devices_helper' - different lock contexts for basic block
> drivers/base/bus.c:766:9: warning: context imbalance in 'device_reprobe' - different lock contexts for basic block
> drivers/base/dd.c:265:12: warning: context imbalance in '__driver_attach' - different lock contexts for basic block
> drivers/base/dd.c:395:17: warning: context imbalance in 'driver_detach' - different lock contexts for basic block
> drivers/base/power/main.c:73:6: warning: context imbalance in 'device_pm_lock' - wrong count at exit
> drivers/base/power/main.c:81:6: warning: context imbalance in 'device_pm_unlock' - unexpected unlock
> drivers/block/loop.c:1064:9: warning: context imbalance in 'loop_clr_fd' - unexpected unlock
> drivers/block/loop.c:1352:9: warning: context imbalance in 'lo_ioctl' - different lock contexts for basic block
> drivers/block/loop.c:1553:9: warning: context imbalance in 'lo_release' - different lock contexts for basic block
> drivers/char/tty_io.c:960:6: warning: context imbalance in 'tty_write_unlock' - unexpected unlock
> drivers/char/tty_io.c:966:5: warning: context imbalance in 'tty_write_lock' - wrong count at exit
> drivers/char/tty_io.c:1077:6: warning: context imbalance in 'tty_write_message' - wrong count at exit
> drivers/char/tty_mutex.c:31:9: warning: context imbalance in 'tty_lock' - wrong count at exit
> drivers/char/tty_mutex.c:42:9: warning: context imbalance in 'tty_unlock' - unexpected unlock
> drivers/char/misc.c:66:13: warning: context imbalance in 'misc_seq_start' - wrong count at exit
> drivers/char/misc.c:77:13: warning: context imbalance in 'misc_seq_stop' - unexpected unlock
> drivers/cpuidle/cpuidle.c:138:6: warning: context imbalance in 'cpuidle_pause_and_lock' - wrong count at exit
> drivers/cpuidle/cpuidle.c:149:6: warning: context imbalance in 'cpuidle_resume_and_unlock' - unexpected unlock
> drivers/gpu/drm/drm_pci.c:215:9: warning: context imbalance in 'drm_get_pci_dev' - unexpected unlock
> drivers/gpu/drm/i915/i915_debugfs.c:202:9: warning: context imbalance in 'i915_gem_object_info' - unexpected unlock
> drivers/gpu/drm/i915/i915_debugfs.c:827:9: warning: context imbalance in 'i915_emon_status' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:144:12: warning: context imbalance in 'i915_mutex_lock_interruptible' - different lock contexts for basic block
> drivers/gpu/drm/i915/i915_gem.c:417:9: warning: context imbalance in 'i915_gem_shmem_pread_fast' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:554:9: warning: context imbalance in 'i915_gem_shmem_pread_slow' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:706:17: warning: context imbalance in 'i915_gem_gtt_pwrite_fast' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:847:9: warning: context imbalance in 'i915_gem_gtt_pwrite_slow' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:918:9: warning: context imbalance in 'i915_gem_shmem_pwrite_fast' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:1032:9: warning: context imbalance in 'i915_gem_shmem_pwrite_slow' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:1184:35: warning: context imbalance in 'i915_gem_set_domain_ioctl' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:1217:35: warning: context imbalance in 'i915_gem_sw_finish_ioctl' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:1529:43: warning: context imbalance in 'i915_gem_mmap_gtt_ioctl' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:3770:17: warning: context imbalance in 'i915_gem_do_execbuffer' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:4248:43: warning: context imbalance in 'i915_gem_pin_ioctl' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:4310:43: warning: context imbalance in 'i915_gem_unpin_ioctl' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:4375:35: warning: context imbalance in 'i915_gem_busy_ioctl' - unexpected unlock
> drivers/gpu/drm/i915/i915_gem.c:4419:43: warning: context imbalance in 'i915_gem_madvise_ioctl' - unexpected unlock
> drivers/hid/usbhid/hid-core.c:127:47: warning: context imbalance in 'hid_reset' - unexpected unlock
> drivers/input/input.c:1021:13: warning: context imbalance in 'input_devices_seq_start' - different lock contexts for basic block
> drivers/input/input.c:1050:17: warning: context imbalance in 'input_seq_stop' - unexpected unlock
> drivers/input/input.c:1143:13: warning: context imbalance in 'input_handlers_seq_start' - different lock contexts for basic block
> drivers/input/mouse/psmouse-base.c:1534:9: warning: context imbalance in 'psmouse_attr_set_helper' - unexpected unlock
> drivers/input/serio/i8042.c:129:6: warning: context imbalance in 'i8042_lock_chip' - wrong count at exit
> drivers/input/serio/i8042.c:135:6: warning: context imbalance in 'i8042_unlock_chip' - unexpected unlock
> drivers/input/serio/libps2.c:62:9: warning: context imbalance in 'ps2_begin_command' - wrong count at exit
> drivers/input/serio/libps2.c:72:9: warning: context imbalance in 'ps2_end_command' - unexpected unlock
> drivers/md/dm.c:2088:6: warning: context imbalance in 'dm_lock_md_type' - wrong count at exit
> drivers/md/dm.c:2093:6: warning: context imbalance in 'dm_unlock_md_type' - unexpected unlock
> drivers/md/md.c:578:17: warning: context imbalance in 'mddev_unlock' - unexpected unlock
> drivers/md/md.c:546:19: warning: context imbalance in 'rdev_size_store' - different lock contexts for basic block
> drivers/md/md.c:546:19: warning: context imbalance in 'rdev_attr_show' - different lock contexts for basic block
> drivers/md/md.c:546:19: warning: context imbalance in 'rdev_attr_store' - different lock contexts for basic block
> drivers/md/md.c:546:19: warning: context imbalance in 'md_attr_show' - different lock contexts for basic block
> drivers/md/md.c:546:19: warning: context imbalance in 'md_attr_store' - different lock contexts for basic block
> drivers/md/md.c:4871:17: warning: context imbalance in 'autorun_devices' - different lock contexts for basic block
> drivers/md/md.c:546:19: warning: context imbalance in 'md_ioctl' - different lock contexts for basic block
> drivers/md/md.c:5911:9: warning: context imbalance in 'md_open' - different lock contexts for basic block
> drivers/md/md.c:546:19: warning: context imbalance in 'md_seq_show' - different lock contexts for basic block
> drivers/md/md.c:6985:6: warning: context imbalance in 'md_check_recovery' - different lock contexts for basic block
> drivers/md/md.c:7180:17: warning: context imbalance in 'md_notify_reboot' - different lock contexts for basic block
> drivers/pci/pci.c:2494:30: warning: context imbalance in 'pci_dev_reset' - unexpected unlock
> drivers/pcmcia/rsrc_nonstatic.c:281:17: warning: context imbalance in 'readable' - unexpected unlock
> drivers/serial/serial_core.c:1546:26: warning: context imbalance in 'uart_get' - different lock contexts for basic block
> drivers/serial/serial_core.c:1632:17: warning: context imbalance in 'uart_open' - unexpected unlock
> drivers/thermal/thermal_sys.c:74:9: warning: context imbalance in 'get_idr' - different lock contexts for basic block
> drivers/thermal/thermal_sys.c:88:9: warning: context imbalance in 'release_idr' - different lock contexts for basic block
> drivers/usb/class/usblp.c:842:9: warning: context imbalance in 'usblp_read' - unexpected unlock
> arch/x86/include/asm/current.h:14:16: warning: context imbalance in 'usblp_rwait_and_lock' - different lock contexts for basic block
> drivers/usb/core/usb.c:561:5: warning: context imbalance in 'usb_lock_device_for_reset' - different lock contexts for basic block
> drivers/usb/core/message.c:1605:17: warning: context imbalance in '__usb_queue_reset_device' - unexpected unlock
> drivers/usb/storage/transport.c:1315:17: warning: context imbalance in 'usb_stor_port_reset' - unexpected unlock
> drivers/usb/storage/usb.c:191:5: warning: context imbalance in 'usb_stor_pre_reset' - wrong count at exit
> drivers/usb/storage/usb.c:203:5: warning: context imbalance in 'usb_stor_post_reset' - unexpected unlock
> drivers/video/fbmem.c:48:5: warning: context imbalance in 'lock_fb_info' - wrong count at exit
> drivers/video/fbmem.c:1047:17: warning: context imbalance in 'do_fb_ioctl' - unexpected unlock
> drivers/video/fbmem.c:1608:9: warning: context imbalance in 'register_framebuffer' - unexpected unlock
> drivers/video/fbmem.c:1646:9: warning: context imbalance in 'unregister_framebuffer' - unexpected unlock
> drivers/video/fbmem.c:1696:23: warning: context imbalance in 'fb_set_suspend' - unexpected unlock
> drivers/video/fbmem.c:1768:17: warning: context imbalance in 'fb_new_modelist' - unexpected unlock
> drivers/video/fbcmap.c:276:23: warning: context imbalance in 'fb_set_user_cmap' - unexpected unlock
> drivers/video/console/fbcon.c:2299:9: warning: context imbalance in 'fbcon_generic_blank' - unexpected unlock
> sound/core/sound.c:124:25: warning: context imbalance in 'autoload_device' - unexpected unlock
> net/netfilter/core.c:40:9: warning: context imbalance in 'nf_register_afinfo' - unexpected unlock
> net/netfilter/core.c:71:21: warning: context imbalance in 'nf_register_hook' - unexpected unlock
> net/netfilter/nf_log.c:132:13: warning: context imbalance in 'seq_start' - wrong count at exit
> net/netfilter/nf_log.c:152:13: warning: context imbalance in 'seq_stop' - unexpected unlock
> net/netfilter/x_tables.c:710:17: warning: context imbalance in 'xt_find_table_lock' - different lock contexts for basic block
> net/netfilter/x_tables.c:726:6: warning: context imbalance in 'xt_table_unlock' - unexpected unlock
> net/netfilter/x_tables.c:733:6: warning: context imbalance in 'xt_compat_lock' - wrong count at exit
> net/netfilter/x_tables.c:739:6: warning: context imbalance in 'xt_compat_unlock' - unexpected unlock
> net/netfilter/x_tables.c:876:9: warning: context imbalance in 'xt_register_table' - unexpected unlock
> net/netfilter/x_tables.c:903:13: warning: context imbalance in 'xt_table_seq_start' - wrong count at exit
> net/netfilter/x_tables.c:922:13: warning: context imbalance in 'xt_table_seq_stop' - unexpected unlock
> net/netfilter/x_tables.c:985:13: warning: context imbalance in 'xt_mttg_seq_next' - wrong count at exit
> net/netfilter/x_tables.c:1044:17: warning: context imbalance in 'xt_mttg_seq_stop' - unexpected unlock
> net/netlink/genetlink.c:24:6: warning: context imbalance in 'genl_lock' - wrong count at exit
> net/netlink/genetlink.c:30:6: warning: context imbalance in 'genl_unlock' - unexpected unlock
> net/unix/af_unix.c:919:9: warning: context imbalance in 'unix_bind' - different lock contexts for basic block
> net/wireless/core.c:150:9: warning: context imbalance in 'cfg80211_get_dev_from_info' - different lock contexts for basic block
> net/wireless/core.c:172:9: warning: context imbalance in 'cfg80211_get_dev_from_ifindex' - wrong count at exit
> net/wireless/core.h:191:9: warning: context imbalance in 'cfg80211_wext_siwscan' - unexpected unlock
> net/wireless/core.h:191:9: warning: context imbalance in 'cfg80211_wext_giwscan' - unexpected unlock
> net/wireless/core.h:191:9: warning: context imbalance in 'nl80211_finish_netdev_dump' - unexpected unlock
> net/wireless/nl80211.c:901:12: warning: context imbalance in 'nl80211_set_wiphy' - different lock contexts for basic block
> net/wireless/core.h:191:9: warning: context imbalance in 'nl80211_pre_doit' - unexpected unlock
> net/wireless/core.h:191:9: warning: context imbalance in 'nl80211_post_doit' - unexpected unlock

And this is the patch I used for testing. There may still be some flaws in it,
but it seems to do the trick.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index f363bc8..d4940af 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -14,6 +14,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/linkage.h>
 #include <linux/lockdep.h>
+#include <linux/compiler.h>
 
 #include <asm/atomic.h>
 
@@ -131,20 +132,35 @@ static inline int mutex_is_locked(struct mutex *lock)
  * Also see Documentation/mutex-design.txt.
  */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
-extern int __must_check mutex_lock_interruptible_nested(struct mutex *lock,
-					unsigned int subclass);
-extern int __must_check mutex_lock_killable_nested(struct mutex *lock,
-					unsigned int subclass);
-
+extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass)
+				__acquires(lock);
+extern int __must_check __mutex_lock_interruptible_nested(struct mutex *lock,
+						unsigned int subclass);
+extern int __must_check __mutex_lock_killable_nested(struct mutex *lock,
+						unsigned int subclass);
+#define mutex_lock_interruptible_nested(lock, subclass)	({		\
+   int __mutex_ret = __mutex_lock_interruptible_nested(lock, subclass);	\
+   if (!__mutex_ret) __acquire(lock); __mutex_ret; 			\
+})
+#define mutex_lock_killable_nested(lock, subclass)	({		\
+   int __mutex_ret = __mutex_lock_killable_nested(lock, subclass);	\
+   if (!__mutex_ret) __acquire(lock); __mutex_ret; 			\
+})
 #define mutex_lock(lock) mutex_lock_nested(lock, 0)
 #define mutex_lock_interruptible(lock) mutex_lock_interruptible_nested(lock, 0)
 #define mutex_lock_killable(lock) mutex_lock_killable_nested(lock, 0)
 #else
-extern void mutex_lock(struct mutex *lock);
-extern int __must_check mutex_lock_interruptible(struct mutex *lock);
-extern int __must_check mutex_lock_killable(struct mutex *lock);
-
+extern void mutex_lock(struct mutex *lock) __acquires(lock);
+extern int __must_check __mutex_lock_interruptible(struct mutex *lock);
+extern int __must_check __mutex_lock_killable(struct mutex *lock);
+#define mutex_lock_interruptible(lock)	({				\
+   int __mutex_ret = __mutex_lock_interruptible(lock);			\
+   if (!__mutex_ret) __acquire(lock); __mutex_ret; 			\
+})
+#define mutex_lock_killable(lock)	({				\
+   int __mutex_ret = __mutex_lock_killable(lock);			\
+   if (!__mutex_ret) __acquire(lock); __mutex_ret; 			\
+})
 # define mutex_lock_nested(lock, subclass) mutex_lock(lock)
 # define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
 # define mutex_lock_killable_nested(lock, subclass) mutex_lock_killable(lock)
@@ -156,8 +172,16 @@ extern int __must_check mutex_lock_killable(struct mutex *lock);
  *
  * Returns 1 if the mutex has been acquired successfully, and 0 on contention.
  */
-extern int mutex_trylock(struct mutex *lock);
-extern void mutex_unlock(struct mutex *lock);
-extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
+extern int __mutex_trylock(struct mutex *lock);
+#define mutex_trylock(lock)	({					\
+   int __mutex_ret = __mutex_trylock(lock);				\
+   if (__mutex_ret) __acquire(lock); __mutex_ret; 			\
+})
+extern void mutex_unlock(struct mutex *lock) __releases(lock);
+extern int __atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
+#define atomic_dec_and_mutex_lock(cnt, lock)	({			\
+   int __mutex_ret = __atomic_dec_and_mutex_lock(cnt, lock);		\
+   if (__mutex_ret) __acquire(lock); __mutex_ret; 			\
+})
 
 #endif
diff --git a/kernel/mutex.c b/kernel/mutex.c
index 200407c..09b70b7 100644
--- a/kernel/mutex.c
+++ b/kernel/mutex.c
@@ -282,22 +282,22 @@ mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 EXPORT_SYMBOL_GPL(mutex_lock_nested);
 
 int __sched
-mutex_lock_killable_nested(struct mutex *lock, unsigned int subclass)
+__mutex_lock_killable_nested(struct mutex *lock, unsigned int subclass)
 {
 	might_sleep();
 	return __mutex_lock_common(lock, TASK_KILLABLE, subclass, _RET_IP_);
 }
-EXPORT_SYMBOL_GPL(mutex_lock_killable_nested);
+EXPORT_SYMBOL_GPL(__mutex_lock_killable_nested);
 
 int __sched
-mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass)
+__mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass)
 {
 	might_sleep();
 	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE,
 				   subclass, _RET_IP_);
 }
 
-EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
+EXPORT_SYMBOL_GPL(__mutex_lock_interruptible_nested);
 #endif
 
 /*
@@ -366,7 +366,7 @@ __mutex_lock_interruptible_slowpath(atomic_t *lock_count);
  *
  * This function is similar to (but not equivalent to) down_interruptible().
  */
-int __sched mutex_lock_interruptible(struct mutex *lock)
+int __sched __mutex_lock_interruptible(struct mutex *lock)
 {
 	int ret;
 
@@ -379,9 +379,9 @@ int __sched mutex_lock_interruptible(struct mutex *lock)
 	return ret;
 }
 
-EXPORT_SYMBOL(mutex_lock_interruptible);
+EXPORT_SYMBOL(__mutex_lock_interruptible);
 
-int __sched mutex_lock_killable(struct mutex *lock)
+int __sched __mutex_lock_killable(struct mutex *lock)
 {
 	int ret;
 
@@ -393,7 +393,7 @@ int __sched mutex_lock_killable(struct mutex *lock)
 
 	return ret;
 }
-EXPORT_SYMBOL(mutex_lock_killable);
+EXPORT_SYMBOL(__mutex_lock_killable);
 
 static __used noinline void __sched
 __mutex_lock_slowpath(atomic_t *lock_count)
@@ -461,7 +461,7 @@ static inline int __mutex_trylock_slowpath(atomic_t *lock_count)
  * This function must not be used in interrupt context. The
  * mutex must be released by the same task that acquired it.
  */
-int __sched mutex_trylock(struct mutex *lock)
+int __sched __mutex_trylock(struct mutex *lock)
 {
 	int ret;
 
@@ -471,7 +471,7 @@ int __sched mutex_trylock(struct mutex *lock)
 
 	return ret;
 }
-EXPORT_SYMBOL(mutex_trylock);
+EXPORT_SYMBOL(__mutex_trylock);
 
 /**
  * atomic_dec_and_mutex_lock - return holding mutex if we dec to 0
@@ -480,7 +480,7 @@ EXPORT_SYMBOL(mutex_trylock);
  *
  * return true and hold lock if we dec to 0, return false otherwise
  */
-int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock)
+int __atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock)
 {
 	/* dec if we can't possibly hit 0 */
 	if (atomic_add_unless(cnt, -1, 1))
@@ -495,4 +495,4 @@ int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock)
 	/* we hit 0, and we hold the lock */
 	return 1;
 }
-EXPORT_SYMBOL(atomic_dec_and_mutex_lock);
+EXPORT_SYMBOL(__atomic_dec_and_mutex_lock);

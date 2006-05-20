From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH] let sparse warn on &inline_function
Date: Sat, 20 May 2006 17:34:40 +0200
Message-ID: <200605201734.40756.mb@bu3sch.de>
References: <200605201621.48466.mb@bu3sch.de> <446F3149.4060606@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:2203
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750777AbWETPfK
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 May 2006 11:35:10 -0400
In-Reply-To: <446F3149.4060606@knosof.co.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>, linux-sparse@vger.kernel.org

On Saturday 20 May 2006 17:10, you wrote:
> Michael,
> 
> > Let sparse warn, if we take pointers to inline functions.
> 
> I'm not sure if I understand the rationale for wanting to
> do this.
> 
> Is it because you think taking the address will cause
> an actual definition to be created (so its address can be
> assigned) where there might not have been one in the first
> place?

The whole purpose of sparse is to warn on things that are
not invalid to do, but don't make much sense. ;)
It simply does not really make sense to mark something
as "inline" and take pointers to it.

> The inline specifier does not guarantee that the call will
> be inlined.  It is only a hint to the compiler.



> Presumably the address of a function is being taken because
> it is needed.  What is the developer supposed to do instead?
> Rewrite an algorithm?

define the function as outlined.

> Do you have any examples where this warning was useful?

In most (all?) cases declaring a function as inline and taking
a pointer to it afterwards does not make logical sense.

It was originally done to catch things like:

static inline void foobar(void)
{
}
EXPORT_SYMBOL(foobar);

But that does not seem to throw a warning. I am not sure why.

#define __EXPORT_SYMBOL(sym, sec)				\
	extern typeof(sym) sym;					\
	__CRC_SYMBOL(sym, sec)					\
	static const char __kstrtab_##sym[]			\
	__attribute__((section("__ksymtab_strings")))		\
	= MODULE_SYMBOL_PREFIX #sym;                    	\
	static const struct kernel_symbol __ksymtab_##sym	\
	__attribute_used__					\
	__attribute__((section("__ksymtab" sec), unused))	\
	= { (unsigned long)&sym, __kstrtab_##sym }

These are all warnings on linus's git tree on powerpc
with allyesconfig:

arch/powerpc/kernel/module_64.c:255:45: warning: taking address of 'inline' function 'my_r2'
fs/file_table.c:47:31: warning: taking address of 'inline' function 'file_free_rcu'
fs/block_dev.c:1086:16: warning: taking address of 'inline' function 'generic_writepages'
kernel/auditfilter.c:504:22: warning: taking address of 'inline' function 'audit_free_rule_rcu'
kernel/auditfilter.c:850:26: warning: taking address of 'inline' function 'audit_free_rule_rcu'
security/dummy.c:1019:2: warning: taking address of 'inline' function 'dummy_sk_alloc_security'
security/dummy.c:1020:2: warning: taking address of 'inline' function 'dummy_sk_free_security'
security/dummy.c:1025:2: warning: taking address of 'inline' function 'dummy_xfrm_policy_clone_security'
security/dummy.c:1032:2: warning: taking address of 'inline' function 'dummy_key_alloc'
security/dummy.c:1033:2: warning: taking address of 'inline' function 'dummy_key_free'
security/dummy.c:1034:2: warning: taking address of 'inline' function 'dummy_key_permission'
arch/powerpc/oprofile/common.c:77:14: warning: taking address of 'inline' function 'op_powerpc_cpu_stop'
net/8021q/vlan.c:327:23: warning: taking address of 'inline' function 'vlan_dev_get_stats'
sound/core/control.c:1279:18: warning: taking address of 'inline' function 'snd_ctl_ioctl_compat'
net/core/rtnetlink.c:728:33: warning: taking address of 'inline' function 'rtnetlink_rcv_msg'
sound/oss/uart401.c:215:16: warning: taking address of 'inline' function 'uart401_start_read'
sound/oss/uart401.c:216:14: warning: taking address of 'inline' function 'uart401_end_read'
sound/oss/uart401.c:217:11: warning: taking address of 'inline' function 'uart401_kick'
sound/oss/uart401.c:218:19: warning: taking address of 'inline' function 'uart401_buffer_status'
sound/oss/uart6850.c:241:16: warning: taking address of 'inline' function 'uart6850_start_read'
sound/oss/uart6850.c:242:14: warning: taking address of 'inline' function 'uart6850_end_read'
sound/oss/uart6850.c:243:11: warning: taking address of 'inline' function 'uart6850_kick'
sound/oss/uart6850.c:244:13: warning: taking address of 'inline' function 'uart6850_command'
sound/oss/uart6850.c:245:19: warning: taking address of 'inline' function 'uart6850_buffer_status'
sound/oss/v_midi.c:141:12: warning: taking address of 'inline' function 'v_midi_ioctl'
sound/oss/v_midi.c:143:16: warning: taking address of 'inline' function 'v_midi_start_read'
sound/oss/v_midi.c:155:12: warning: taking address of 'inline' function 'v_midi_ioctl'
sound/oss/v_midi.c:157:16: warning: taking address of 'inline' function 'v_midi_start_read'
net/decnet/dn_route.c:147:35: warning: taking address of 'inline' function 'dst_rcu_free'
net/decnet/dn_route.c:153:35: warning: taking address of 'inline' function 'dst_rcu_free'
net/decnet/dn_rules.c:121:22: warning: taking address of 'inline' function 'dn_fib_rule_put_rcu'
sound/pci/ad1889.c:814:12: warning: taking address of 'inline' function 'snd_ad1889_ac97_write'
sound/pci/ad1889.c:815:11: warning: taking address of 'inline' function 'snd_ad1889_ac97_read'
sound/pci/ad1889.c:906:15: warning: taking address of 'inline' function 'snd_ad1889_dev_free'
net/ipv4/route.c:490:35: warning: taking address of 'inline' function 'dst_rcu_free'
net/ipv4/route.c:497:35: warning: taking address of 'inline' function 'dst_rcu_free'
net/ipv4/ip_input.c:276:9: warning: taking address of 'inline' function 'ip_local_deliver_finish'
net/ipv4/ip_input.c:432:9: warning: taking address of 'inline' function 'ip_rcv_finish'
net/ipv4/ip_forward.c:107:9: warning: taking address of 'inline' function 'ip_forward_finish'
net/ipv4/ip_output.c:158:9: warning: taking address of 'inline' function 'dst_output'
net/ipv4/ip_output.c:274:9: warning: taking address of 'inline' function 'ip_finish_output'
net/ipv4/ip_output.c:215:27: warning: taking address of 'inline' function 'ip_finish_output2'
net/ipv4/ip_output.c:288:9: warning: taking address of 'inline' function 'ip_finish_output'
net/ipv4/ip_output.c:372:9: warning: taking address of 'inline' function 'dst_output'
net/ipv4/ip_output.c:1263:8: warning: taking address of 'inline' function 'dst_output'
fs/minix/itree_common.c:305:55: warning: taking address of 'inline' function 'get_block'
fs/minix/itree_common.c:305:55: warning: taking address of 'inline' function 'get_block'
drivers/char/ip2/i2lib.c:190:59: warning: taking address of 'inline' function 'iiSendPendingMail'
net/ipv4/raw.c:316:8: warning: taking address of 'inline' function 'dst_output'
net/ipv4/igmp.c:358:9: warning: taking address of 'inline' function 'dst_output'
net/ipv4/igmp.c:691:9: warning: taking address of 'inline' function 'dst_output'
net/ipv4/fib_rules.c:167:22: warning: taking address of 'inline' function 'fib_rule_put_rcu'
net/ipv4/ipmr.c:1231:2: warning: taking address of 'inline' function 'ipmr_forward_finish'
net/ipv4/ipip.c:648:2: warning: taking address of 'inline' function 'dst_output'
net/ipv4/ip_gre.c:885:2: warning: taking address of 'inline' function 'dst_output'
fs/nfsd/export.c:269:12: warning: taking address of 'inline' function 'expkey_match'
fs/nfsd/export.c:270:11: warning: taking address of 'inline' function 'expkey_init'
fs/nfsd/export.c:271:19: warning: taking address of 'inline' function 'expkey_update'
net/ipv4/ah4.c:231:13: warning: taking address of 'inline' function 'ah_hmac_digest'
net/ipv4/ipvs/ip_vs_xmit.c:205:2: warning: taking address of 'inline' function 'dst_output'
net/ipv4/ipvs/ip_vs_xmit.c:281:2: warning: taking address of 'inline' function 'dst_output'
net/ipv4/ipvs/ip_vs_xmit.c:414:2: warning: taking address of 'inline' function 'dst_output'
net/ipv4/ipvs/ip_vs_xmit.c:472:2: warning: taking address of 'inline' function 'dst_output'
net/ipv4/ipvs/ip_vs_xmit.c:545:2: warning: taking address of 'inline' function 'dst_output'
drivers/char/hvc_rtas.c:85:15: warning: taking address of 'inline' function 'hvc_rtas_write_console'
net/ipv4/netfilter/ipt_REJECT.c:211:2: warning: taking address of 'inline' function 'dst_output'
net/ipv4/netfilter/ipt_MASQUERADE.c:136:25: warning: taking address of 'inline' function 'device_cmp'
net/ipv4/netfilter/ipt_MASQUERADE.c:154:25: warning: taking address of 'inline' function 'device_cmp'
net/ipv4/netfilter/ip_queue.c:400:33: warning: taking address of 'inline' function 'id_cmp'
net/ipv4/xfrm4_policy.c:292:10: warning: taking address of 'inline' function 'xfrm4_garbage_collect'
net/ipv4/xfrm4_input.c:175:3: warning: taking address of 'inline' function 'xfrm4_rcv_encap_finish'
net/ipv4/xfrm4_output.c:169:25: warning: taking address of 'inline' function 'dst_output'
net/ipv6/ip6_output.c:145:9: warning: taking address of 'inline' function 'ip6_output_finish'
net/ipv6/ip6_output.c:234:10: warning: taking address of 'inline' function 'dst_output'
net/ipv6/ip6_output.c:422:9: warning: taking address of 'inline' function 'ip6_forward_finish'
net/ipv6/ip6_output.c:1204:8: warning: taking address of 'inline' function 'dst_output'
net/ipv6/ip6_input.c:123:9: warning: taking address of 'inline' function 'ip6_rcv_finish'
net/ipv6/ip6_input.c:217:9: warning: taking address of 'inline' function 'ip6_input_finish'
net/ipv6/sit.c:583:2: warning: taking address of 'inline' function 'dst_output'
lib/zlib_inflate/inflate.c:77:60: warning: taking address of 'inline' function 'zlib_adler32'
net/ipv6/ndisc.c:513:8: warning: taking address of 'inline' function 'dst_output'
net/ipv6/ndisc.c:596:8: warning: taking address of 'inline' function 'dst_output'
net/ipv6/ndisc.c:668:8: warning: taking address of 'inline' function 'dst_output'
net/ipv6/ndisc.c:1482:8: warning: taking address of 'inline' function 'dst_output'
net/ipv6/udp.c:1083:20: warning: taking address of 'inline' function 'udpv6_queue_rcv_skb'
net/ipv6/raw.c:562:8: warning: taking address of 'inline' function 'dst_output'
net/ipv6/raw.c:1068:20: warning: taking address of 'inline' function 'rawv6_rcv_skb'
net/ipv6/mcast.c:1475:8: warning: taking address of 'inline' function 'mld_dev_queue_xmit'
net/ipv6/mcast.c:1455:9: warning: taking address of 'inline' function 'mld_dev_queue_xmit2'
net/ipv6/mcast.c:1810:8: warning: taking address of 'inline' function 'mld_dev_queue_xmit'
net/ipv6/xfrm6_policy.c:304:10: warning: taking address of 'inline' function 'xfrm6_garbage_collect'
net/ipv6/xfrm6_policy.c:320:20: warning: taking address of 'inline' function '_decode_session6'
net/ipv6/xfrm6_output.c:162:25: warning: taking address of 'inline' function 'dst_output'
net/ipv6/ah6.c:366:13: warning: taking address of 'inline' function 'ah_hmac_digest'
net/ipv6/netfilter/ip6_queue.c:398:33: warning: taking address of 'inline' function 'id_cmp'
net/ipv6/netfilter/ip6t_REJECT.c:165:2: warning: taking address of 'inline' function 'dst_output'
net/ipv6/ip6_tunnel.c:749:8: warning: taking address of 'inline' function 'dst_output'
net/netfilter/nfnetlink_queue.c:816:36: warning: taking address of 'inline' function 'id_cmp'
net/sched/sch_fifo.c:87:13: warning: taking address of 'inline' function 'qdisc_dequeue_head'
net/sched/sch_fifo.c:88:13: warning: taking address of 'inline' function 'qdisc_requeue'
net/sched/sch_fifo.c:89:11: warning: taking address of 'inline' function 'qdisc_queue_drop'
net/sched/sch_fifo.c:91:12: warning: taking address of 'inline' function 'qdisc_reset_queue'
net/sched/sch_fifo.c:101:13: warning: taking address of 'inline' function 'qdisc_dequeue_head'
net/sched/sch_fifo.c:102:13: warning: taking address of 'inline' function 'qdisc_requeue'
net/sched/sch_fifo.c:103:11: warning: taking address of 'inline' function 'qdisc_queue_drop'
net/sched/sch_fifo.c:105:12: warning: taking address of 'inline' function 'qdisc_reset_queue'
net/sctp/protocol.c:888:18: warning: taking address of 'inline' function 'sctp_v4_xmit'
net/sched/act_police.c:390:13: warning: taking address of 'inline' function 'tcf_act_police_hash_search'
net/sched/act_gact.c:203:13: warning: taking address of 'inline' function 'tcf_hash_search'
net/sched/act_gact.c:205:11: warning: taking address of 'inline' function 'tcf_generic_walker'
net/sched/act_mirred.c:252:13: warning: taking address of 'inline' function 'tcf_hash_search'
net/sched/act_mirred.c:254:11: warning: taking address of 'inline' function 'tcf_generic_walker'
net/sched/act_ipt.c:313:13: warning: taking address of 'inline' function 'tcf_hash_search'
net/sched/act_ipt.c:315:11: warning: taking address of 'inline' function 'tcf_generic_walker'
net/sched/act_pedit.c:266:13: warning: taking address of 'inline' function 'tcf_hash_search'
net/sched/act_pedit.c:268:11: warning: taking address of 'inline' function 'tcf_generic_walker'
net/sched/act_simple.c:71:2: warning: taking address of 'inline' function 'tcf_defact_dump'
net/sched/act_simple.c:71:2: warning: taking address of 'inline' function 'tcf_defact_cleanup'
net/sched/act_simple.c:71:2: warning: taking address of 'inline' function 'tcf_defact_init'
net/sched/act_simple.c:71:2: warning: taking address of 'inline' function 'tcf_generic_walker'
net/sched/sch_netem.c:553:13: warning: taking address of 'inline' function 'qdisc_dequeue_head'
net/sched/sch_netem.c:554:13: warning: taking address of 'inline' function 'qdisc_requeue'
net/sched/sch_netem.c:555:11: warning: taking address of 'inline' function 'qdisc_queue_drop'
net/sched/sch_netem.c:557:12: warning: taking address of 'inline' function 'qdisc_reset_queue'
net/sunrpc/xprtsock.c:651:18: warning: taking address of 'inline' function 'xs_tcp_copy_data'
net/sunrpc/xprtsock.c:656:14: warning: taking address of 'inline' function 'xs_tcp_copy_data'
drivers/isdn/hisax/avm_a1p.c:250:18: warning: taking address of 'inline' function 'ReadISAC'
drivers/isdn/hisax/avm_a1p.c:251:19: warning: taking address of 'inline' function 'WriteISAC'
drivers/isdn/hisax/avm_a1p.c:252:22: warning: taking address of 'inline' function 'ReadISACfifo'
drivers/isdn/hisax/avm_a1p.c:253:23: warning: taking address of 'inline' function 'WriteISACfifo'
drivers/isdn/hisax/avm_a1p.c:254:21: warning: taking address of 'inline' function 'ReadHSCX'
drivers/isdn/hisax/avm_a1p.c:255:22: warning: taking address of 'inline' function 'WriteHSCX'
drivers/media/radio/radio-maxiradio.c:272:46: warning: taking address of 'inline' function 'radio_function'
drivers/media/radio/radio-maestro.c:263:46: warning: taking address of 'inline' function 'radio_function'
drivers/parport/parport_pc.c:1174:16: warning: taking address of 'inline' function 'parport_pc_write_data'
drivers/parport/parport_pc.c:1175:15: warning: taking address of 'inline' function 'parport_pc_read_data'
drivers/parport/parport_pc.c:1177:19: warning: taking address of 'inline' function 'parport_pc_write_control'
drivers/parport/parport_pc.c:1178:18: warning: taking address of 'inline' function 'parport_pc_read_control'
drivers/parport/parport_pc.c:1179:18: warning: taking address of 'inline' function 'parport_pc_frob_control'
drivers/parport/parport_pc.c:1181:17: warning: taking address of 'inline' function 'parport_pc_read_status'
drivers/parport/parport_pc.c:1183:16: warning: taking address of 'inline' function 'parport_pc_enable_irq'
drivers/parport/parport_pc.c:1184:17: warning: taking address of 'inline' function 'parport_pc_disable_irq'
drivers/parport/parport_pc.c:1186:18: warning: taking address of 'inline' function 'parport_pc_data_forward'
drivers/parport/parport_pc.c:1187:18: warning: taking address of 'inline' function 'parport_pc_data_reverse'
drivers/media/video/video-buf.c:391:36: warning: taking address of 'inline' function 'pci_map_sg'
drivers/media/video/video-buf.c:394:41: warning: taking address of 'inline' function 'pci_dma_sync_sg_for_cpu'
drivers/media/video/video-buf.c:396:38: warning: taking address of 'inline' function 'pci_unmap_sg'
drivers/media/video/video-buf.c:405:32: warning: taking address of 'inline' function 'pci_map_sg'
drivers/media/video/video-buf.c:406:34: warning: taking address of 'inline' function 'pci_unmap_sg'
drivers/media/video/video-buf.c:418:32: warning: taking address of 'inline' function 'pci_map_sg'
drivers/media/video/video-buf.c:419:34: warning: taking address of 'inline' function 'pci_unmap_sg'
drivers/net/wan/hdlc_fr.c:1088:19: warning: taking address of 'inline' function 'pvc_get_stats'
drivers/scsi/megaraid/megaraid_sas.c:196:14: warning: taking address of 'inline' function 'megasas_fire_cmd_xscale'
drivers/scsi/megaraid/megaraid_sas.c:197:17: warning: taking address of 'inline' function 'megasas_enable_intr_xscale'
drivers/scsi/megaraid/megaraid_sas.c:276:14: warning: taking address of 'inline' function 'megasas_fire_cmd_ppc'
drivers/scsi/megaraid/megaraid_sas.c:277:17: warning: taking address of 'inline' function 'megasas_enable_intr_ppc'
drivers/net/sungem.c:3076:26: warning: taking address of 'inline' function '_phy_read'
drivers/net/sungem.c:3077:27: warning: taking address of 'inline' function '_phy_write'
drivers/net/sis190.c:607:20: warning: taking address of 'inline' function 'pci_dma_sync_single_for_device'
drivers/net/sis190.c:625:18: warning: taking address of 'inline' function 'pci_unmap_single'
drivers/net/ns83820.c:1854:2: warning: taking address of 'inline' function 'queue_refill'
drivers/net/via-velocity.c:1413:15: warning: taking address of 'inline' function 'pci_dma_sync_single_for_device'
drivers/net/via-velocity.c:1419:16: warning: taking address of 'inline' function 'pci_unmap_single'
drivers/w1/slaves/w1_therm.c:101:15: warning: taking address of 'inline' function 'w1_DS18S20_convert_temp'
drivers/w1/slaves/w1_therm.c:105:15: warning: taking address of 'inline' function 'w1_DS18B20_convert_temp'
drivers/w1/slaves/w1_therm.c:109:15: warning: taking address of 'inline' function 'w1_DS18B20_convert_temp'
drivers/net/mv643xx_eth.c:791:25: warning: taking address of 'inline' function 'mv643xx_eth_rx_refill_descs_timer_wrapper'
drivers/net/r8169.c:2443:20: warning: taking address of 'inline' function 'pci_dma_sync_single_for_device'
drivers/net/r8169.c:2465:18: warning: taking address of 'inline' function 'pci_unmap_single'

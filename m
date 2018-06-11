From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Date: Mon, 11 Jun 2018 12:00:57 -0400
Message-ID: <20180611120057.5391dfc6@vmware.local.home>
References: <1528186420-6615-5-git-send-email-changbin.du@intel.com>
        <201806101929.E2oiistg%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201806101929.E2oiistg%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: changbin.du@intel.com, kbuild-all@01.org, mingo@redhat.com, akpm@linux-foundation.org, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, rdunlap@infradead.org, x86@kernel.org, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, changbin.du@gmail.com
List-Id: linux-sparse@vger.kernel.org

On Sun, 10 Jun 2018 23:49:55 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Changbin,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.17 next-20180608]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/changbin-du-intel-com/kernel-hacking-GCC-optimization-for-better-debug-experience-Og/20180606-001415
> config: i386-randconfig-x076-06101602 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers//usb/typec/fusb302/fusb302.c: In function 'fusb302_handle_togdone_src':
> >> drivers//usb/typec/fusb302/fusb302.c:1413:10: warning: 'ra_comp' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>      else if (ra_comp)
>              ^

This is a false warning. I'm surprised gcc couldn't catch it. Although
that code looks like it could have been  done a bit nicer.


> --
>    drivers/infiniband/ulp/ipoib/ipoib_main.c: In function 'ipoib_get_netdev':
> >> drivers/infiniband/ulp/ipoib/ipoib_main.c:2021:30: warning: 'dev' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>      if (!hca->alloc_rdma_netdev || PTR_ERR(dev) == -EOPNOTSUPP)
> --

Strange, this is also false, with the same construct.

	if (a) {
		b = init;
	}
	if (!a) {
		use b;

It warns that b may be unused. I'm guessing the extra option we add in
gcc by the patch causes gcc to break in this regard.



>    kernel//cgroup/cgroup-v1.c: In function 'cgroup1_mount':
> >> kernel//cgroup/cgroup-v1.c:1268:3: warning: 'root' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>       percpu_ref_reinit(&root->cgrp.self.refcnt);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --

Slightly different construct, but similar:

	ret = func();
	if (ret)
		goto out_unlock;

	root = init;

 out_unlock:

	if (ret)
		return;

	use root;



>    kernel//trace/bpf_trace.c: In function 'bpf_trace_printk':
> >> kernel//trace/bpf_trace.c:226:20: warning: 'unsafe_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>               (void *) (long) unsafe_addr,
>                        ^~~~~~~~~~~~~~~~~~

Again similar:

	if (fmt_cnt >= 3)
		return;

	switch (fmt_cnt) {
	case 1:
		unsafe_addr = init;
		break;
	case 2:
		unsafe_addr = init2;
		break;
	case 3:
		unsafe_addr = init3;
		break;
	}

	use init;


>    kernel//trace/bpf_trace.c:170:6: note: 'unsafe_addr' was declared here
>      u64 unsafe_addr;
>          ^~~~~~~~~~~
> --
>    net//6lowpan/iphc.c: In function 'lowpan_header_decompress':
>    net//6lowpan/iphc.c:617:12: warning: 'iphc1' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      u8 iphc0, iphc1, cid = 0;
>                ^~~~~
> >> net//6lowpan/iphc.c:617:5: warning: 'iphc0' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>      u8 iphc0, iphc1, cid = 0;
>         ^~~~~

Similar but crazier:

	if (lowpan_fetch_skb(&iphc0) ||
	    lowpan_fetch_skb(&iphc1))
		return;

	use iphc0 and ipch1;

where lowpan_fetch_skb() is:

	if (test())
		return true;

	init data (iphc0 or iphc1);
	return false;


> --
>    net//netfilter/nf_tables_api.c: In function 'nf_tables_dump_set':
> >> net//netfilter/nf_tables_api.c:3625:2: warning: 'set' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>      set->ops->walk(&dump_ctx->ctx, set, &args.iter);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I don't have the same kernel, as this doesn't match. But I'm sure it's
a false positive like the others.


> --
>    drivers/media/dvb-frontends/mn88472.c: In function 'mn88472_set_frontend':
> >> drivers/media/dvb-frontends/mn88472.c:339:27: warning: 'bandwidth_vals_ptr' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>             bandwidth_vals_ptr[i]);
>                               ^
> >> drivers/media/dvb-frontends/mn88472.c:320:8: warning: 'bandwidth_val' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>      ret = regmap_write(dev->regmap[2], 0x04, bandwidth_val);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This one may not be a false positive. It really looks like there's a
path to that being used uninitialized. But I haven't torn that function
apart enough to really tell, but I don't fault gcc for not warning
about it. But I like to know if gcc doesn't warn without this patch?


> --
>    drivers/media/dvb-frontends/mn88473.c: In function 'mn88473_set_frontend':
> >> drivers/media/dvb-frontends/mn88473.c:162:7: warning: 'conf_val_ptr' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>       ret = regmap_bulk_write(dev->regmap[1], 0x10, conf_val_ptr, 6);
>       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Same as the one before it. Need to see if this isn't really a real
issue.

> --
>    net//netfilter/ipvs/ip_vs_sync.c: In function 'ip_vs_sync_conn':
> >> net//netfilter/ipvs/ip_vs_sync.c:731:13: warning: 'm' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>      m->nr_conns++;
>      ~~~~~~~~~~~^~

gcc is really stupid on this one.

	if (buff)
		init m;
	if (!buff)
		init m;

	use m;

Really?

> --
>    drivers//hwspinlock/hwspinlock_core.c: In function 'of_hwspin_lock_get_id':
> >> drivers//hwspinlock/hwspinlock_core.c:339:19: warning: 'id' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>      return ret ? ret : id;
>             ~~~~~~~~~~^~~~


Again, we jump here without initializing 'id' when ret is set.


> --
>    drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c: In function 'mlxsw_sp_nexthop_group_update':
> >> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3078:7: warning: 'err' may be used uninitialized in this function [-Wmaybe-uninitialized]  
>        if (err)
>           ^
> 
> vim +/ra_comp +1413 drivers//usb/typec/fusb302/fusb302.c
> 


Another switch statement false positive:

	nh->type can only be set to two different values, and then we
	have:

	switch (nh->type) {
	case value1:
		err = func();
		break;
	case value2:
		err = func2();
		break;
	}
	if (err)


Of all the warnings, only one looks like it could be a possible issue.
Thus, this patch causes gcc to fail more on it analysis. The one
possible issue should have been caught by gcc without this patch, so
I'm skeptical that it is indeed an issue, but it's complex and I am
impressed if gcc really did figure it out.

-- Steve

From: Randy Dunlap <rdunlap@xenotime.net>
Subject: linux kernel warnings/errors
Date: Tue, 23 Feb 2010 11:49:06 -0800
Message-ID: <20100223114906.61d4e001.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:44316 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751411Ab0BWTtK (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Feb 2010 14:49:10 -0500
Received: from chimera.site ([71.245.98.113]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 23 Feb 2010 11:49:06 -0800
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

You probably know that sparse produces a ton of errors & warnings when
run on the Linux kernel tree (a little over 1 MB in my latest 'make C=1'
on x86_64 arch.).

I'm wondering if all of these are valid.

Examples:


1.  Use of the BUILD_BUG_ON() macro causes this error from sparse:

arch/x86/kernel/paravirt.c:101:9: error: invalid bitfield width, -1.

include/linux/kernel.h:

/* Force a compilation error if condition is true */
#define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))

/* Force a compilation error if condition is true, but also produce a
   result (of value 0 and type size_t), so the expression can be used
   e.g. in a structure initializer (or where-ever else comma expressions
   aren't permitted). */
#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))


2.  drivers/block/drbd/drbd_int.h uses __protected_by(var);
this seems to be unknown to sparse.

#ifdef __CHECKER__
# define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))

sparse says many times:

drivers/block/drbd/drbd_int.h:887:39: error: attribute 'require_context': unknown attribute


3.  I don't see the problem here -- maybe it's simple (or maybe it's
related to BUILD_BUG_ON stuff):

drivers/char/ipmi/ipmi_watchdog.c:291:1: error: cannot dereference this type

referring to:

module_param_call(action, set_param_str, get_param_str, action_op, 0644);

which comes from include/linux/moduleparam.h


4.  from include/linux/swab.h:

include/linux/swab.h:51:16: warning: unreplaced symbol 'val'
include/linux/swab.h:51:16: warning: unreplaced symbol 'val'
include/linux/swab.h:51:9: warning: unreplaced symbol 'return'

referring to:

static inline __attribute_const__ __u16 __fswab16(__u16 val)
{
#ifdef __arch_swab16
	return __arch_swab16(val);
#else
	return ___constant_swab16(val);
#endif
}


5.  sparse reports (maybe correctly?):

include/linux/skbuff.h:357:41: error: invalid bitfield specifier for type restricted __be16.

on struct sk_buff, this line:

	__be16			protocol:16;


6.  sparse reports:

drivers/usb/gadget/zero.c:166:9: warning: advancing past deep designator

on

static struct usb_string strings_dev[] = {
	[STRING_MANUFACTURER_IDX].s = manufacturer,
	[STRING_PRODUCT_IDX].s = longname,
	[STRING_SERIAL_IDX].s = serial,
	{  }			/* end of list */
};

Is that an improper initializer?  The sparse warning doesn't mean much to me.



Thanks for listening, insights, etc.

---
~Randy

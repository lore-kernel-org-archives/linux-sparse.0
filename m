From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux kernel warnings/errors
Date: Tue, 23 Feb 2010 14:20:49 -0800
Message-ID: <4B8454C1.6010402@xenotime.net>
References: <20100223114906.61d4e001.rdunlap@xenotime.net> <20100223205942.GA32491@feather>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060107030101060204000403"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:46718 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754334Ab0BWWUv (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Feb 2010 17:20:51 -0500
Received: from chimera.site ([71.245.98.113]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 23 Feb 2010 14:20:50 -0800
In-Reply-To: <20100223205942.GA32491@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.
--------------060107030101060204000403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 02/23/10 12:59, Josh Triplett wrote:
> On Tue, Feb 23, 2010 at 11:49:06AM -0800, Randy Dunlap wrote:
>> Hi,
>>
>> You probably know that sparse produces a ton of errors & warnings when
>> run on the Linux kernel tree (a little over 1 MB in my latest 'make C=1'
>> on x86_64 arch.).
>>
>> I'm wondering if all of these are valid.
>>
>> Examples:
>>
>>
>> 1.  Use of the BUILD_BUG_ON() macro causes this error from sparse:
>>
>> arch/x86/kernel/paravirt.c:101:9: error: invalid bitfield width, -1.
>>
>> include/linux/kernel.h:
>>
>> /* Force a compilation error if condition is true */
>> #define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))
>>
>> /* Force a compilation error if condition is true, but also produce a
>>    result (of value 0 and type size_t), so the expression can be used
>>    e.g. in a structure initializer (or where-ever else comma expressions
>>    aren't permitted). */
>> #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
> 
> In theory that should only happen if the BUILD_BUG_ON_ZERO actually
> triggers, and thus sparse fails to build just as GCC would.  If sparse
> has this problem and GCC doesn't, could you please provide a minimal
> test case?

Sure, attached.


>> 2.  drivers/block/drbd/drbd_int.h uses __protected_by(var);
>> this seems to be unknown to sparse.
>>
>> #ifdef __CHECKER__
>> # define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
>>
>> sparse says many times:
>>
>> drivers/block/drbd/drbd_int.h:887:39: error: attribute 'require_context': unknown attribute
> 
> That looks broken.  A few patches went around for new Sparse
> context-tracking features, one of which got reverted before the 0.4.2
> release, but I don't think any of them would have allowed *that*.

Yeah, I recall seeing some of the context patches.

Thanks.
-- 
~Randy

--------------060107030101060204000403
Content-Type: text/x-csrc;
 name="build_bug_on.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="build_bug_on.c"

/* Force a compilation error if condition is true */
#define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))

/* Force a compilation error if condition is true, but also produce a
   result (of value 0 and type size_t), so the expression can be used
   e.g. in a structure initializer (or where-ever else comma expressions
   aren't permitted). */
#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))

struct branch {
	unsigned char opcode;
	int delta;
} __attribute__((packed));

unsigned paravirt_patch_call(void *insnbuf)
{
	struct branch *b = insnbuf;

	b->opcode = 0xe8; /* call */
	b->delta = 0x1234;
	BUILD_BUG_ON(sizeof(*b) != 5);

	return 5;
}

int main(int argc, char *argv[])
{
}

--------------060107030101060204000403--

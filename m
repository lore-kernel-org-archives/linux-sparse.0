From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH] Null ctype should have ptr_ctype as its base type.
Date: Sun, 28 Dec 2008 18:14:03 +0300
Message-ID: <20081228151134.6062.83633.stgit@zaytsev.su>
References: <20081225182817.26024.19045.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:45216 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbYL1PEp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Dec 2008 10:04:45 -0500
Received: by nf-out-0910.google.com with SMTP id d3so549948nfc.21
        for <linux-sparse@vger.kernel.org>; Sun, 28 Dec 2008 07:04:43 -0800 (PST)
In-Reply-To: <20081225182817.26024.19045.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Tommy Thorn <tommy@numba-tu.com>

Amirite?

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---

On Thu, Dec 25, 2008 at 21:36, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
> Tommy Thorn wrote:
>> Christopher Li wrote:
>>> So here is what I got. A patch address both of our need. It gives warning
>>> of using sizeof(void) explicitly. void* + offset will continue to work without
>>> warnings. It will also make is_byte_type() continue to work as it was
>>> before.
>>>
>>> Here is my test script:
>>>
>>> void *p;
>>>
>>> int i = sizeof(void);
>>> int j = sizeof(*p);
>>>
>
>> I can't test it right now, but does it give a warning for both sizeof's
>> above? If just first results in a warning, then I think that quite
>> reasonable.
>
> Both trigger the warning. I'm not sure this is a problem, as there are
> no such usage cases in the kernel.
>
> I added (hopefully the right way) handling of (sizeof(function)) to the
> patch. function++ was already prohibited.
>
> Running the test on the kernel right now.
>

And it found something.

2158a2159
> fs/compat_ioctl.c:787:10: warning: expression using sizeof on a function
9524a9526,9543
> drivers/media/video/gspca/sonixb.c:494:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:494:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:494:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:495:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:495:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:495:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:496:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:498:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:498:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:498:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:500:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:500:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:502:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:502:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:502:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:504:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:504:1: warning: expression using sizeof(void)
> drivers/media/video/gspca/sonixb.c:504:1: warning: expression using sizeof(void)
15293a15313,15325
> net/netfilter/nf_conntrack_sip.c:282:21: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:282:21: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:287:23: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:287:23: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:288:29: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:586:23: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:586:23: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:587:25: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:588:29: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:589:25: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:590:29: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:591:22: warning: expression using sizeof(void)
> net/netfilter/nf_conntrack_sip.c:591:22: warning: expression using sizeof(void)

The first one is

        if (copy_in_user(&sgio->status, sgio32->status,
                         (4 * sizeof(unsigned char)) +
                         (2 * sizeof(unsigned (short))) +       <------- oops
                         (3 * sizeof(int))))
                return -EFAULT;

a bug. So, if anyone ever missed his sgio.info, now we know why.
Patch sent.

drivers/media/video/gspca/sonixb.c looks like

SENS(initHv7131, NULL, hv7131_sensor_init, NULL, NULL, 0, NO_EXPO|NO_FREQ, 0),

#define SENS(bridge_1, bridge_3, sensor, sensor_1, \
        sensor_3, _flags, _ctrl_dis, _sensor_addr) \
{ \
        .bridge_init = { bridge_1, bridge_3 }, \
        .bridge_init_size = { sizeof(bridge_1), sizeof(bridge_3) }, \

So, we are getting a sizeof(NULL), or a sizeof((void *)0). It triggers here
because we are getting a null_ctype, and it's base_type points to
void_ctype. I'm not sure if this patch is correct, but it seems to do
the trick, all void warnings are gone. Christopher?

 symbol.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/symbol.c b/symbol.c
index 4da253b..df760d4 100644
--- a/symbol.c
+++ b/symbol.c
@@ -861,7 +861,7 @@ static const struct ctype_declare {
 
 	{ &string_ctype,    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &char_ctype },
 	{ &ptr_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
-	{ &null_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
+	{ &null_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &ptr_ctype  },
 	{ &label_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
 	{ &lazy_ptr_ctype,  SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
 	{ NULL, }


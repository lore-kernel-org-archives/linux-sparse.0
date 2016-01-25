From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] sparse: add support for static assert
Date: Mon, 25 Jan 2016 19:48:06 +0100
Message-ID: <20160125184804.GA43341@macpro.local>
References: <1452551482-1250-1-git-send-email-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35228 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757945AbcAYSsJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 13:48:09 -0500
Received: by mail-wm0-f68.google.com with SMTP id 123so13005959wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 10:48:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452551482-1250-1-git-send-email-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Jan 11, 2016 at 05:31:22PM -0500, Lance Richardson wrote:


Hi,

I don't understand why tha parsing part have changed so much since v1.
Is it because I said
   > It seems a bit strange to me to use NS_TYPEDEF, as this is unrelated types.
   > OTOH, the other namespaces deosn't seems better suited,
   > and yes C11 define this as sort of declaration, so ...
or because something related to handling it inside structs and unions or
for some other reason?

If because of the NS_TYPEDEF thing, sorry if I wasn't clear but I really think
it was fine, just that at first sight I found it strange.
If because the structs & unions, please explain why is it needed, what was wrong
with v1 and is fine now.


> diff --git a/validation/static_assert.c b/validation/static_assert.c
> new file mode 100644
> index 0000000..d3da954
> --- /dev/null
> +++ b/validation/static_assert.c
...
> +struct s2 {
> +	char c;
> +	_Static_assert(sizeof(struct s2) == 1, "struct sizeof");
> +};

This succeed but
	struct s2 {
		char c;
		_Static_assert(sizeof(struct s2) == 1, "struct sizeof");
		char d;
		_Static_assert(sizeof(struct s2) == 2, "struct sizeof");
	};
succeed also wich seems certainly very odd.

However it's not a problem with your patch but because of:
1) sparse is fine with the evaluation of sizeof(struct ...) while the struct
   is not yet completed (which is maybe usefull but certainly can also be
   considered as a bug)
2) those assertions are evaluated at parse time and not at some later time.
   My first thought was that we really should move the checking of those
   assertions at a later time, maybe after linearization and by introducing
   a new operation for it (like OP_ASSERT or so).
   But this is not a solution for the assertions inside structs & unions.
   I'll add a separate test case showing the problem and it's probably better
   to not put this test in your test cases.

Regards,
Luc

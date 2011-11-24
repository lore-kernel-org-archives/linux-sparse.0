From: Pekka Enberg <penberg@kernel.org>
Subject: Re: cannot size expression - exported array in kernel
Date: Thu, 24 Nov 2011 09:29:54 +0200
Message-ID: <CAOJsxLEgV4v0rVPb1O63T-p+Nj++kkE4dh2L3k_a2XGqptnVeQ@mail.gmail.com>
References: <1321870017.3999.31.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48719 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab1KXH3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Nov 2011 02:29:55 -0500
Received: by vcbfk14 with SMTP id fk14so1091421vcb.19
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2011 23:29:54 -0800 (PST)
In-Reply-To: <1321870017.3999.31.camel@jlt3.sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>

On Mon, Nov 21, 2011 at 12:06 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Here's some code from net/wireless/util.c, expressed as a test case. =
I
> have no idea how to fix it. The actual output is:
>
> +sizeof-external.c:11:16: error: cannot size expression
>
> while none is expected.
>
> johannes
>
> /***** begin file validation/sizeof-external.c **** */
> /* #include file that declares it */
> extern const unsigned char bridge_tunnel_header[6];
>
> /* define it */
> const unsigned char bridge_tunnel_header[] =3D { 1, 2, 3, 4, 5, 6 };
> /* EXPORT_SYMBOL it */
> extern typeof(bridge_tunnel_header) bridge_tunnel_header; /* ... */
>
> static int bth_size(void)
> {
> =A0 =A0 =A0 =A0return sizeof(bridge_tunnel_header);
> }
>
> /*
> =A0* check-name: Check sizeof(kernel_exported_external_variable)
> =A0*
> =A0* check-error-start
> =A0* check-error-end
> =A0*/.

I'm not really an expert in the sparse front-end either. Looking at
your test case, evaluate_sizeof() returns -1 which suggests
examine_symbol_type() doesn't handle typeof(bridge_tunnel_header)
properly.

                                Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

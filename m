From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fixing "cast truncates bits from constant value"
Date: Tue, 18 Aug 2009 22:36:53 -0700
Message-ID: <70318cbf0908182236h21c5d342o15bb658a445fc476@mail.gmail.com>
References: <1250542922.10511.38.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:55272 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbZHSFgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 19 Aug 2009 01:36:52 -0400
Received: by vws2 with SMTP id 2so3567490vws.4
        for <linux-sparse@vger.kernel.org>; Tue, 18 Aug 2009 22:36:53 -0700 (PDT)
In-Reply-To: <1250542922.10511.38.camel@mj>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Aug 17, 2009 at 2:02 PM, Pavel Roskin<proski@gnu.org> wrote:
> static unsigned short test(void)
> {
> =A0 =A0 =A0 =A0return (unsigned short)~0x8000;
> }
>
> test.c:3:32: warning: cast truncates bits from constant value (ffff7f=
ff
> becomes 7fff)

That warning is legit because you ARE truncating constant value here.

> In my opinion, an explicit cast should be enough to suppress the
> warning. =A0But it's not. =A0Moreover, it's a "superwarning" that can=
not
> even be suppressed by the "force" attribute! =A0This source still
> generates a warning:
>
> static unsigned short test(void)
> {
> =A0 =A0 =A0 =A0return (__attribute__((force)) unsigned short)~0x8000;

Sparse currently does not thing than just mark it as forced.


>
> But this source doesn't:
>
> static unsigned short test(void)
> {
> =A0 =A0 =A0 =A0return 0xfffff000U;
> }

I think sparse consider it as signed extend.
Truncating all 0xffff is consider OK for the negative case.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC][PATCH] fix casting constant to _Bool
Date: Sat, 16 Jun 2012 19:59:41 +0300
Message-ID: <20120616165941.GG4400@mwanda>
References: <1339829720-2069-1-git-send-email-xi.wang@gmail.com>
 <CA+55aFwTyqQ5WBL7b8fbCeBhM_sumQXc-SaKSzwOcwk431Vf9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:30702 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab2FPRAF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Jun 2012 13:00:05 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwTyqQ5WBL7b8fbCeBhM_sumQXc-SaKSzwOcwk431Vf9g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Wang <xi.wang@gmail.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On Sat, Jun 16, 2012 at 09:32:50AM -0700, Linus Torvalds wrote:
> On Fri, Jun 15, 2012 at 11:55 PM, Xi Wang <xi.wang@gmail.com> wrote:
> > Casting to _Bool requires a zero test rather than truncation.
>=20
> Ack. _Bool is very special (and rather non-C-like).
>=20
> > BTW, this patch also disables the warning "cast truncates bits from
> > constant value". =A0Does that sound good?
>=20
> For cast to _Bool, that is correct. Since it doesn't truncate the
> value, the upper bits are not ignored as they are with other casts.
>=20

It's pretty rare to see a cast to bool that truncates the value.
My feeling is that most times they are bugs.  I just saw one of
these a couple weeks ago:

http://www.spinics.net/lists/linux-iio/msg05573.html

I wish the error message could be fixed so it says 1 instead of 0.

old: warning: cast truncates bits from constant value (2 becomes 0)
new: warning: cast truncates bits from constant value (2 becomes 1)

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

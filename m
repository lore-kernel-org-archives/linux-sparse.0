From: Pavel Roskin <proski@gnu.org>
Subject: Re: Fixing "cast truncates bits from constant value"
Date: Wed, 19 Aug 2009 19:28:07 -0400
Message-ID: <1250724487.23170.72.camel@mj>
References: <1250542922.10511.38.camel@mj>
	 <70318cbf0908182236h21c5d342o15bb658a445fc476@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:5056 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643AbZHSX2I (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 19 Aug 2009 19:28:08 -0400
In-Reply-To: <70318cbf0908182236h21c5d342o15bb658a445fc476@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Tue, 2009-08-18 at 22:36 -0700, Christopher Li wrote:
> On Mon, Aug 17, 2009 at 2:02 PM, Pavel Roskin<proski@gnu.org> wrote:
> > static unsigned short test(void)
> > {
> >        return (unsigned short)~0x8000;
> > }
> >
> > test.c:3:32: warning: cast truncates bits from constant value (ffff7fff
> > becomes 7fff)
> 
> That warning is legit because you ARE truncating constant value here.

I believe it's not, as it's an explicit cast.  Sure, it's debatable
whether users want to be warned about it.  But suppose we keep the
warning.  What would be the fix for the above code?  The only fix I can
think of would be to use AND with 0xffff:

static unsigned short test(void)
{
      return (unsigned short)(0xffff & ~0x8000);
}

I think it's ugly.  And that's what b43 developers think, so the sparce
warning remains unfixed.

> > In my opinion, an explicit cast should be enough to suppress the
> > warning.  But it's not.  Moreover, it's a "superwarning" that cannot
> > even be suppressed by the "force" attribute!  This source still
> > generates a warning:
> >
> > static unsigned short test(void)
> > {
> >        return (__attribute__((force)) unsigned short)~0x8000;
> 
> Sparse currently does not thing than just mark it as forced.

The whole point of having that attribute is to suppress warnings.

> > But this source doesn't:
> >
> > static unsigned short test(void)
> > {
> >        return 0xfffff000U;
> > }
> 
> I think sparse consider it as signed extend.
> Truncating all 0xffff is consider OK for the negative case.

That's wrong, as there are no signed integers involved in the above
example.

-- 
Regards,
Pavel Roskin

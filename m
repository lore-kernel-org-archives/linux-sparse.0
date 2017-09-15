From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Fri, 15 Sep 2017 07:09:38 +0200
Message-ID: <20170915050938.sx2rt4mlbcc7sr4s@ltop.local>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
 <20170914201741.lmzdhwlbi2jo2pfw@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35946 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdIOFJk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 01:09:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id r136so1754802wmf.3
        for <linux-sparse@vger.kernel.org>; Thu, 14 Sep 2017 22:09:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170914201741.lmzdhwlbi2jo2pfw@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Sep 14, 2017 at 10:17:42PM +0200, Uwe Kleine-König wrote:
> On Thu, Sep 14, 2017 at 10:03:27PM +0200, Uwe Kleine-König wrote:
> > ---
> >  cgcc | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/cgcc b/cgcc
> > index a8d7b4f217fe..0ab54f943578 100755
> > --- a/cgcc
> > +++ b/cgcc
> > @@ -235,6 +235,9 @@ sub add_specs {
> >      } elsif ($spec eq 'linux') {
> >  	return &add_specs ('unix') .
> >  	    ' -D__linux__=1 -D__linux=1 -Dlinux=linux';
> > +    } elsif ($spec eq 'gnu/kfreebsd') {
> > +	return &add_specs ('unix') .
> > +	    ' -D__FreeBSD_kernel__=1'
> >      } elsif ($spec eq 'openbsd') {
> >  	return &add_specs ('unix') .
> >  	    ' -D__OpenBSD__=1';
> 
> Alternatively to adding support for all platforms by hand, why not
> use the output of
> 
> 	cpp -dM < /dev/null
> 
> to get the predefined macros? On my Linux amd64 box it gives quite a
> list, but I think this doesn't hurt, does it?

The problem I see by doing this is that some or lots of these
predefined macros mean, directly or not, "we support this feature"
while sparse in fact doesn't support it.

It already can create problems of defining the __GCC__/__GCC_MINOR__,
thus pretending to be this GCC version.

OTOH, I already begun to extend sparse's own predefined macros.
You can check it by looking at the output of:
	sparse -E -dD - < /dev/null

So, I think it's best to:
- not adding the output of cpp -dM to cgcc
- continue to add to sparse itself any predefined macro
  that would be needed
- for the moment, keep cgcc for dealing with arch specificities
- later we can add something like a '-m<arch>' flag to sparse itself
  (but most probably we'll need to ue the full triplet, or use a config
  file or ...)


Best regards,
-- Luc Van Oostenryck

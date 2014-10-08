From: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH v2] sparse: Make -Werror turn warnigns into errors
Date: Wed, 8 Oct 2014 10:39:10 +0100
Message-ID: <20141008093910.GB3181@casper.infradead.org>
References: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
 <20141007094508.GN23154@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60368 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbaJHJjQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Oct 2014 05:39:16 -0400
Content-Disposition: inline
In-Reply-To: <20141007094508.GN23154@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-sparse@vger.kernel.org, sparse@chrisli.org

On 10/07/14 at 12:45pm, Dan Carpenter wrote:
> > diff --git a/cgcc b/cgcc
> > index c075e5f..204bda3 100755
> > --- a/cgcc
> > +++ b/cgcc
> > @@ -70,7 +70,7 @@ if ($do_check) {
> >  
> >      print "$check\n" if $verbose;
> >      if ($do_compile) {
> > -	system ($check);
> > +	system ($check) == 0 or die;
> 
> This just enables -Werror for everyone so now I can't run Sparse on
> itself now because there are old errors from 2007.

The above change should merely have sparse fail upon an error and not
warnings unless you specifiy -Werror which I would consider expected
behaviour.

> lib.c:192:6: error: symbol 'error_die' redeclared with different type (originally declared at lib.h:97) - different modifiers
> lib.c:201:6: error: symbol 'die' redeclared with different type (originally declared at lib.h:93) - different modifiers
> 
> Btw, these errors also disable warnings for the rest of the file...  I
> don't think just because there are different modifiers it means that
> we should give up looking for other warnings.  In the kernel we miss
> some endian bugs because of this.



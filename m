From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] sparse: Make -Werror turn warnigns into errors
Date: Wed, 8 Oct 2014 22:27:21 +0300
Message-ID: <20141008192721.GS23154@mwanda>
References: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
 <20141007094508.GN23154@mwanda>
 <CANeU7Q==hANeGNEK3f-_LnNa-msVQgPa=mnk4k0qkuz5s=_K+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47772 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbaJHT2E (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Oct 2014 15:28:04 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Q==hANeGNEK3f-_LnNa-msVQgPa=mnk4k0qkuz5s=_K+w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Thomas Graf <tgraf@suug.ch>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 08, 2014 at 06:26:23PM +0800, Christopher Li wrote:
> On Tue, Oct 7, 2014 at 5:45 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >> +     system ($check) == 0 or die;
> >
> > This just enables -Werror for everyone so now I can't run Sparse on
> > itself now because there are old errors from 2007.
> >
> > lib.c:192:6: error: symbol 'error_die' redeclared with different type (originally declared at lib.h:97) - different modifiers
> > lib.c:201:6: error: symbol 'die' redeclared with different type (originally declared at lib.h:93) - different modifiers
> 
> It depend on how you invoke sparse.
> Do you invoke sparse by some thing like "make CC=./cgcc"?

Yes.  In my makefile I have:

ifeq ($(CC),"")
CC = gcc
endif

> 
> >
> > Btw, these errors also disable warnings for the rest of the file...  I
> > don't think just because there are different modifiers it means that
> > we should give up looking for other warnings.  In the kernel we miss
> > some endian bugs because of this.
> 
> Are you suggesting change that type different error into warnings so
> sparse can still check the rest of the file?

Let me look at this more closely again and write some patches.

regards,
dan carpenter


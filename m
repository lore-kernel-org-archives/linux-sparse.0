From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: [PATCH] trivial: disable sparse' warning for "potentially
 expensive pointer subtraction".
Date: Thu, 23 Sep 2010 14:41:43 +0200
Message-ID: <1285245703.32001.19.camel@thorin>
References: <1282321333.25235.0.camel@thorin>
	 <alpine.LNX.2.00.1009231323340.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4185 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753529Ab0IWMmL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 Sep 2010 08:42:11 -0400
In-Reply-To: <alpine.LNX.2.00.1009231323340.26813@pobox.suse.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kbuild@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>, Andi Kleen <andi@firstfloor.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, MXns RullgXrd <mans@mansr.com>, linux-sparse@vger.kernel.org

Also Cc:ed linux-sparse@vger.kernel.org

On Don, 2010-09-23 at 13:23 +0200, Jiri Kosina wrote:
> On Fri, 20 Aug 2010, Bernd Petrovitsch wrote:
> 
> > Rationale: With a somewhat current gcc (or a somewhat sane peephole
> > optimizer), the (expensive) "div" is converted to a "shift" or
> > "mul" with the inverse.
> > This warning is disabled per default in sparse but the "-Wall" in
> > the kernels CFLAGS enables it.
> > 
> > Signed-off-by: Bernd Petrovitsch <bernd@sysprog.at>
> > ---
> > This patch is trivial and affects only calls to sparse (read: make C=1) and
> > removes false warnings. So it should be considered for inclusion immediately.
> > 
> > Sorry for the long Cc: - I included everyone in the thread and added
> > linux-kbuild@ (as it IMHO belongs there) and trivial@ (because of the
> > complexity of the patch).
> > 
> >  Makefile |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index f3bdff8..851c0fa 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -330,7 +330,7 @@ PERL		= perl
> >  CHECK		= sparse
> >  
> >  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
> > -		  -Wbitwise -Wno-return-void $(CF)
> > +		  -Wbitwise -Wno-return-void -Wno-ptr-subtraction-blows $(CF)
> >  CFLAGS_MODULE   =
> >  AFLAGS_MODULE   =
> >  LDFLAGS_MODULE  =
> 
> What is the status of this patch? I don't see it Nacked, but it's not in 
> linux-next either.

More details:

The head (as in
git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git) has "-Wall"
renamed to "-Wsparse-all". So the above patch is pretty pointless.

But sparse-0.4.2 - the latest release according to
https://sparse.wiki.kernel.org/index.php/Main_Page - hasn't that
renamed.

	Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services


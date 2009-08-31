From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: sparse segv with simple test
Date: Mon, 31 Aug 2009 08:57:58 -0700
Message-ID: <20090831085758.540365f2@nehalam>
References: <20090830153202.4dc5c58c@s6510>
	<200908310053.59138.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:59411 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872AbZHaP6C (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 31 Aug 2009 11:58:02 -0400
In-Reply-To: <200908310053.59138.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Mon, 31 Aug 2009 00:53:58 +0200
Kamil Dudka <kdudka@redhat.com> wrote:

> On Monday 31 of August 2009 00:32:02 Stephen Hemminger wrote:
> > I was checking up on some enum issues and tried running the following:
> > 	sparse -Wenum-mismatch enum.c
> > It dies here:
> > gdb) run -Wenum-mismatch e.c
> > Starting program: /home/shemminger/src/sparse/sparse -Wenum-mismatch enum.c
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x0805c81d in linearize_store_gen (ep=0xb7e7600c, value=0xb7e4e00c,
> >     ad=0xbfd43134) at linearize.h:293
> > 293		return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_VAL);
> > (gdb) where
> > #0  0x0805c81d in linearize_store_gen (ep=0xb7e7600c, value=0xb7e4e00c,
> >     ad=0xbfd43134) at linearize.h:293
> > #1  0x080609da in linearize_symbol (sym=0xb7e244cc) at linearize.c:1526
> > #2  0x080494bd in main (argc=-1209907772, argv=0xb7e245c4) at sparse.c:266
> > ------
> > #include <stdio.h>
> >
> > enum x { A, B, C };
> >
> > static enum x foo(int n) {
> > 	return (n > 0) ? A : B;
> > }
> >
> > int main(int ac, char **av) {
> > 	int x = foo(ac);
> > 	enum x y = 99;
> >
> > 	printf("%d %d\n", x, y);
> > 	return 0;
> > }
> 
> I am unable to reproduce the crash, tested with sparse 0.4.1 and current git 
> HEAD. Even no suspicious place reported by valgrind. Maybe your <stdio.h> is 
> the trigger. Could you please attach the preprocessed code?
> 
> Kamil

Not sure why, but the crash went away after a 'make clean; make' so maybe
something was stale on that machine?

It still doesn't give any warnings. about assigning an enum with a value
out of range thou.

-- 

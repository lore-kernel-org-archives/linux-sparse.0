From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: sparse segv with simple test
Date: Mon, 31 Aug 2009 11:49:00 -0700
Message-ID: <20090831114900.6887df23@nehalam>
References: <20090830153202.4dc5c58c@s6510>
	<200908310053.59138.kdudka@redhat.com>
	<20090831085758.540365f2@nehalam>
	<200908312012.37019.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:39710 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480AbZHaStE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 31 Aug 2009 14:49:04 -0400
In-Reply-To: <200908312012.37019.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Mon, 31 Aug 2009 20:12:36 +0200
Kamil Dudka <kdudka@redhat.com> wrote:

> On Monday 31 of August 2009 17:57:58 Stephen Hemminger wrote:
> > Not sure why, but the crash went away after a 'make clean; make' so maybe
> > something was stale on that machine?
> 
> Could be ... outdated depfiles, skewed mtimes, etc.
> 
> > It still doesn't give any warnings. about assigning an enum with a value
> > out of range thou.
> 
> AFAICT it is not supposed to issue a warning in that case. Here is an example 
> which is caught by the check:
> 
> static void f(void) {
>     enum A { VAL_A } a = VAL_A;
>     enum B { VAL_B } b = a;
> }
> 
> $ sparse enum.c
> enum.c:3:26: warning: mixing different enum types
> enum.c:3:26:     int enum A  versus
> enum.c:3:26:     int enum B
> 
> Note that you don't even need to write -Wenum-mismatch since it's default.
> 
> But it might be good idea to implement such out-of-range detection ;-)

Yes, I was looking to use more enum's in places where int was used in the
kernel. There were places where the interface expected a limit range of
values like network device transmit, but the interface was being misused
and caller was returning errno values.

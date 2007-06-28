From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 07:23:56 +0100
Message-ID: <20070628062355.GF21478@ftp.linux.org.uk>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk> <46834FA0.8010201@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:53320 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666AbXF1GX6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:23:58 -0400
Content-Disposition: inline
In-Reply-To: <46834FA0.8010201@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Wed, Jun 27, 2007 at 11:05:20PM -0700, Josh Triplett wrote:
> Al Viro wrote:
> > On Thu, Jun 28, 2007 at 01:39:59AM -0400, Pavel Roskin wrote:
> >> Use the actual sizeof values at the compile time to describe the default
> >> target.  If sparse is compiled on a 64-bit system, it will default to a
> >> 64-bit system now.
> >>
> >> To force 32-bit operation on 64-bit systems, recognize -m32.  Reject
> >> machine options other than -m32 and -m64.
> > 
> > NAK.  That makes life very painful for cross-builds.
> 
> And the current approach of hard-coding all the sizes doesn't?
> 
> While I agree that I'd like a better approach (specifically, I want any Sparse
> build to support any target arch), I don't yet have a solution for that, and
> this patch does at least seem like an improvement over the current hardcoded
> values.

At least it guarantees behaviour that depends only on the arguments you
pass to sparse and is consistent between the boxen you run sparse _on_.

FWIW, one of the pending patches in my tree makes default size_t unsigned
int, switches it upon -m64 and adds explicit -msize-long for forcing the
same in absense of -m64 (i.e. for 32bit target that has size_t declared
as unsigned long).

The reason why it becomes needed is that with proper typechecking on
comparisons we get every bloody target with size_t declared as unsigned
int (i.e. practically all 32bit ones; the only exception I've seen
is s390 31bit which uses unsigned long) complaining about every
min((size_t)n, sizeof(v)) in the kernel - the second argument becomes
sparse idea of size_t, the first one - kernel idea of size_t and
safety check in min() consist of comparing pointers to types of arguments.

That rule (no m64 => size_t is unsigned int, m64 => unsigned long) gives
a very good approximation and all deviations from it are for 32bit
targets with unsigned long instead of unsigned int.

Having types based on the host sparse is built on is utter insanity -
if anything, we need to be very careful about leaking them into
sparse operations.  Just take a look at what portability nightmare
binutils had become due to that approach...

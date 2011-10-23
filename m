From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC/PATCH 2/2] sparse: Use native sizes for data types
Date: Sun, 23 Oct 2011 10:13:24 -0700
Message-ID: <20111023171324.GA2940@leaf>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
 <1319373420-8967-2-git-send-email-penberg@cs.helsinki.fi>
 <4EA4385C.1050800@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59486 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab1JWRNg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 23 Oct 2011 13:13:36 -0400
Content-Disposition: inline
In-Reply-To: <4EA4385C.1050800@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: penberg@cs.helsinki.fi, linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Oct 23, 2011 at 11:53:00AM -0400, Jeff Garzik wrote:
> On 10/23/2011 08:37 AM, penberg@cs.helsinki.fi wrote:
> >From: Pekka Enberg<penberg@kernel.org>
> >
> >This patch is needed to fix the sparsec LLVM backend data type sizes.
> >
> >Cc: Christopher Li<sparse@chrisli.org>
> >Cc: Jeff Garzik<jgarzik@redhat.com>
> >Cc: Linus Torvalds<torvalds@linux-foundation.org>
> >Signed-off-by: Pekka Enberg<penberg@kernel.org>
> >---
> >  target.c |   10 +++++-----
> >  1 files changed, 5 insertions(+), 5 deletions(-)
> >
> >diff --git a/target.c b/target.c
> >index 6a535bc..009002f 100644
> >--- a/target.c
> >+++ b/target.c
> >@@ -17,9 +17,9 @@ int max_alignment = 16;
> >  int bits_in_bool = 8;
> >  int bits_in_char = 8;
> >  int bits_in_short = 16;
> >-int bits_in_int = 32;
> >-int bits_in_long = 32;
> >-int bits_in_longlong = 64;
> >+int bits_in_int = sizeof(int) * 8;
> >+int bits_in_long = sizeof(long) * 8;
> >+int bits_in_longlong = sizeof(long long) * 8;
> >  int bits_in_longlonglong = 128;
> >
> >  int max_int_alignment = 4;
> >@@ -36,8 +36,8 @@ int max_fp_alignment = 8;
> >  /*
> >   * Pointer data type
> >   */
> >-int bits_in_pointer = 32;
> >-int pointer_alignment = 4;
> >+int bits_in_pointer = sizeof(void *) * 8;
> >+int pointer_alignment = sizeof(void *);
> 
> No objection, but ideally we should select from a target template.
> 
> We don't want to start down the road of making runtime target
> switching (i386/x86-64) difficult.

Agreed.  The platform that sparse checks code for should not necessarily
correlate with what sparse observes at compile-time about the build
platform.

- Josh Triplett

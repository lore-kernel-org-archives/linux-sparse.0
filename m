From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Staging/comedi: Fixes static analysis warning raised by
 sparse
Date: Sun, 15 Jun 2014 21:32:27 +0200
Message-ID: <20140615193227.GA24515@ravnborg.org>
References: <53965E53.5080504@gmail.com>
 <20140610054741.GE5500@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9AE6A@P3PWEX4MB008.ex4.secureserver.net>
 <20140611065612.GQ5015@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
 <20140611212425.GW5015@mwanda>
 <20140611214529.GB16940@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:44946 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaFOTlE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 15 Jun 2014 15:41:04 -0400
Content-Disposition: inline
In-Reply-To: <20140611214529.GB16940@cloud>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@joshtriplett.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Hartley Sweeten <HartleyS@visionengravers.com>, "Marcos A. Di Pietro" <marcosadp@gmail.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, linux-sparse@vger.kernel.org

Hi Josh.

On Wed, Jun 11, 2014 at 02:45:29PM -0700, josh@joshtriplett.org wrote:
> On Thu, Jun 12, 2014 at 12:24:25AM +0300, Dan Carpenter wrote:
> > Let's forward this to the Sparse mailing list.
> > 
> > We're seeing a Sparse false positive testing
> > drivers/staging/comedi/drivers/ni_pcimio.c.
> > 
> >   CHECK   drivers/staging/comedi/drivers/ni_pcimio.c
> > drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
> > drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
> > drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
> > drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
> > 
> > I have created some test code to demonstrate the problem (attached).
> > 
> > The check_shift_count() warning is only supposed to be printed for
> > number literals but because of the way inline functions are expanded it
> > still complains even though channel is a variable.
> 
> Thanks for the test case; this definitely makes no sense.  I don't think
> Sparse will suddenly develop enough range analysis or reachability
> analysis to handle this case; I think the right answer is to avoid
> giving such warnings for shifts with a non-constant RHS.

Something like the appended?

It seems to work for me - and it cured a lot of warnings in math-emu.c on sparc.
If it looks OK I will do a proper patch submission.

	Sam


diff --git a/expand.c b/expand.c
index 0f6720c..4a96de4 100644
--- a/expand.c
+++ b/expand.c
@@ -187,7 +187,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 		return 0;
 	r = right->value;
 	if (expr->op == SPECIAL_LEFTSHIFT || expr->op == SPECIAL_RIGHTSHIFT) {
-		if (r >= ctype->bit_size) {
+		if (expr->flags & Int_const_expr && r >= ctype->bit_size) {
 			if (conservative)
 				return 0;
 			r = check_shift_count(expr, ctype, r);



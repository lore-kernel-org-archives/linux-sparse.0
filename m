From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Wed, 26 Feb 2014 19:38:46 -0800
Message-ID: <1393472326.24588.82.camel@joe-AO722>
References: <530E6F76.1070605@zytor.com>
	 <1393462087.24588.50.camel@joe-AO722> <530E8C2E.7080307@zytor.com>
	 <1393466619.24588.65.camel@joe-AO722> <20140227022857.GC23659@thin>
	 <1393469594.24588.71.camel@joe-AO722> <20140227025845.GA25145@thin>
	 <530EB103.5070406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:59947 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751929AbaB0Div (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 26 Feb 2014 22:38:51 -0500
In-Reply-To: <530EB103.5070406@zytor.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, Ben Pfaff <blp@nicira.com>, Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

(adding Ben Pfaff and Christopher Li)

On Wed, 2014-02-26 at 19:29 -0800, H. Peter Anvin wrote:
> On 02/26/2014 06:58 PM, Josh Triplett wrote:
> > On Wed, Feb 26, 2014 at 06:53:14PM -0800, Joe Perches wrote:
> >> Allow an override to emit or not the sizeof(bool) warning
> >> Add a description to the manpage.
> >>
> >> Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> > 
> 
> I have to admit that this particular warning is a bit odd to me.  I'm
> wondering what kind of bugs it was intended to catch.
> 
> In particular, things that incorrectly assumes the size of bool to be
> anything in particular would seem unlikely to actually use sizeof().

Dunno, the commit log for the commit that added it doesn't quite
match the code and is seemingly unaware that the c99 spec doesn't
specify sizeof(bool).

Ben Pfaff <blp@nicira.com>
Date:   Wed May 4 16:39:54 2011 -0700

    evaluate: Allow sizeof(_Bool) to succeed.
    
    Without this commit, sizeof(_Bool) provokes an error with "cannot size
    expression" because _Bool is a 1-bit type and thus not a multiple of a full
    byte in size.  But sizeof(_Bool) is valid C that should evaluate to 1, so
    this commit fixes the problem and adds a regression test.
    
    Signed-off-by: Ben Pfaff <blp@nicira.com>
    Signed-off-by: Christopher Li <sparse@chrisli.org>



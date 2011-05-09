From: Ben Pfaff <blp@nicira.com>
Subject: Re: [PATCH] evaluate: Allow sizeof(_Bool) to succeed.
Date: Mon, 9 May 2011 13:02:31 -0700
Message-ID: <20110509200231.GG2971@nicira.com>
References: <1304552394-16280-1-git-send-email-blp@nicira.com>
 <BANLkTikHwADf5Kv5=rQosKcNjsMYM-28wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 173-167-111-49-sfba.hfc.comcastbusiness.net ([173.167.111.49]:1681
	"EHLO leadville.nicira.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751726Ab1EIUCd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 May 2011 16:02:33 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikHwADf5Kv5=rQosKcNjsMYM-28wQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Sat, May 07, 2011 at 01:37:04PM -0700, Christopher Li wrote:
> On Wed, May 4, 2011 at 4:39 PM, Ben Pfaff <blp@nicira.com> wrote:
> > Without this commit, sizeof(_Bool) provokes an error with "cannot size
> > expression" because _Bool is a 1-bit type and thus not a multiple of a full
> > byte in size. ?But sizeof(_Bool) is valid C that should evaluate to 1, so
> > this commit fixes the problem and adds a regression test.
> 
> The sizeof _Bool is implementation define. Gcc make sizeof(_Bool) as 1.
> I modify your patch to issue an warning. Applied and pushed.
> 
> The incremental change follows. Please check that works for you or not.

Thank you for applying my patch.  It does work for me, in the sense
that I get a warning instead of an error now, but I'm not so happy to
get any diagnostic at all.  Is there some reason why sizeof(_Bool)
warrants a warning when, say, sizeof(long) does not?  After all, both
sizes are implementation defined.

Thanks,

Ben.

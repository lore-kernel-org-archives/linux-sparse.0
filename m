From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 3/5] Add (more) support for WIN32 attribute names
Date: Thu, 24 May 2007 10:24:14 -0700
Message-ID: <20070524102414.a3c177c7.rdunlap@xenotime.net>
References: <46532FD5.6000307@ramsay1.demon.co.uk>
	<465373D1.9060303@freedesktop.org>
	<4655B647.6000708@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:52144 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750762AbXEXRR7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 13:17:59 -0400
Received: from midway.site ([71.245.96.31]) by xenotime.net for <linux-sparse@vger.kernel.org>; Thu, 24 May 2007 10:17:52 -0700
In-Reply-To: <4655B647.6000708@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Josh Triplett <josh@freedesktop.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, 24 May 2007 16:59:03 +0100 Ramsay Jones wrote:

> Indeed, all 5 patches have whitespace damage ;-(
> Sorry for messing that up. I was under the (false) impression that I had knocked
> Thunderbird into submission on this issue; my git patch submissions had not been
> rejected, so I just assumed everything was OK. However, it appears that, after
> inspecting the git patch e-mails left in my sent folder, all my git patches have
> suffered the same problem. (ie Junio has been silently fixing them up! - oops).
> 
> After much study last night, it seems that the pattern of corruption is: for all
> lines that start with a space, insert an extra space, except for lines which
> consist of a single space, which is removed instead. 8-)
> 
> However, it seems that after setting "mailnews.send_plaintext_flowed" as you
> suggest above, the extra space is no longer being inserted. The elimination of
> the lone space is still happening, but git-apply seems to be OK with it!

This may help with tbird:
http://mbligh.org/linuxdocs/Email/Clients/Thunderbird

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

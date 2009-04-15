From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Novafora relicenses Transmeta sparse copyrights under the MIT
 license
Date: Tue, 14 Apr 2009 17:06:15 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904141701110.4132@localhost.localdomain>
References: <49E51310.3050005@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54213 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949AbZDOAIj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 14 Apr 2009 20:08:39 -0400
In-Reply-To: <49E51310.3050005@zytor.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-sparse@vger.kernel.org, Robert Bedichek <rbedichek@novafora.com>



On Tue, 14 Apr 2009, H. Peter Anvin wrote:
> 
> Novafora has agreed to relicense the copyrights in sparse that were previously
> owned by Transmeta (i.e. the work Linus did before 2003-07-01) under the MIT
> license.
> 
> Git repository:
> 
> http://git.kernel.org/?p=devel/sparse/novafora/sparse.git;a=summary

That commit is also merged into my copy of sparse at

        http://git.kernel.org/?p=linux/kernel/git/torvalds/sparse.git;a=summary

but it's mixed in with some of my other local changes (warnings for weak 
functions being used in the same compilation unit - it triggers a bug in 
some gcc versions), so if you want just the relicensing it's probably 
better to pull the 'Novafora' branch from the repo Peter points to.

Now, to actually relicense all of git we need to get all other authors to 
agree, but I think we pretty much had that agreement already several years 
ago. I'm certainly personally ok with just going with the MIT license, but 
if people want something else, then obviously that license is compatible 
with a lot of other open-source licenses..

		Linus

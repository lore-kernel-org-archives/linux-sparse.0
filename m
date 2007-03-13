From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Sparse homepage moved; Git repository moving soon [Re: update
 'getting sparse' info.]
Date: Tue, 13 Mar 2007 16:31:55 -0700
Message-ID: <45F7346B.6040605@zytor.com>
References: <20070309004526.GA17459@redhat.com> <45F0B45C.9060706@zytor.com> <Pine.LNX.4.64.0703091039280.10832@woody.linux-foundation.org> <45F1AD49.1080604@zytor.com> <45F73351.5080505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:49685 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbXCMXcH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Mar 2007 19:32:07 -0400
In-Reply-To: <45F73351.5080505@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, ftpadmin@kernel.org

Josh Triplett wrote:
> 
> However, I know that other people sometimes maintain Sparse Git repositories,
> and as far as I can tell, "people" directories only exist under
> /pub/linux/kernel/people.  Where should people keep Sparse repos, if not
> there?
> 

What we do is to, on request, create directories like 
/pub/scm/devel/sparse/<username> for that kind of stuff.  Let us know 
who needs them.  (This is one of many reasons you tend to see 
/pub/scm/foo/bar/bar.git as the repository path, another one is so the 
maintainer can create additional repositories as needed.)

> Also, if possible, I'd like to have an HTTP 301 redirect from
> http://kernel.org/pub/linux/kernel/people/josh/sparse (and everything under
> it, via RedirectMatch) to the corresponding page under the new homepage at
> http://kernel.org/pub/software/devel/sparse .  Could someone with the
> appropriate access please do so, or let me know if I can do so somehow?

I *think* you can just put an .htaccess file in your directory to have 
that happen.  However, please note that the URL should be 
http://www.kernel.org/... ; it may matter in the future.

	-hpa

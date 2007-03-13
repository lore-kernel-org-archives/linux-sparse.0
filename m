From: Josh Triplett <josh@kernel.org>
Subject: Sparse homepage moved; Git repository moving soon [Re: update 'getting
 sparse' info.]
Date: Tue, 13 Mar 2007 16:27:13 -0700
Message-ID: <45F73351.5080505@kernel.org>
References: <20070309004526.GA17459@redhat.com> <45F0B45C.9060706@zytor.com> <Pine.LNX.4.64.0703091039280.10832@woody.linux-foundation.org> <45F1AD49.1080604@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:55174 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbXCMXeA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Mar 2007 19:34:00 -0400
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@kernel.org>)
          by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 13 Mar 2007 23:27:18 -0000
In-Reply-To: <45F1AD49.1080604@zytor.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ftpadmin@kernel.org, "H. Peter Anvin" <hpa@zytor.com>

H. Peter Anvin wrote:
> Linus Torvalds wrote:
>> On Thu, 8 Mar 2007, H. Peter Anvin wrote:
>>> Please don't put non-kernel software in /pub/linux/kernel and
>>> /pub/scm/linux/kernel on kernel.org.
>>>
>>> IN PARTICULAR, if Josh is the new sparse maintainer, please contact
>>> ftpadmin@kernel.org so we can either create a group or simply chown the
>>> standard locations (/pub/software/devel/sparse, /pub/scm/devel/sparse) to him
>>> instead of leaving stale stuff where people can find it!
>> Yes, let's just do that. Whoever has the right magic touch, please just 
>> chown those things to Josh.
> 
> Done.

I have moved the Sparse homepage to
http://kernel.org/pub/software/devel/sparse .  (That location previously
contained an old BK repo of Sparse; I tarred that up and saved it if anyone
wants it for some reason, but I think the Git repo contains the history.)

I will soon move the Git repository as well, to the original location at
/pub/scm/devel/sparse/sparse.git .  I will likely maintain a symlink from my
current repo's location, to avoid gratuitously breaking people's checkouts or
automated scripts.

However, I know that other people sometimes maintain Sparse Git repositories,
and as far as I can tell, "people" directories only exist under
/pub/linux/kernel/people.  Where should people keep Sparse repos, if not
there?

Also, if possible, I'd like to have an HTTP 301 redirect from
http://kernel.org/pub/linux/kernel/people/josh/sparse (and everything under
it, via RedirectMatch) to the corresponding page under the new homepage at
http://kernel.org/pub/software/devel/sparse .  Could someone with the
appropriate access please do so, or let me know if I can do so somehow?

- Josh Triplett

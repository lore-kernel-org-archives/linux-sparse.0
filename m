From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/5] Add (more) support for WIN32 attribute names
Date: Thu, 24 May 2007 16:59:03 +0100
Message-ID: <4655B647.6000708@ramsay1.demon.co.uk>
References: <46532FD5.6000307@ramsay1.demon.co.uk> <465373D1.9060303@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:4224 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752180AbXEXROa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 13:14:30 -0400
In-Reply-To: <465373D1.9060303@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Josh Triplett wrote:
> Your patch seems to have some whitespace damage in the form of extra leading
> spaces.  I've manually modified it to apply this time, but please figure out
> what causes these patches to break and fix it.  You may want to test by
> sending patches to yourself and trying to apply them.  I notice that you use
> Thunderbird; format=flowed may cause the problem, so try turning it off by
> disabling the preference mailnews.send_plaintext_flowed .  You can do so
> either via Edit -> Preferences -> Advanced -> Config Editor; alternatively, if
> you have Enigmail installed, it offers a checkbox to turn off format=flowed in
> its preferneces.
> 

Indeed, all 5 patches have whitespace damage ;-(
Sorry for messing that up. I was under the (false) impression that I had knocked
Thunderbird into submission on this issue; my git patch submissions had not been
rejected, so I just assumed everything was OK. However, it appears that, after
inspecting the git patch e-mails left in my sent folder, all my git patches have
suffered the same problem. (ie Junio has been silently fixing them up! - oops).

After much study last night, it seems that the pattern of corruption is: for all
lines that start with a space, insert an extra space, except for lines which
consist of a single space, which is removed instead. 8-)

However, it seems that after setting "mailnews.send_plaintext_flowed" as you
suggest above, the extra space is no longer being inserted. The elimination of
the lone space is still happening, but git-apply seems to be OK with it!

I have regenerated the patch e-mails, done a "Save As" from the unsent folder,
converted the resulting *.eml files to unix line ending and verified that they
apply using:

    $ git apply --check --verbose --stat $patch-file

NOTE: git-apply will fail if the *.eml files have cr-lf line ending.

I hope you don't mind if I resend the e-mails to confirm they have been fixed.
(I have removed the mailing-list from the cc:, so as not to spam the list)

By the way, the second patch did not reach the list, because it had three
uppercase x chars in the subject and was bounced by the vger spam blocker ;-)

ATB,

Ramsay Jones

From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 7] Adding the interrupt checker
Date: Thu, 01 Mar 2007 01:07:06 -0500
Message-ID: <1172729226.2337.31.camel@dv>
References: <20070210002604.GA20748@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:45994 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbXCAGHK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 1 Mar 2007 01:07:10 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HMePz-00041I-Kp
	for linux-sparse@vger.kernel.org; Thu, 01 Mar 2007 01:05:31 -0500
In-Reply-To: <20070210002604.GA20748@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

Hello!

On Fri, 2007-02-09 at 16:26 -0800, Christopher Li wrote:
> Changelog:
>  - Using the new inline function calling annotation to find
>    out the irq related call. It now works both inline and
>    external functions. Bonus is no more x86 asm any more.
>  - The noise level of interrupt check drop considerably.
>    I think it is less nosier than the context checking.
> 
> Signed-off-by: Christopher Li<sparse@chrisli.org>
[skip]
> +	static const char *enable[] = {
> +		"raw_local_irq_enable",
> +		"raw_safe_halt",
> +		"_spin_unlock_irq",
> +		"_read_unlock_irq",
> +		"_write_unlock_irq",
> +		"schedule",		// XXX: is it always true?
> +	};

Sorry for late comments.  I actually applied the series to my copy of
sparse, and I found today that it catches schedule() for no reason.

"schedule" doesn't belong here.  It doesn't enable or disable
interrupts.  However, it requires interrupts to be enabled.  Annotating
functions requiring a specific context is not covered by your patch, so
I think it would be better to drop "schedule" from this list.

This patch helped me find some places where interrupts were disabled and
enabled twice.  But the output is confusing:

/home/proski/src/madwifi/net80211/ieee80211_node.c:1631:2: warning:
checker function ieee80211_timeout_stations double enable

It's not even clear that the message is about interrupts.  And the
"checker function" part is quite useless.  See other sparse warnings to
compare the style.

I think the patch is mildly useful, but shouldn't be applied as is.

Moreover, I think that incorrect use of locking is a remaining major
issue not covered by sparse.  Runtime checks only cover the code that is
executed.  Besides, the don't enforce better coding style.

I think all functions capable of supporting atomic contexts should be
annotated as such, and sparse should be always aware of the allowed
locking contexts for the code.

This would be a major, major change, perhaps more intrusive than the
endianess annotation.  But I think it would be worth the trouble.  It
would probably catch hundreds of bugs capable of hosing a working
system.

Another nice feature would be to annotate data so that it can be
accessed with certain locks held.  That would catch even more bugs, but
first sparse should be made lock aware.

-- 
Regards,
Pavel Roskin

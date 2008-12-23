From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Casting away noderef and address spaces?
Date: Mon, 22 Dec 2008 17:25:49 -0800
Message-ID: <70318cbf0812221725p583010d6u2c4cafb9d3215546@mail.gmail.com>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
	 <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
	 <20081222213953.GN28946@ZenIV.linux.org.uk>
	 <70318cbf0812221433y62197ec7y851f00fa5775f150@mail.gmail.com>
	 <20081222225708.GA4074@uranus.ravnborg.org>
	 <f19298770812221553n5281505ex611e8e6f6fa1f0c2@mail.gmail.com>
	 <1229990125.11628.0.camel@johannes>
	 <f19298770812221620s7ef34b9co55f1650220750b38@mail.gmail.com>
	 <1229992670.11628.4.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:39402 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYLWBZv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 20:25:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2163779rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 17:25:50 -0800 (PST)
In-Reply-To: <1229992670.11628.4.camel@johannes>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Mon, Dec 22, 2008 at 4:37 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2008-12-23 at 03:20 +0300, Alexey Zaytsev wrote:
>
>> By the way, are you sure the latest series you have sent is correct? To me it
>> seems that it does not make any warnings go away, and adds quite some more:
>> http://zaytsev.su/tmp/build.diff.txt
>
> include/net/sch_generic.h:225:2: warning: label 'continue' already bound
>
> This, of course, shouldn't happen. I thought I'd fixed it, but who
> knows. I think it should all just be reverted :)

Hi,

Do you want to resend your change which revert the context changes?
Make it base on Josh's git's tree and I will merge your changes in my
branch.

It will take me a while to get up to speed with the git goodness.
I will start with merging Alexey's resend patches.

Chris

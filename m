From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Casting away noderef and address spaces?
Date: Wed, 24 Dec 2008 00:34:07 -0800
Message-ID: <70318cbf0812240034kd5160a9iaa34f526c6d9c378@mail.gmail.com>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <20081222213953.GN28946@ZenIV.linux.org.uk>
	 <70318cbf0812221433y62197ec7y851f00fa5775f150@mail.gmail.com>
	 <20081222225708.GA4074@uranus.ravnborg.org>
	 <f19298770812221553n5281505ex611e8e6f6fa1f0c2@mail.gmail.com>
	 <1229990125.11628.0.camel@johannes>
	 <f19298770812221620s7ef34b9co55f1650220750b38@mail.gmail.com>
	 <1229992670.11628.4.camel@johannes>
	 <70318cbf0812221725p583010d6u2c4cafb9d3215546@mail.gmail.com>
	 <1230026362.3046.4.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:59525 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbYLXIeI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Dec 2008 03:34:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2760705rvb.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2008 00:34:07 -0800 (PST)
In-Reply-To: <1230026362.3046.4.camel@johannes>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Tue, Dec 23, 2008 at 1:59 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Below. Or I can give it to you in git if you prefer. I still think we
> should redo this in some form so that annotations with different
> contexts can work properly, but I don't have time to take care of it
> right now.

Thanks for the patch. It applied cleanly. I am still checking weather I use git
properly. I will publish my git tree soon.

Chris

From: Christopher Li <sparse@chrisli.org>
Subject: Re: including sparse headers in C++ code
Date: Mon, 11 Oct 2010 16:01:17 -0700
Message-ID: <AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<20101009205930.GA4684@feather>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	<20101011224656.GN19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48093 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab0JKXBS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 19:01:18 -0400
Received: by ywi6 with SMTP id 6so839746ywi.19
        for <linux-sparse@vger.kernel.org>; Mon, 11 Oct 2010 16:01:17 -0700 (PDT)
In-Reply-To: <20101011224656.GN19804@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tomas Klacko <tomas.klacko@gmail.com>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Mon, Oct 11, 2010 at 3:46 PM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Tue, Oct 12, 2010 at 12:33:32AM +0200, Tomas Klacko wrote:
>
>> Great. I am posting my current status (as a patch) so that you can c=
omment on it
>> and that I can refine it further.
>
> ehh... =A0Use of capitalized variable names is a Bad Idea(tm). =A0Esp=
ecially
> since you are doing that well outside of headers, so even compatibili=
ty
> with Straustrups's Mistake does not serve as a reason.

I am about to complain the same thing. Al beats me to it.

Tomas, can you limit the change on the header file C++ friendly first?
I don't think the rest of the C code need to be compile in C++, so it i=
s fine
using C++ key words.

Al, while you are here. What do you say regarding the true/false symbol=
 name
conflict with stdbool.h? I am fine with either way, more leading toward=
 leave it
as it is for now.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

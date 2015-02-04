From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Avoid reuse of string buffer when concatening adjacent
 string litterals
Date: Tue, 3 Feb 2015 19:26:05 -0800
Message-ID: <CANeU7Q=op73uMi-q-+fpZ1b+apf_FGbeCBFNcBADMOdfgOYoMQ@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204003208.GA8867@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:47320 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbBDD0H (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Feb 2015 22:26:07 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so36946151qac.13
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 19:26:05 -0800 (PST)
In-Reply-To: <20150204003208.GA8867@macbook.lan>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 3, 2015 at 4:32 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Now thinking about it, it's obvious that the string buffer can't be reused at all
> if there is any kind of expansion done on it, the adjacent strings concatenation
> make just the thing worse but are not the cause of it.
>
Right. That is what I think after reading your patch too.
String concatenation is a not a good indicator on macro expand.
There should be a fix base on the macro expand.

Even though I haven't construct an test case like Rasmus did.

Chris

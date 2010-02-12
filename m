From: Christopher Li <sparse@chrisli.org>
Subject: Re: Warnings on global symbols accessed only from assembly code
Date: Thu, 11 Feb 2010 22:43:51 -0800
Message-ID: <70318cbf1002112243q7de5f692k632f156d769fd7fb@mail.gmail.com>
References: <20100212000052.GA6837@laptop>
	 <70318cbf1002111706n7011eecpdaeb8bb691f95087@mail.gmail.com>
	 <20100212014709.GA10748@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:8803 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0BLGny (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Feb 2010 01:43:54 -0500
Received: by qw-out-2122.google.com with SMTP id 5so34345qwi.37
        for <linux-sparse@vger.kernel.org>; Thu, 11 Feb 2010 22:43:52 -0800 (PST)
In-Reply-To: <20100212014709.GA10748@laptop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Thu, Feb 11, 2010 at 5:47 PM, Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> The case I faced was kernel's main entrance C method which should only be
> jumped to from bootstrap asm code. I think a declaration in such case will
> only give bogus function usage impressions.

How about give it some prototype which clearly indicate the function should
be only call from boot strap? e.g. BOOT_STRAP_ENTRY(function_name) which
expand it to a function prototype.

>
>> > Unfortunately the current `-Wno-decl' solution is a bit extreme: it
>> > turns off a very useful sparse feature (by design).
>>
>> Right, the problem is that sparse can't tell which functions are used in
>> asm files and only skip warning on those.
>>
>
> Would proposing an __attribute__ for such case be accepted in concept?

I don't thing it justify more non-stander attribute, which is
for-the-sake-of-sparse
thing as well.

Chris

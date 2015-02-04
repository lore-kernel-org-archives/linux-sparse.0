From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Avoid reuse of string buffer when concatening adjacent
 string litterals
Date: Wed, 4 Feb 2015 08:20:58 -0800
Message-ID: <CANeU7QmHRFMhYeeyQm=8MYs=C1B=qo8vn8DN=4zUPo8j8rZUow@mail.gmail.com>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204003208.GA8867@macbook.lan>
	<87r3u6ax5f.fsf@rasmusvillemoes.dk>
	<87mw4uaw8x.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:41029 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965489AbbBDQU6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Feb 2015 11:20:58 -0500
Received: by mail-qa0-f53.google.com with SMTP id n4so1798302qaq.12
        for <linux-sparse@vger.kernel.org>; Wed, 04 Feb 2015 08:20:58 -0800 (PST)
In-Reply-To: <87mw4uaw8x.fsf@rasmusvillemoes.dk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 4, 2015 at 12:58 AM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On Wed, Feb 04 2015, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
>> And I wasn't hallucinating, I was just overcomplicating things:
>>
>> #define NOT_TAB "\\t"
>>
>> static const char s1[] = NOT_TAB;
>> static const char s2[] = NOT_TAB;
>>
>> indeed fails.
>
> While we're collecting examples, let me also mention that __FILE__
> doesn't work for files with backslash in their name. Sane people of
> course don't put backslashes in file names, but they are a rather normal
> occurence in path names on a certain operating system.

Can you submit a patch for adding the test case you found?
I will include those into the the test suit.

Thanks

Chris

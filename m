From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] Avoid reuse of string buffer when concatening adjacent string litterals
Date: Fri, 06 Feb 2015 22:52:43 +0100
Message-ID: <874mqypv10.fsf@rasmusvillemoes.dk>
References: <87y4ojhq2f.fsf@rasmusvillemoes.dk>
	<20150131012339.GA3460@macpro.local>
	<87386mvcxh.fsf@rasmusvillemoes.dk>
	<20150204003208.GA8867@macbook.lan>
	<87r3u6ax5f.fsf@rasmusvillemoes.dk>
	<87mw4uaw8x.fsf@rasmusvillemoes.dk>
	<CANeU7QmHRFMhYeeyQm=8MYs=C1B=qo8vn8DN=4zUPo8j8rZUow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:58437 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbBFVws (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Feb 2015 16:52:48 -0500
Received: by mail-lb0-f170.google.com with SMTP id z11so7166062lbi.1
        for <linux-sparse@vger.kernel.org>; Fri, 06 Feb 2015 13:52:46 -0800 (PST)
In-Reply-To: <CANeU7QmHRFMhYeeyQm=8MYs=C1B=qo8vn8DN=4zUPo8j8rZUow@mail.gmail.com>
	(Christopher Li's message of "Wed, 4 Feb 2015 08:20:58 -0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 04 2015, Christopher Li <sparse@chrisli.org> wrote:

> On Wed, Feb 4, 2015 at 12:58 AM, Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> On Wed, Feb 04 2015, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>>
>>> And I wasn't hallucinating, I was just overcomplicating things:
>>>
>>> #define NOT_TAB "\\t"
>>>
>>> static const char s1[] = NOT_TAB;
>>> static const char s2[] = NOT_TAB;
>>>
>>> indeed fails.
>>
>> While we're collecting examples, let me also mention that __FILE__
>> doesn't work for files with backslash in their name. Sane people of
>> course don't put backslashes in file names, but they are a rather normal
>> occurence in path names on a certain operating system.
>
> Can you submit a patch for adding the test case you found?
> I will include those into the the test suit.

I'd like to, but I'm not sure how to write the test in terms of sparse's
test frame work. How do I check that the string is as expected? 

Rasmus

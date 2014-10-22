From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/4] cgcc: avoid passing a sparse-only option to cc
Date: Wed, 22 Oct 2014 08:23:39 +0800
Message-ID: <CANeU7Qk_H8fV_soAbtGjHXwKBw3BWJgABhNM+KFLmM-rVY4N8w@mail.gmail.com>
References: <54398BA5.6050005@ramsay1.demon.co.uk>
	<CANeU7QnOJTKK___Vb3VpN=_x62wVpS=A57UkTQrSz0-GYBF5rQ@mail.gmail.com>
	<543EAFFA.6070503@ramsay1.demon.co.uk>
	<CANeU7Q=ruQhu19sY=mDyiBmyDCGRR+xmRE7SzN9BcGLRZWX8Bw@mail.gmail.com>
	<5443C8F8.2000003@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:40578 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaJVAXl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Oct 2014 20:23:41 -0400
Received: by mail-qa0-f54.google.com with SMTP id i13so1673338qae.41
        for <linux-sparse@vger.kernel.org>; Tue, 21 Oct 2014 17:23:40 -0700 (PDT)
In-Reply-To: <5443C8F8.2000003@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>

On Sun, Oct 19, 2014 at 10:21 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Sorry for the late reply, it's been a busy few days. ;-)
>
> On 16/10/14 02:45, Christopher Li wrote:
>> Hi,
>>
>> I create a branch in the chrisl repo call "review-ramsay" for your new
>> follow up patches.
>> I plan to do incremental fix up if any on that branch. Then when we
>> both happy about it,
>> I will do rebase and smash the commit before push to master branch.
>
> Yes, I noticed the new branch - thanks!
>
> Did you have any thoughts regarding Josh Triplett's comments on the
> "compile-i386.c: don't ignore return value of write(2)" patch?

I am fine with either way. The current fix is fine. If you are up for
a new xwrite function, that is of course fine as well. Using printf()
is not much an improvement because printf() can still return
bytes less than the amount you requested.

>
> No, no, you don't want to do that even on Linux (let alone more
> exotic platforms like Windows, MinGW and cygwin).

In that case, I will leave the patch as it is. Thanks for the explain.

Chris

From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 04/10] compile-i386.c: don't mix calls to write(2) with stdio
Date: Tue, 30 Sep 2014 10:34:50 +0800
Message-ID: <CANeU7QnARF7N3Yz1h+XF-zqjYnN+XA54QRENNfpbs2Ayq5LbAA@mail.gmail.com>
References: <53DFD2B7.7080801@ramsay1.demon.co.uk>
	<CANeU7Qk7sDezqhW2mPNxLMHvJHxffgvSix_q5wjQ2DgJJaFmEQ@mail.gmail.com>
	<5426B508.9070005@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:35647 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbaI3Cev (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Sep 2014 22:34:51 -0400
Received: by mail-yh0-f54.google.com with SMTP id f10so2904834yha.13
        for <linux-sparse@vger.kernel.org>; Mon, 29 Sep 2014 19:34:50 -0700 (PDT)
In-Reply-To: <5426B508.9070005@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Sep 27, 2014 at 9:00 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>>> -       write(STDOUT_FILENO, s, strlen(s));
>>> +       printf("%s", s);
>>
>
> I was only really fixing the compiler warning (in an side-ways fashion).
> (although I think it is an improvement).

I would just check the return value and "die" if there is an error to silence
the error.

Chris

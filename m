From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 04/10] compile-i386.c: don't mix calls to write(2) with
 stdio
Date: Thu, 02 Oct 2014 11:27:43 +0100
Message-ID: <542D289F.9090701@ramsay1.demon.co.uk>
References: <53DFD2B7.7080801@ramsay1.demon.co.uk>	<CANeU7Qk7sDezqhW2mPNxLMHvJHxffgvSix_q5wjQ2DgJJaFmEQ@mail.gmail.com>	<5426B508.9070005@ramsay1.demon.co.uk> <CANeU7QnARF7N3Yz1h+XF-zqjYnN+XA54QRENNfpbs2Ayq5LbAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:47277 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751219AbaJBK1x (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Oct 2014 06:27:53 -0400
In-Reply-To: <CANeU7QnARF7N3Yz1h+XF-zqjYnN+XA54QRENNfpbs2Ayq5LbAA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 30/09/14 03:34, Christopher Li wrote:
> On Sat, Sep 27, 2014 at 9:00 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>>> -       write(STDOUT_FILENO, s, strlen(s));
>>>> +       printf("%s", s);
>>>
>>
>> I was only really fixing the compiler warning (in an side-ways fashion).
>> (although I think it is an improvement).
> 
> I would just check the return value and "die" if there is an error to silence
> the error.

Hmmm, I can change the patch to do that if you prefer.

Having said that, given that this is not currently maintained, what
do you think about a patch to remove it?

[Are you hoping someone will pick it up again soon?]

Let me know which patch you would like to see.

ATB,
Ramsay Jones




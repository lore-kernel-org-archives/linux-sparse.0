From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 04/10] compile-i386.c: don't mix calls to write(2) with
 stdio
Date: Sat, 27 Sep 2014 14:00:56 +0100
Message-ID: <5426B508.9070005@ramsay1.demon.co.uk>
References: <53DFD2B7.7080801@ramsay1.demon.co.uk> <CANeU7Qk7sDezqhW2mPNxLMHvJHxffgvSix_q5wjQ2DgJJaFmEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:37807 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751783AbaI0NBA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Sep 2014 09:01:00 -0400
In-Reply-To: <CANeU7Qk7sDezqhW2mPNxLMHvJHxffgvSix_q5wjQ2DgJJaFmEQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 27/09/14 03:13, Christopher Li wrote:
> Compile-i386 is pretty much not maintained any more.
> 
> On Tue, Aug 5, 2014 at 2:36 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>>
>> -       write(STDOUT_FILENO, s, strlen(s));
>> +       printf("%s", s);
> 
> This change fix nothing. "printf" can return how many bytes it is written.
> In the case that "write" can fail, "printf" can fail as well. e.g. disk full.
> This patch did not check the return value from printf either.

I was only really fixing the compiler warning (in an side-ways fashion).
(although I think it is an improvement).

If this is no longer being maintained, perhaps a patch to remove it
would be better?

ATB,
Ramsay Jones


